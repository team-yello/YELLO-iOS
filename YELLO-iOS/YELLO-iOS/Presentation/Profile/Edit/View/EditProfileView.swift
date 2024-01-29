//
//  EditProfileView.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/25/24.
//

import UIKit

import SnapKit
import Then

class EditProfileView: UIView {
    
    let profileTableView = UITableView(frame: .zero, style: .plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setStlye()
        setLayout()
    }
    
    private func setStlye() {
        profileTableView.do {
            $0.backgroundColor = .clear
            $0.register(EditProfileTableViewCell.self, forCellReuseIdentifier: EditProfileTableViewCell.reusableId)
            $0.rowHeight = 75.adjustedHeight
            $0.dataSource = self
        }
    }
    
    private func setLayout() {
        self.addSubviews(profileTableView)
        
        profileTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.adjustedWidth)
        }
    }
}

extension EditProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditProfileTableViewCell.reusableId) as? EditProfileTableViewCell else { return UITableViewCell() }
        cell.configureCell(isEditable: true, title: "이름", info: "김효원")
        return cell
    }
}
