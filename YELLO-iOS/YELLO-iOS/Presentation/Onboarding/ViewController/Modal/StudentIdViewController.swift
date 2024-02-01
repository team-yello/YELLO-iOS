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
    func didSelectStudentId(_ result: Int)
}

class StudentIdViewController: BaseViewController {
    // MARK: - Variables
    // MARK: Constants
    var studentIdList = (15...24).reversed().map { "\($0)학번" }
    let studentIdTableView = UITableView()
    
    // MARK: Property
    weak var delegate: SelectStudentIdDelegate?
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        view.addSubview(studentIdTableView)
        view.backgroundColor = .grayscales900
        
        studentIdTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.rowHeight = 42 // 셀의 높이를 42로 설정
            $0.backgroundColor = .grayscales900
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

// MARK: - extension
// MARK: UITableViewDataSource
extension StudentIdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        studentIdList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.textLabel?.text = studentIdList[indexPath.row]
        cell.textLabel?.font = .uiBodyLarge
        cell.textLabel?.textColor = .white
        cell.makeCornerRound(radius: CGFloat(Constraints.round))
        cell.backgroundColor = .grayscales900
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: UITableViewDelegate
extension StudentIdViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath),
              let cellTitle = currentCell.textLabel?.text else {
            return
        }
        currentCell.backgroundColor = .grayscales800
        // 학번 문자열에서 숫자 부분 추출
        let studentId = cellTitle.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard let studentId = Int(studentId) else { return }
        delegate?.didSelectStudentId(studentId)
        self.dismiss(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let deselectedCell = tableView.cellForRow(at: indexPath) else { return }
        deselectedCell.backgroundColor = .grayscales900
    }
}
