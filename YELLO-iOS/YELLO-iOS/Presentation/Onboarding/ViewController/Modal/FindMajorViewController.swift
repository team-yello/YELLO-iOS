//
//  FindMajorViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

// MARK: - Protocol
// MARK: FindMajorViewControllerDelegate
protocol FindMajorViewControllerDelegate: AnyObject {
    func didDismissFindMajorViewController(with groupList: GroupList)
}

class FindMajorViewController: SearchBaseViewController {
    // MARK: - Variables
    // MARK: Property
    var allMajor: [GroupList] = []
    var schoolName: String = ""
    
    var pageCount: Int = 0
    var totalItemCount: Int = 0
    
    weak var majorDelegate: FindMajorViewControllerDelegate?
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        super.customView(titleText: "학과 검색하기", helperText: "찾는 과가 없다면 클릭하세요!")
        addTarget()
        searchView.searchTextField.delegate = self
        searchView.searchResultTableView.delegate = self
    }
    
    func addTarget() {
        super.searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        super.searchView.helperButton.addTarget(self, action: #selector(helperButtonDidTap), for: .touchUpInside)
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
            searchMajor(text)
        }
    }
    
    // MARK: Objc Function
    func searchMajor(_ word: String) {
        let queryDTO: MajorSearchRequestQueryDTO = MajorSearchRequestQueryDTO(school: schoolName, search: word, page: pageCount)
        
        NetworkService.shared.onboardingService.getMajorList(queryDTO: queryDTO) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data.data else { return }
                self?.allMajor.append(contentsOf: data.groupList)
                self?.allArr.append(contentsOf: data.groupList.map { $0.departmentName })
                self?.totalItemCount = data.totalCount
                self?.searchView.searchResultTableView.reloadData()
            default:
                print(ErrorPointer.self)
                return
            }
        }
    }
    
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        pageCount = 0
        allMajor.removeAll()
        allArr.removeAll()
        searchMajor(text)
    }
    
    @objc func helperButtonDidTap() {
        let url = URL(string: "https://bit.ly/3pO0ijD")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension FindMajorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell else {
            return
        }
        majorSearchDelegate?.didSelectMajorResult(currentCell.titleLabel.text ?? "")
        let selectedItem = allMajor[indexPath.row]
        print(selectedItem.groupID)
        majorDelegate?.didDismissFindMajorViewController(with: selectedItem)
        self.dismiss(animated: true)
    }
}
