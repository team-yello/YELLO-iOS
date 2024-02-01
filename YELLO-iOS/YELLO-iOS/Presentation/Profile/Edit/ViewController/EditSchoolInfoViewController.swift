//
//  EditSchoolInfoViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/30/24.
//

import UIKit

import SnapKit
import Then

class EditSchoolInfoViewController: BaseViewController {
    let editSchoolInfoView = EditSchoolInfoView()
    let studentIdViewController = StudentIdViewController()
    lazy var studentIdView = StudentIdView()
    let bottomSheetViewController = BaseBottomViewController()
    
    override func loadView() {
        self.view = editSchoolInfoView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    private func setDelegate() {
        editSchoolInfoView.editTableView.dataSource = self
        editSchoolInfoView.editTableView.delegate = self
        editSchoolInfoView.navigationBarView.handleBackButtonDelegate = self
    }
}

extension EditSchoolInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EditSchoolInfoTableViewCell.reuseId, for: indexPath) as? EditSchoolInfoTableViewCell {
            switch indexPath.row {
            case 0:
                cell.configureCell(iconType: .search,
                                   titleText: StringLiterals.Profile.EditProfile.school,
                                   InfoText: "")
            case 1:
                cell.configureCell(iconType: .search,
                                   titleText: StringLiterals.Profile.EditProfile.major,
                                   InfoText: "")
            case 2:
                cell.configureCell(iconType: .toggle,
                                   titleText: StringLiterals.Profile.EditProfile.studentId,
                                   InfoText: "")
            default:
                break
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}

extension EditSchoolInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.present(FindSchoolViewController(), animated: true)
        case 1:
            self.present(FindMajorViewController(), animated: true)
        case 2:
            if #available(iOS 16.0, *) {
                let nav = UINavigationController(rootViewController: studentIdViewController)
                if let sheet = nav.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.prefersGrabberVisible = true
                    sheet.invalidateDetents()
                    present(nav, animated: true, completion: nil)
                }
            } else {
                bottomSheetViewController.setCustomView(view: studentIdView)
                bottomSheetViewController.modalPresentationStyle = .overFullScreen
                present(bottomSheetViewController, animated: false)
            }
            
        default:
            break
        }
    }
}

extension EditSchoolInfoViewController: HandleBackButtonDelegate {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
