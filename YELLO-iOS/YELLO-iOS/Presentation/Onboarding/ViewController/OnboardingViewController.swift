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
    // MARK: - Variables
    
    // MARK: Componenet
    
    private let backButton = UIButton()
    private let nextButton = YelloButton(buttonText: "다음", state: .enable)
    var nextViewController: UIViewController?
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    // MARK: - Function
    
    // MARK: Custom Function
    ///ConfigUI 반복 사용되는 부분 설정
    func configUI() {
        view.backgroundColor = .white
        setNavigationBarAppearance()
        backButton.do {
            $0.setImage(ImageLiterals.OnBoarding.icArrowLeft, for: .normal)
        }
        
        nextButton.do {
            $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        view.addSubviews(nextButton)
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
            $0.bottom.equalToSuperview().inset(Constraints.bottomMargin)
        }
    }
    
    
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
    
    // MARK: Objc Function
    @objc func didTapButton(){
        if let nextViewController = nextViewController {
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else {}
    }
    
    
}


