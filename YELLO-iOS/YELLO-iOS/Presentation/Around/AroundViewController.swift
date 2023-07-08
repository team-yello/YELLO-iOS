//
//  AroundViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

// MARK: - Around
final class AroundViewController: UIViewController {

    // MARK: - Variables
    // MARK: Component
    private let aroundView = AroundView()

    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

// MARK: - extension
extension AroundViewController {
    
    // MARK: Layout Helpers
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        view.addSubviews(aroundView)
        
        aroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}
