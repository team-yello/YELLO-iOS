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
    
    // MARK: - Variables
    // MARK: Component
    private let schoolFriendView = SchoolFriendView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.schoolFriendView.recommendingSchoolFriend()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        schoolFriendView.updateView()
    }
}

// MARK: - extension
extension SchoolFriendViewController {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        view.addSubview(schoolFriendView)
        schoolFriendView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
