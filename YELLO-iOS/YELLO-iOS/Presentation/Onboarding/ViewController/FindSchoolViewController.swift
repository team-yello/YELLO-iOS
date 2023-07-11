//
//  FindSchoolViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

class FindSchoolViewController: OnboardingBaseViewController {
    
    var allSchool: [String] = ["서울대학교", "서울과학기술대학교", "서울교육대학교", "서울여자대학교", "이화여자대학교", "고려대학교", "연세대학교", "숭실대학교", "홍익대학교"]
    var filteredSchool: [String] = []
    
    let baseView = SearchView(titleText: "우리 학교 검색하기", helperText: "우리 학교가 없나요? 학교를 추가해보세요!")
    let searchController = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        baseView.searchResultTableView.dataSource = self
    }
    
    private func setDelegate() {
       // baseView.schoolSearchTextField.delegate = self
        baseView.searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
            filteredSchool = allSchool.filter { school in
                return school.contains(textField.text ?? "")
            }
        baseView.searchResultTableView.reloadData()
        }
    
}

extension FindSchoolViewController: UITextFieldDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print("✏️✏️✏️\(text)")
        filteredSchool = allSchool.filter { $0.contains(text) }
        baseView.searchResultTableView.reloadData()
    }
    
}

extension FindSchoolViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredSchool.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let school = filteredSchool[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolResultTableViewCell") as! SchoolResultTableViewCell
        cell.textLabel?.text = school
        return cell
    }
    
}
