//
//  OnboardingBaseViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/06.
//

import UIKit

import SnapKit
import Then


class OnboardingBaseViewController: BaseViewController {
    
    
    //MARK: Componenet
    
    private let backButton = UIButton()
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationBarAppearance()
    }
    
    // MARK: UI
    func setUI() {
        setStyle()
        setLayout()
    }
    
    /// Attributes (속성) 설정 메서드
    override func setStyle() {
        view.backgroundColor = .white
        
        backButton.do {
            $0.setImage(ImageLiterals.OnBoarding.icArrowLeft, for: .normal)
        }
    }
    
    /// Hierarchy, Constraints (계층 및 제약조건) 설정 메서드
    override func setLayout() {}
    
    func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
    
    func setNavigationBarAppearance(){
        let backButtonImage = ImageLiterals.OnBoarding.icArrowLeft.withTintColor(.black, renderingMode: .alwaysOriginal)
        let appearance = UINavigationBarAppearance()
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -200, vertical: 0)
        appearance.backButtonAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        navigationItem.standardAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
    }
    
    
}


