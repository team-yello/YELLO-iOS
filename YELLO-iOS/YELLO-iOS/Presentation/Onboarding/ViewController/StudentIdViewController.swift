//
//  StudentIdViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

import SnapKit
import Then

protocol SelectStudentIdDelegate: AnyObject {
    func didSelectStudentId(_ result: String)
}

class StudentIdViewController: BaseViewController {
    
    let studentIdList = (15...23).reversed().map { "\($0)학번" }
    let studentIdTableView = UITableView()
    weak var delegate: SelectStudentIdDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func setStyle() {
        view.backgroundColor = .white
        view.addSubview(studentIdTableView)
        studentIdTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.rowHeight = 42 // 셀의 높이를 42로 설정
            $0.separatorStyle = .none
            $0.tableHeaderView = UIView()
        }
    }
    
    override func setLayout() {
        studentIdTableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(24)
        }
    }
    
}

extension StudentIdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        studentIdList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.textLabel?.text = studentIdList[indexPath.row]
        cell.textLabel?.font = .uiBodyLarge
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }
}

extension StudentIdViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        if let cellTitle = currentCell.textLabel?.text {
            delegate?.didSelectStudentId(cellTitle)
        }
        self.dismiss(animated: true)
    }
}
