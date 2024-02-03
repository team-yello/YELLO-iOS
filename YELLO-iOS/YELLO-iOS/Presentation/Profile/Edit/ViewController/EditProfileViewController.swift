//
//  EditProfileViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/25/24.
//

import UIKit

final class EditProfileViewController: BaseViewController {
    var userInfoList: [String?] = []
    var isUniversity: Bool = false
    var universityTitleList = [StringLiterals.Profile.EditProfile.major,
                               StringLiterals.Profile.EditProfile.studentId]
    var highschoolTitleList = [StringLiterals.Profile.EditProfile.grade,
                               StringLiterals.Profile.EditProfile.schoolClass]
    
    let editProfileView = EditProfileView()
    
    override func loadView() {
        self.view = editProfileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    override func setStyle() {
        if !userInfoList.isEmpty {
            editProfileView.editHeaderView.profileImageView.kfSetImage(url: userInfoList[0])
        }
    }
    
    private func setDelegate() {
        editProfileView.profileTableView.dataSource = self
        editProfileView.profileTableView.delegate = self
        editProfileView.navigationBarView.handleBackButtonDelegate = self
    }
}

extension EditProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileTableViewCell.reusableId) as? EditProfileTableViewCell else { return UITableViewCell() }
        if userInfoList.isEmpty {
            return cell
        } else {
            // v2 적용 후 변경 예정
            switch indexPath.item {
            case 0:
                cell.configureCell(isEditable: false,
                                   title: StringLiterals.Profile.EditProfile.name,
                                   info: userInfoList[1] ?? "")
            case 1:
                cell.configureCell(isEditable: false,
                                   title: StringLiterals.Profile.EditProfile.id,
                                   info: userInfoList[2] ?? "")
            case 2:
                cell.configureCell(isEditable: true,
                                   title: StringLiterals.Profile.EditProfile.school,
                                   info: "")
            case 3...4:
                if isUniversity {
                    cell.configureCell(isEditable: true,
                                       title: universityTitleList[indexPath.item - 3],
                                       info: "")
                } else {
                    cell.configureCell(isEditable: true,
                                       title: highschoolTitleList[indexPath.item - 3],
                                       info: "")
                }
            default:
                return cell
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: EditProfileHeaderView.reusableId) as? EditProfileHeaderView
        view?.profileImageView.kfSetImage(url: userInfoList[0])
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 155.adjustedHeight
    }
}

extension EditProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item > 1 {
            // 변경 가능 셀 부터
            navigationController?.pushViewController(EditSchoolInfoViewController(), animated: true)
        }
    }
}

extension EditProfileViewController: HandleBackButtonDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
