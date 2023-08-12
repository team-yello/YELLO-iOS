//
//  StudentIdView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/20.
//

import UIKit

class StudentIdView: BaseView {
    // MARK: - Variables
    // MARK: Constants
    var studentIdList = (15...23).reversed().map { "\($0)학번" }
    let studentIdTableView = UITableView()
    
    // MARK: Property
    weak var idDelegate: SelectStudentIdDelegate?
    
    override func setStyle() {
        self.addSubview(studentIdTableView)
        self.backgroundColor = .grayscales900
        studentIdTableView.do {
            $0.delegate = self
            $0.dataSource = self
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
extension StudentIdView: UITableViewDataSource {
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
        cell.selectionStyle = .gray
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension StudentIdView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentCell = tableView.cellForRow(at: indexPath),
              let cellTitle = currentCell.textLabel?.text else {
            return
        }
        
        // 학번 문자열에서 숫자 부분 추출
        let studentId = cellTitle.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard let studentId = Int(studentId) else { return }
        idDelegate?.didSelectStudentId(studentId)
    }
}
