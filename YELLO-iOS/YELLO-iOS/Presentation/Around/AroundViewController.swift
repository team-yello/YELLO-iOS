//
//  AroundViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class AroundViewController: UIViewController {

    private let aroundView = AroundView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension AroundViewController {
    
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
