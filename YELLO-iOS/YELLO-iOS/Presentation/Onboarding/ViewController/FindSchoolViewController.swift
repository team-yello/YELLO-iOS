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
    var allSchool: [String] = []
    var pageCount: Int = 0
    var totalItemCount: Int = 0
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.customView(titleText: "우리 학교 검색하기", helperText: "우리 학교가 없나요? 학교를 추가해보세요!")
        addTarget()
    }
    
    func addTarget() {
        super.searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func searchSchool(_ word: String) {
        let queryDTO: SchoolSearchRequestQueryDTO = SchoolSearchRequestQueryDTO(search: word, page: pageCount)
        NetworkService.shared.onboardingService.getSchoolList(queryDTO: queryDTO) { result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                self.allArr.append(contentsOf: data.groupNameList)
                self.totalItemCount = data.totalCount 
                self.searchView.searchResultTableView.reloadData()
            default:
                print(ErrorPointer.self)
                return
            }
            
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = self.searchView.searchResultTableView
        let offsetY = tableView.contentOffset.y
        let contentHeight = tableView.contentSize.height
        let visibleHeight = tableView.bounds.height
        self.searchView.searchTextField.endEditing(true)
        if offsetY > contentHeight - visibleHeight, allArr.count < totalItemCount {
            pageCount += 1
            guard let text = searchView.searchTextField.text else { return }
            searchSchool(text)
        }
    }
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        pageCount = 0
        allArr.removeAll()
        searchSchool(text)
    }
    
}
