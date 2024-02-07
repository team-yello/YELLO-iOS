//
//  OnboardingBaseViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/06.
//

import UIKit

import Amplitude
import SnapKit
import Then

class OnboardingBaseViewController: UIViewController {
    // MARK: - Variables
    // MARK: - Property
    let paramaterArray: [String] = ["student_type", "school", "id", "friends"]
    // MARK: Componenet
    let navigationBarView = YelloNavigationBarView()
    let nextButton = YelloButton(buttonText: "다음")
    let skipButton = UIButton()
    private let buttonStackView = UIStackView()
    let progressBarView = ProgressBarManager.shared.progressBarView
    
    var nextViewController: UIViewController?
    var bottomConstraint: NSLayoutConstraint?
    var isSkipable = false
    var step = 0
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if step > 0 {
            ProgressBarManager.shared.updateProgress(for: self, step: step)
        }
        configUI()
    }
    
    override func viewDidLoad() {
        configUI()
        setProgressBar()
        super.viewDidLoad()
        setUI()
        setNotificationCenter()
        view.bringSubviewToFront(buttonStackView)
    }
    
    // MARK: Layout Helper
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    func setStyle() {
        view.backgroundColor = .black
    }
    
    func setLayout() {}
    
    // MARK: Custom Function
    /// ConfigUI 반복 사용되는 부분 설정
    func configUI() {
        view.backgroundColor = .black
        
        navigationBarView.backButton.do {
            $0.addTarget(self, action: #selector(backButtonTapped(sender:)), for: .touchUpInside)
        }
        
        nextButton.do {
            $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        
        skipButton.do {
            $0.makeCornerRound(radius: 24.adjusted)
            $0.makeBorder(width: 1, color: .grayscales200)
            $0.setTitle("건너뛰기", for: .normal)
            $0.titleLabel?.font = .uiBody01
            $0.setTitleColor(.grayscales200, for: .normal)
            $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
        
        buttonStackView.do {
            $0.addArrangedSubviews(skipButton, nextButton)
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 10.adjustedHeight
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
            $0.height.equalTo(48.adjusted)
            $0.leading.trailing.equalToSuperview()
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
    }
    
    func setNotificationCenter() {
        
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
        if step < 5 && step > 0 {
            Amplitude.instance().logEvent("click_onboarding_next", withEventProperties: ["onboard_view": paramaterArray[step - 1]] )
        }
        
    }
    
    @objc func backButtonTapped(sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight: CGFloat
            keyboardHeight = keyboardSize.height - self.view.safeAreaInsets.bottom
            self.bottomConstraint?.constant = -1 * keyboardHeight - 12.adjustedHeight
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.bottomConstraint?.constant = -34.adjustedHeight
    }
}
