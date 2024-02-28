//
//  FindMajorViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class FindMajorViewController: SearchBaseViewController {
    // MARK: - Variables
    // MARK: Property
    var allMajor: [GroupList] = []
    var schoolName: String = "" 
    var pageCount: Int = 0
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.customTitle(titleText: StringLiterals.Onboarding.Search.majorSearchTitle,
                          helperText: StringLiterals.Onboarding.Search.majorHelperText )
        addTarget()
        setDelegate()
    }
    
    func addTarget() {
        super.searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        super.searchView.helperButton.addTarget(self, action: #selector(helperButtonDidTap), for: .touchUpInside)
    }
    
    func setDelegate() {
        searchView.searchTextField.delegate = self
        searchView.searchResultTableView.delegate = self
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
            searchMajor(text)
        }
    }
    
    // MARK: Objc Function
    func searchMajor(_ word: String) {
        let queryDTO: MajorSearchRequestQueryDTO = MajorSearchRequestQueryDTO(name: schoolName, keyword: word, page: pageCount)
        
        NetworkService.shared.onboardingService.getMajorList(queryDTO: queryDTO) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                DispatchQueue.main.async {
                    self?.allMajor.append(contentsOf: data.groupList)
                    self?.searchResults.append(contentsOf: data.groupList.map { $0.departmentName })
                    self?.totalItemCount = data.totalCount
                    self?.searchView.searchResultTableView.reloadData()
                }
            default:
                print(ErrorPointer.self)
                return
            }
        }
    }
    
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: YelloTextField) {
        textField.debounce(delay: 0.3) { text in
            guard let text = textField.text else { return }
            self.pageCount = 0
            self.searchResults.removeAll()
            self.allMajor.removeAll()
            self.searchMajor(text)
        }
    }
    
    @objc func helperButtonDidTap() {
        let url = URL(string: "https://bit.ly/3pO0ijD")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension FindMajorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let  selectedItem = allMajor[safe: indexPath.row] {
            majorSearchDelegate?.didSelectMajorResult(selectedItem)
            searchView.searchResultTableView.reloadData()
            self.dismiss(animated: true)
            debugPrint("groupId: \(selectedItem.groupID)")
        } else {
            debugPrint("index가 잘못되었습니다. index out of range")
        }
    }
}
