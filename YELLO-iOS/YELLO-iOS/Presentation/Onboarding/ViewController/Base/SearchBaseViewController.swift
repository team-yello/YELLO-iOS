//
//  SearchBaseViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

// MARK: - Delegate
protocol SearchResultTableViewSelectDelegate: AnyObject {
    func didSelectSearchResult(_ result: String)
}

class SearchBaseViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Property
    var allArr: [String] = []
    
    
    // MARK: Component
    let searchView = SearchView()
    weak var delegate: SearchResultTableViewSelectDelegate?
    
    // MARK: - Function
    // MARK: - LifeCycles
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        searchView.searchTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        setDelegate()
    }
    
    // MARK: Custom Function
    func customView(titleText: String, helperText: String) {
        searchView.titleLabel.text = titleText
        searchView.helperButton.setTitle(helperText, for: .normal)
        searchView.helperButton.setUnderline()
    }
    
    private func addTarget() {
        searchView.cancelButton.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
    }
    
    private func setDelegate() {
        searchView.searchTextField.delegate = self
        searchView.searchResultTableView.dataSource = self
        searchView.searchResultTableView.delegate = self
    }
    
    /// 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func cancelButtonDidTap() {
        self.dismiss(animated: true)
    }
    
}

// MARK: - extension
// MARK: UITextFieldDelegate
extension SearchBaseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}

// MARK: - extension
// MARK: UITableViewDataSource
extension SearchBaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = allArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier) as! SearchResultTableViewCell
        cell.titleLabel.text = searchResult
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - extension

// MARK: UITableViewDelegate
extension SearchBaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell else {
            return
        }
        delegate?.didSelectSearchResult(currentCell.titleLabel.text ?? "")
        self.dismiss(animated: true)
    }
}
