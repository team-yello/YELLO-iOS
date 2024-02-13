//
//  FindSchoolViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

class FindSchoolViewController: SearchBaseViewController {
    
    // MARK: - Variables
    // MARK: Property
    var userType: UserGroupType = UserManager.shared.groupType
    var pageCount: Int = 0
    var totalItemCount: Int = 0
    
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchResults.removeAll()
        searchView.searchResultTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTitle(titleText: StringLiterals.Onboarding.Search.schoolSearchTitle,
                    helperText: StringLiterals.Onboarding.Search.schoolHelperText)
        addTarget()
    }
    
    func addTarget() {
        searchView.searchResultTableView.delegate = self
        
        searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        searchView.helperButton.addTarget(self, action: #selector(helperButtonDidTap), for: .touchUpInside)
    }
    
    func searchSchool(_ word: String) {
        switch userType {
        case .univ, .SOPT:
            let schoolQueryDTO: SchoolSearchRequestQueryDTO = SchoolSearchRequestQueryDTO(keyword: word, page: pageCount)
            NetworkService.shared.onboardingService.getSchoolList(queryDTO: schoolQueryDTO) { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else { return }
                    DispatchQueue.main.async {
                        self.searchResults.append(contentsOf: data.groupNameList)
                        self.totalItemCount = data.totalCount
                        self.searchView.searchResultTableView.reloadData()
                    }
                default:
#if DEBUG
                    print("학교 검색 에러 발생\(ErrorPointer.self)")
#endif
                }
            }
        case .high, .middle:
            let queryDTO = HighSchoolSearchRequestQueryDTO(keyword: word, page: pageCount)
            NetworkService.shared.onboardingService.getHighSchoolList(queryDTO: queryDTO) { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else { return }
                    DispatchQueue.main.async {
                        self.searchResults.append(contentsOf: data.groupNameList)
                        self.totalItemCount = data.totalCount
                        self.searchView.searchResultTableView.reloadData()
                    }
                default:
#if DEBUG
                    print("학교 검색 에러 발생\(ErrorPointer.self)")
#endif
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.searchView.searchResultTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        self.searchView.searchTextField.endEditing(true)
        if offsetY > contentHeight - visibleHeight, searchResults.count < totalItemCount {
            pageCount += 1
            guard let text = searchView.searchTextField.text else { return }
            searchSchool(text)
        }
    }
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: YelloTextField) {
        textField.debounce(delay: 0.5) { text in
            guard let text = textField.text else { return }
            self.pageCount = 0
            self.searchResults.removeAll()
            self.searchSchool(text)
        }
    }
    
    @objc func helperButtonDidTap() {
        let url = userType == .high || userType == .middle ? URL(string: "https://forms.gle/sMyn6uq7oHDovSdi8")! : URL(string: "https://bit.ly/46Yv0Hc")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: - extension
// MARK: UITableViewDelegate
extension FindSchoolViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentCell = tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell,
           let selectedItem = searchResults[safe: indexPath.row] {
            schoolSearchDelegate?.didSelectSchoolResult(currentCell.titleLabel.text ?? "")
        } else {
#if DEBUG
            debugPrint("index가 잘못되었습니다. index out of range")
#endif
        }
        self.dismiss(animated: true)
    }
}
