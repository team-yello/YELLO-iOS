//
//  BaseBottomSheetViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/20.
//
import UIKit
import SnapKit

protocol LoginNameDataBindProtocol: AnyObject {
    func nicknameDataBind(text: String)
}


final class BottomSheetViewController: UIViewController {
    
    var defaultHeight: CGFloat = Constant.Screen.height.isHalf
    weak var delegate: LoginNameDataBindProtocol?
    
    //MARK: UIComponent
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        return view
    }()
    
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    
    //MARK: life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    //MARK: Custom Method
    
    private func showBottomSheet() {
        bottomSheetView.snp.remakeConstraints{
            $0.height.equalTo(defaultHeight)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(defaultHeight)
        }
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    private func hideBottomSheetAndGoBack() {
        bottomSheetView.snp.remakeConstraints {
            $0.height.equalTo(defaultHeight)
            $0.top.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
            self.dimmedView.alpha = 0.0
        }){ _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
        
        if let text = nicknameSettingView.nickNameTextField.text {
            delegate?.nicknameDataBind(text: text)
        }
    }
    
    private func addTarget(){
        nicknameSettingView.settingButton.addTarget(self, action: #selector(settingButtonDidTap), for: .touchUpInside)
        
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
    }
    
    //MARK: Action
    
    @objc func settingButtonDidTap(){
        hideBottomSheetAndGoBack()
    }
    
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    
}

private extension BottomSheetViewController {
    func setUI(){
        setViewHierarchy()
        setLayout()
    }
    
    func setViewHierarchy(){
        view.addSubviews(dimmedView,bottomSheetView)
        bottomSheetView.addSubview(nicknameSettingView)
        //bottomSheetView.addSubviews(nickNameLabel,nickNameTextField,settingButton)
    }
    
    func setLayout(){
        dimmedView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints{
            $0.height.equalTo(defaultHeight)
            $0.top.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        nicknameSettingView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        
    }
}
