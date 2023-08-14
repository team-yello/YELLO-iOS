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
    let skipButton = UIButton()
    private let buttonStackView = UIStackView()
    private let progressBarView = ProgressBarManager.shared.progressBarView
    
    var nextViewController: UIViewController?
    var bottomConstraint: NSLayoutConstraint?
    var isSkipable = false
    var step = 1.0
    
    // MARK: Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProgressBarManager.shared.updateProgress(for: self, step: step)
        configUI()
    }
    
    override func viewDidLoad() {
        configUI()
        setProgressBar()
        super.viewDidLoad()
        view.bringSubviewToFront(buttonStackView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        
        buttonStackView.do {
            $0.addArrangedSubviews(skipButton, nextButton)
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 14
        }
        
        skipButton.isHidden = !(isSkipable)
    
        view.addSubviews(navigationBarView, progressBarView, buttonStackView)
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints {
            $0.height.equalTo(32)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constraints.bigMargin)
            $0.bottom.equalToSuperview().inset(34.adjustedHeight)
        }
        
        progressBarView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.height.equalTo(4)
        }
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        self.bottomConstraint = NSLayoutConstraint(item: self.nextButton, attribute: .bottom,
                                                   relatedBy: .equal, toItem: safeArea,
                                                   attribute: .bottom, multiplier: 1.0, constant: -34.adjusted)
        self.bottomConstraint?.isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
    
    func setUser() {}
    
    func setProgressBar() {
        ProgressBarManager.shared.updateProgress(for: self, step: step)
        
    }
    
    // MARK: Objc Function
    @objc func didTapButton(sender: UIButton) {
        setUser()
        if let nextViewController = nextViewController {
            self.navigationController?.pushViewController(nextViewController, animated: false)
        } else {}
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight: CGFloat
            keyboardHeight = keyboardSize.height - self.view.safeAreaInsets.bottom
            self.bottomConstraint?.constant = -1 * keyboardHeight - 12
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.bottomConstraint?.constant = 0
    }
}
