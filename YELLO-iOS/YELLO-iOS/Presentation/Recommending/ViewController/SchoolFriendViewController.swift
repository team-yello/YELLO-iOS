//
//  SchoolFriendViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/07.
//

import UIKit

import SnapKit
import Then

final class SchoolFriendViewController: UIViewController {
    
    private let schoolFriendView = SchoolFriendView()
    private let emptyFriendView = EmptyFriendView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension SchoolFriendViewController {
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        if schoolFriendView.schoolFriendTableViewModel.isEmpty {
            view.addSubview(emptyFriendView)
            emptyFriendView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
            }
        } else {
            view.addSubview(schoolFriendView)
            schoolFriendView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}
