//
//  EditSchoolInfoViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/30/24.
//

import UIKit

import SnapKit
import Then

final class EditSchoolInfoViewController: BaseViewController {
    // MARK: - Variables
    // MARK: Property
    var isEditAvailable: Bool = true
    var isMajorSearchError: Bool = false
    var groupName: String = UserManager.shared.groupName
    var subgroupName: String = UserManager.shared.subGroupName
    var groupAdmissionYear: Int = UserManager.shared.groupAdmissionYear
    var groupId: Int = UserManager.shared.groupId
    var userGroupType = UserManager.shared.groupType
    var lastEditDate: String = "" {
        didSet {
            editSchoolInfoView.modificationDateLabel.text?.append(lastEditDate)
        }
    }
    var createDate: String = ""
    
    // MARK: Component
    let editSchoolInfoView = EditSchoolInfoView()
    let studentIdViewController = StudentIdViewController()
    let schoolSearchViewController = FindSchoolViewController()
    let majorSearchViewController = FindMajorViewController()
    lazy var studentIdView = StudentIdView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func loadView() {
        self.view = editSchoolInfoView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkUpdateAvailable()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        setDelegate()
    }
    
    // MARK: Custom Function
    private func addTarget() {
        editSchoolInfoView.convertButton.addTarget(self, action: #selector(convertButtonTapped), for: .touchUpInside)
    }
    
    private func setDelegate() {
        editSchoolInfoView.editTableView.dataSource = self
        editSchoolInfoView.editTableView.delegate = self
        editSchoolInfoView.navigationBarView.handleSaveButtonDelegate = self
        editSchoolInfoView.navigationBarView.handleBackButtonDelegate = self
        schoolSearchViewController.schoolSearchDelegate = self
        majorSearchViewController.majorSearchDelegate = self
        studentIdViewController.delegate = self
    }
    
    private func updateProfile() {
        UserManager.shared.groupName = self.groupName
        UserManager.shared.subGroupName = self.subgroupName
        UserManager.shared.groupAdmissionYear = self.groupAdmissionYear
        UserManager.shared.groupId = self.groupId
        UserManager.shared.groupType = self.userGroupType
        
        let request = EditProfileRequestDTO(name: UserManager.shared.name,
                                            yelloID: UserManager.shared.yelloId,
                                            gender: UserManager.shared.gender,
                                            email: UserManager.shared.email,
                                            profileImageURL: UserManager.shared.profileImage,
                                            groupID: UserManager.shared.groupId,
                                            groupAdmissionYear: UserManager.shared.groupAdmissionYear)
        NetworkService.shared.profileService.editProfile(requestDTO: request) { result in
            switch result {
            case .success(let response):
                break
            default:
                print("프로필 변경 통신 실패")
            }
        }
    }
    
    func getSchoolClass(keyword: String) {
        let queryDTO = HighSchoolClassRequestQueryDTO(name: self.groupName, keyword: keyword)
        NetworkService.shared.onboardingService.getHighSchoolClass(queryDTO: queryDTO) { result in
            switch result {
            case .success(let data):
                if let data = data.data {
                    self.groupId = data.groupId
                }
            default:
                print("network Error")
            }
        }
    }
    
    private func checkUpdateAvailable() {
        NetworkService.shared.profileService.getAccountUpdateAt { result in
            switch result {
            case .success(let response):
                var valueArray: [String.SubSequence] = []
                if let data =  response.data {
                    valueArray = data.value.split(separator: "|")
                }
                if !valueArray.isEmpty {
                    self.isEditAvailable = valueArray[0] == "true" ? true : false
                    self.createDate = DateConverter.convertDateString(String(valueArray[2])) ?? ""
                    if valueArray[1] != "null" {
                        self.lastEditDate = DateConverter.convertDateString(String(valueArray[1])) ?? ""
                    } else {
                        // 변경한 이력이 없는 경우 프로필 생성일을 마지막 수정일로 설정
                        self.lastEditDate = self.createDate
                    }
                }
            default:
                print("프로필 수정 가능 여부 확인 실패")
            }
        }
    }
    
    // MARK: Objc Function
    @objc func convertButtonTapped() {
        schoolSearchViewController.searchResults.removeAll()
        schoolSearchViewController.searchView.searchResultTableView.reloadData()
        if userGroupType == .high || userGroupType == .middle {
            userGroupType = .univ
        } else {
            userGroupType = .high
        }
        isMajorSearchError = false
        groupName = StringLiterals.Profile.EditProfile.defaultText
        subgroupName =  userGroupType == .univ ? StringLiterals.Profile.EditProfile.defaultText : "1"
        groupAdmissionYear = userGroupType == .univ ? 24 : 1
        
        editSchoolInfoView.groupType = userGroupType
        editSchoolInfoView.editTableView.reloadData()
    }
}

// MARK: - extension
// MARK: UITableViewDataSource
extension EditSchoolInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EditSchoolInfoTableViewCell.reuseId, for: indexPath) as? EditSchoolInfoTableViewCell {
            switch indexPath.row {
            case 0:
                cell.isError = false
                cell.configureCell(iconType: .search,
                                   titleText: StringLiterals.Profile.EditProfile.school,
                                   InfoText: groupName)
            case 1:
                if userGroupType == .univ || userGroupType == .SOPT {
                    cell.isError = isMajorSearchError
                    cell.configureCell(iconType: .search,
                                       titleText: StringLiterals.Profile.EditProfile.major,
                                       InfoText: self.subgroupName)
                } else if userGroupType == .high || userGroupType == .middle {
                    cell.configureCell(iconType: .toggle,
                                       titleText: StringLiterals.Profile.EditProfile.grade,
                                       InfoText: "\(self.groupAdmissionYear)학년")
                }
            case 2:
                cell.isError = false
                if userGroupType == .univ || userGroupType == .SOPT {
                    cell.configureCell(iconType: .toggle,
                                       titleText: StringLiterals.Profile.EditProfile.studentId,
                                       InfoText: String(self.groupAdmissionYear))
                } else if userGroupType == .high || userGroupType == .middle {
                    cell.configureCell(iconType: .toggle,
                                       titleText: StringLiterals.Profile.EditProfile.schoolClass,
                                       InfoText: "\(subgroupName)반")
                }
            default:
                break
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: UITableViewDelegate
extension EditSchoolInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            schoolSearchViewController.userType = userGroupType
            self.present(schoolSearchViewController, animated: true)
        case 1:
            if userGroupType == .univ || userGroupType == .SOPT {
                majorSearchViewController.schoolName = groupName
                self.present(majorSearchViewController, animated: true)
            } else if userGroupType == .high || userGroupType == .middle {
                if userGroupType == .high || userGroupType == .middle {
                    studentIdViewController.selectType = .grade
                    studentIdViewController.studentIdList = (1...3).map { "\($0)학년" }
                }
                let nav = UINavigationController(rootViewController: studentIdViewController)
                let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
                if #available(iOS 16.0, *) {
                    let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
                        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                        let safeAreaBottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0
                        return 166.adjustedHeight - safeAreaBottom
                    }
                    if let sheet = nav.sheetPresentationController {
                        sheet.detents = [customDetent]
                        sheet.prefersGrabberVisible = true
                        present(nav, animated: true, completion: nil)
                    }
                } else {
                    if let sheet = nav.sheetPresentationController {
                        sheet.detents = [.medium()]
                        sheet.prefersGrabberVisible = true
                        present(nav, animated: true, completion: nil)
                    }
                }
            }
        case 2:
            if userGroupType == .high || userGroupType == .middle {
                studentIdViewController.selectType = .schoolClass
                studentIdViewController.studentIdList = (1...20).map { "\($0)반" }
            } else {
                studentIdViewController.selectType = .studentId
                studentIdViewController.studentIdList = (15...24).reversed().map { "\($0)학번" }
            }
            let nav = UINavigationController(rootViewController: studentIdViewController)
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                present(nav, animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 1 && isMajorSearchError {
            return 95.adjustedHeight
        }
        return 75.adjustedHeight
    }
}

