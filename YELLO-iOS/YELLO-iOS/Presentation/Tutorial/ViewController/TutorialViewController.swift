//
//  TutorialViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/08/15.
//

import UIKit

class TutorialViewController: UIViewController {
    
    var pageCount = 1

    var baseView: UIView = FirstTutorialView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addTarget()
    }
    
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {    }
    
    private func setLayout() {
        view.addSubview(baseView)
        
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func addTarget() {
        baseView.isUserInteractionEnabled = true
        baseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapView)))
    }
    
    @objc func tapView() {
        pageCount += 1
        
        if pageCount < 5 {
            switch pageCount {
            case 2:
                baseView = SecondTutorialView()
            case 3:
                baseView = ThirdTutorialView()
            case 4:
                baseView = FourthTutorial()
            default:
                baseView = UIView()
            }
            setUI()
            addTarget()
        }
    }
    
}
