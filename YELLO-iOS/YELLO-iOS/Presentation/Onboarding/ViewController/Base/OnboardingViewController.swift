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
    let nextButton = YelloButton(buttonText: "다음")
    private let skipButton = UIButton()
    let navigationBarView = UIView()
    var nextViewController: UIViewController?
    var isSkipable = false
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewDidLoad() {
        configUI()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubviewToFront(nextButton)
    }
    
    // MARK: - Function
    
    // MARK: Custom Function
    /// ConfigUI 반복 사용되는 부분 설정
    func configUI() {
        view.backgroundColor = .black
        setNavigationBarAppearance()
        backButton.do {
            $0.setImage(ImageLiterals.OnBoarding.icArrowLeft.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
        
        nextButton.do {
            $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        
        skipButton.do {
            $0.setTitle("건너뛰기", for: .normal)
            $0.titleLabel?.font = .uiBody01
            $0.setTitleColor(.white, for: .normal)
            $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        
        skipButton.isHidden = !(isSkipable)
        view.addSubviews(skipButton, nextButton)
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
            $0.bottom.equalToSuperview().inset(Constraints.bottomMargin)
        }
        
        skipButton.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.bottom.equalTo(nextButton.snp.top).inset(-14)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
    
    func setNavigationBarAppearance() {
        let backButtonImage = ImageLiterals.OnBoarding.icArrowLeft.withTintColor(.white, renderingMode: .alwaysOriginal)
        let appearance = UINavigationBarAppearance()
        if #available(iOS 15.0, *) {
            appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
            appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -200, vertical: 0)
            appearance.backgroundColor = .black
            appearance.shadowColor = .clear
            navigationItem.standardAppearance = appearance
            navigationItem.compactAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
        } else {
            // 타이틀 숨기기
               navigationItem.title = ""
               
               // 배경을 투명색으로 설정
               navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
               navigationController?.navigationBar.shadowImage = UIImage()
               
               // BackButton 커스텀
               navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        }
    }
    
    func setUser() {}
    
    // MARK: Objc Function
    @objc func didTapButton() {
        setUser()
        if let nextViewController = nextViewController {
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else {}
        
    }
    
    @objc private func backButtonTapped() {
        // BackButton 동작 처리
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
