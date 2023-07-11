//
//  FindMajorViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class FindMajorViewController: BaseViewController {
    
    var allMajor: [String] = ["컴퓨터공학과", "컴퓨터학부", "소프트웨어학과", "글로벌미디어학부", "응용소프트웨어학부"]
    var filteredMajor: [String] = []
    
    let baseView = SearchView(titleText: "학과 검색하기", helperText: "찾는 과가 없다면 클릭하세요!")
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
            filteredMajor = allMajor.filter { major in
                return major.contains(textField.text ?? "")
            }
        baseView.searchResultTableView.reloadData()
        }
    
}

extension FindMajorViewController: UITextFieldDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print("✏️✏️✏️\(text)")
        filteredMajor = allMajor.filter { $0.contains(text) }
        baseView.searchResultTableView.reloadData()
    }
    
}

extension FindMajorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredMajor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let major = filteredMajor[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolResultTableViewCell") as! SchoolResultTableViewCell
        cell.textLabel?.text = major
        return cell
    }
    
}
