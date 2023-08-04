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
    
    let navigationBarView = YelloNavigationBarView()
    let nextButton = YelloButton(buttonText: "다음")
    private let skipButton = UIButton()
    let progressBarView = ProgressBarManager.shared.progressBarView
    
    var nextViewController: UIViewController?
    var isSkipable = false
    var step = 1.0
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        configUI()
        ProgressBarManager.shared.updateProgress(step: step)
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
        
        navigationBarView.backButton.do {
            $0.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
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
        view.addSubviews(navigationBarView, progressBarView, skipButton, nextButton)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
            $0.bottom.equalToSuperview().inset(Constraints.bottomMargin)
        }
        
        skipButton.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.bottom.equalTo(nextButton.snp.top).inset(-14)
            $0.centerX.equalToSuperview()
        }
        
        progressBarView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.height.equalTo(4)
        }
        
    }
    
    func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
    
    func setUser() {}
    
    // MARK: Objc Function
    @objc func didTapButton() {
        setUser()
        ProgressBarManager.shared.updateProgress(step: step)
        if let nextViewController = nextViewController {
            self.navigationController?.pushViewController(nextViewController, animated: false)
        } else {}
        
    }
    
    @objc private func backButtonTapped() {
        ProgressBarManager.shared.updateProgress(step: 2)
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
