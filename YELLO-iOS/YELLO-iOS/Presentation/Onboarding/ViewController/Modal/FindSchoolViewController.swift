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
    var isHighSchool = false
    var allSchool: [String] = []
    var pageCount: Int = 0
    var totalItemCount: Int = 0
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        allSchool.removeAll()
        customView(titleText: "우리 학교 검색하기", helperText: "우리 학교가 없나요? 학교를 추가해보세요!")
        addTarget()
    }
    
    func addTarget() {
        searchView.searchResultTableView.delegate = self
        
        searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        searchView.helperButton.addTarget(self, action: #selector(helperButtonDidTap), for: .touchUpInside)
    }
    
    func searchSchool(_ word: String) {
        
        if isHighSchool {
            /// 고등학교인 경우
            let highschoolQueryDTO: HighSchoolSearchRequestQueryDTO = HighSchoolSearchRequestQueryDTO(keyword: word, page: pageCount)
            NetworkService.shared.onboardingService.getHighSchoolList(queryDTO: highschoolQueryDTO) { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else { return }
                    DispatchQueue.main.async {
                        self.allArr.append(contentsOf: data.groupNameList)
                        self.totalItemCount = data.totalCount
                        self.searchView.searchResultTableView.reloadData()
                    }
                default:
                    print(ErrorPointer.self)
                    return
                }
            }
        } else {
            /// 대학교인 경우
            let schoolQueryDTO: SchoolSearchRequestQueryDTO = SchoolSearchRequestQueryDTO(keyword: word, page: pageCount)
            NetworkService.shared.onboardingService.getSchoolList(queryDTO: schoolQueryDTO) { result in
                switch result {
                case .success(let data):
                    guard let data = data.data else { return }
                    DispatchQueue.main.async {
                        self.allArr.append(contentsOf: data.groupNameList)
                        self.totalItemCount = data.totalCount
                        self.searchView.searchResultTableView.reloadData()
                    }
                default:
                    print(ErrorPointer.self)
                    return
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
        if offsetY > contentHeight - visibleHeight, allArr.count < totalItemCount {
            pageCount += 1
            guard let text = searchView.searchTextField.text else { return }
            searchSchool(text)
        }
    }
    // MARK: Objc Function
    @objc func textFieldDidChange(_ textField: YelloTextField) {
        guard let text = textField.text else { return }
        textField.debounce(delay: 0.5) { text in
            guard let text = textField.text else { return }
            self.pageCount = 0
            self.allArr.removeAll()
            self.searchSchool(text)
        }
    }
    
    @objc func helperButtonDidTap() {
        let url = isHighSchool ? URL(string: "https://forms.gle/sMyn6uq7oHDovSdi8")! : URL(string: "https://bit.ly/46Yv0Hc")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: - extension
// MARK: UITableViewDelegate
extension FindSchoolViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell else {
            return
        }
        delegate?.didSelectSchoolResult(currentCell.titleLabel.text ?? "")
        self.dismiss(animated: true)
    }
}
