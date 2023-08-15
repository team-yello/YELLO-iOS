//
//  TutorialViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/15.
//

import UIKit

class TutorialViewController: UIViewController {
    
    var pageCount = 0
    
    let baseView = FirstTutorialView()
    
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
    }
    
    private func addTarget() {
        baseView.tutorialImageView.isUserInteractionEnabled = true
        baseView.tutorialImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
    }
    
    @objc func tapView() {
        
    }
    
}
