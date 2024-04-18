//
//  EditProfileViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/25/24.
//

import UIKit

import Amplitude

final class EditProfileViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Property
    var userGroupType: UserGroupType = UserManager.shared.groupType
    var universityTitleList = [StringLiterals.Profile.EditProfile.major,
                               StringLiterals.Profile.EditProfile.studentId]
    var highschoolTitleList = [StringLiterals.Profile.EditProfile.grade,
                               StringLiterals.Profile.EditProfile.schoolClass]
    
    // MARK: Component
    let editProfileView = EditProfileView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func loadView() {
        self.view = editProfileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editProfileView.profileTableView.reloadData()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    // MARK: Custom Function
    private func setDelegate() {
        editProfileView.profileTableView.dataSource = self
        editProfileView.profileTableView.delegate = self
        editProfileView.navigationBarView.handleBackButtonDelegate = self
    }
}

// MARK: - extension
// MARK: UITableViewDataSource
extension EditProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileTableViewCell.reusableId) as? EditProfileTableViewCell else { return UITableViewCell() }
        userGroupType = UserManager.shared.groupType
        switch indexPath.item {
        case 0:
            cell.configureCell(isEditable: false,
                               title: StringLiterals.Profile.EditProfile.name,
                               info: UserManager.shared.name)
        case 1:
            cell.configureCell(isEditable: false,
                               title: StringLiterals.Profile.EditProfile.id,
                               info: UserManager.shared.yelloId)
        case 2:
            cell.configureCell(isEditable: true,
                               title: StringLiterals.Profile.EditProfile.school,
                               info: UserManager.shared.groupName)
        case 3:
            if userGroupType == .univ || userGroupType == .SOPT {
                cell.configureCell(isEditable: true,
                                   title: universityTitleList[indexPath.item - 3],
                                   info: UserManager.shared.subGroupName)
            } else if userGroupType == .high || userGroupType == .middle {
                cell.configureCell(isEditable: true,
                                   title: highschoolTitleList[indexPath.item - 3],
                                   info: "\(UserManager.shared.groupAdmissionYear)학년")
            }
        case 4:
            if userGroupType == .univ || userGroupType == .SOPT {
                cell.configureCell(isEditable: true,
                                   title: universityTitleList[indexPath.item - 3],
                                   info: String(UserManager.shared.groupAdmissionYear))
            } else if userGroupType == .high || userGroupType == .middle {
                cell.configureCell(isEditable: true,
                                   title: highschoolTitleList[indexPath.item - 3],
                                   info: "\(UserManager.shared.subGroupName)반")
            }
        default:
            return cell
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: EditProfileHeaderView.reusableId) as? EditProfileHeaderView
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 155.adjustedHeight
    }
}

// MARK: UITableViewDelegate
extension EditProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item > 1 {
            Amplitude.instance().logEvent("click_profile_change")
            let editSchoolInfoViewController = EditSchoolInfoViewController()
            navigationController?.pushViewController(editSchoolInfoViewController, animated: true)
        }
    }
}

// MARK: HandleBackButtonDelegate
extension EditProfileViewController: HandleBackButtonDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
