//
//  BaseBottomSheetViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/20.
//
import UIKit
import SnapKit

class BaseBottomViewController: UIViewController {
    
    var height = UIScreen.main.bounds.height
    lazy var defaultHeight: CGFloat = (height)/2
    
    // MARK: UIComponent
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayscales900.withAlphaComponent(0.4)
        return view
    }()
    
    let bottomSheetView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    func setUI() {
        setViewHierarchy()
        setLayout()
    }
    
    func setViewHierarchy( ) {
        view.addSubviews(dimmedView, bottomSheetView)
    }
    
    func setLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheetView.snp.makeConstraints {
            $0.height.equalTo(defaultHeight)
            $0.top.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
    }
    
    // MARK: Custom Method
    func setCustomView(view: UIView) {
        bottomSheetView.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func showBottomSheet() {
        dimmedView.isHidden = false
        bottomSheetView.snp.remakeConstraints {
            $0.height.equalTo(defaultHeight)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(defaultHeight)
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    private func hideBottomSheetAndGoBack() {
        bottomSheetView.snp.remakeConstraints {
            $0.height.equalTo(defaultHeight)
            $0.top.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.dimmedView.isHidden = true
        }) { _ in
            if self.presentingViewController != nil {
               self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    private func addTarget() {
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
    }
    
    // MARK: Action
    @objc func settingButtonDidTap() {
        hideBottomSheetAndGoBack()
    }
    
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
}