// MARK: HandleBackButtonDelegate
extension EditSchoolInfoViewController: HandleBackButtonDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: HandleSaveButtonDelegate
extension EditSchoolInfoViewController: HandleSaveButtonDelegate {
    func saveModifiedInfo() {
        if subgroupName == StringLiterals.Profile.EditProfile.defaultText {
            isMajorSearchError = true
            editSchoolInfoView.editTableView.reloadData()
        }
        
        if groupName == UserManager.shared.groupName &&
            subgroupName == UserManager.shared.subGroupName &&
            groupAdmissionYear == UserManager.shared.groupAdmissionYear {
            self.view.showToast(message: StringLiterals.Profile.EditProfile.notYetErrorMessage, at: 82.adjustedHeight)
        }
        
        if isEditAvailable && !isMajorSearchError {
            updateProfile()
            navigationController?.popViewController(animated: true)
        } else if !isEditAvailable {
            self.view.showToast(message: StringLiterals.Profile.EditProfile.editDateErrorMessage, at: 82.adjustedHeight)
        }
    }
}

// MARK: SearchResultTableViewSelectDelegate
extension EditSchoolInfoViewController: SchoolSearchResultSelectDelegate {
    func didSelectSchoolResult(_ result: String) {
        groupName = result
        if userGroupType == .univ || userGroupType == .SOPT { subgroupName = StringLiterals.Profile.EditProfile.defaultText }
        editSchoolInfoView.editTableView.reloadData()
    }
}

// MARK: MajorSearchResultSelectDelegate
extension EditSchoolInfoViewController: MajorSearchResultSelectDelegate {
    func didSelectMajorResult(_ result: GroupList) {
        subgroupName = result.departmentName
        groupId = result.groupID
        isMajorSearchError = false
        print(result.departmentName)
        editSchoolInfoView.editTableView.reloadData()
    }
}

// MARK: SelectStudentIdDelegate
extension EditSchoolInfoViewController: SelectStudentIdDelegate {
    func didSelectStudentId(_ result: Int, type: SelectType) {
        if userGroupType == .high || userGroupType == .middle {
            if type == .grade {
                groupAdmissionYear = result
            } else if type == .schoolClass {
                subgroupName = "\(result)"
                getSchoolClass(keyword: String(result))
            }
        } else if userGroupType == .univ {
            groupAdmissionYear = result
        }
        editSchoolInfoView.editTableView.reloadData()
    }
}
