//
//  BaseViewController.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    // MARK: Initializing
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT: \(className)")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        setStyle()
        setLayout()
    }
    
    // MARK: UI
    
    /// Attributes (속성) 설정 메서드
    func setStyle() {
        
        view.backgroundColor = .black
    }
    
    /// Hierarchy, Constraints (계층 및 제약조건) 설정 메서드
    func setLayout() {}
   
}
