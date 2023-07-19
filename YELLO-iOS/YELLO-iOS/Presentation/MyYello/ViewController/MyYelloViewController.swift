//
//  MyYelloViewController.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/05.
//

import UIKit

import SnapKit
import Then

final class MyYelloViewController: BaseViewController {
    
    // MARK: - Variables
    // MARK: Component
    private let myYelloView = MyYelloView()
    
    // MARK: - Function
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setAddTarget()
        self.myYelloView.myYelloListView.myYello()
        self.myYelloCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myYelloView.myYelloListView.myYelloTableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.myYelloView.resetLayout()
    }
    
    // MARK: Layout Helpers
    override func setStyle() {
        view.backgroundColor = .black
    }
    
    override func setLayout() {
        view.addSubviews(myYelloView)
        
        let tabbarHeight = 60 + safeAreaBottomInset()
        
        myYelloView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabbarHeight)
        }
    }
    
    // MARK: Custom Function
    private func setDelegate() {
        myYelloView.myYelloListView.handleMyYelloCellDelegate = self
    }
    
    private func setAddTarget() {
        myYelloView.unlockButton.addTarget(self, action: #selector(unlockButtonTapped), for: .touchUpInside)
    }
}

// MARK: - extension
extension MyYelloViewController {
    @objc private func unlockButtonTapped() {
        let paymentViewController = PaymentViewController()
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
}

// MARK: HandleMyYelloCellDelegate
extension MyYelloViewController: HandleMyYelloCellDelegate {
    func pushMyYelloDetailViewController(index: Int) {
        let myYelloDetailViewController = MyYelloDetailViewController()
        navigationController?.pushViewController(myYelloDetailViewController, animated: true)
        myYelloView.myYelloListView.indexNumber = index
        myYelloDetailViewController.myYelloDetailView.voteIdNumber = MyYelloListView.myYelloModelDummy[index].id
        myYelloDetailViewController.myYelloDetail(voteId: MyYelloListView.myYelloModelDummy[index].id)
        myYelloDetailViewController.myYelloDetailView.indexNumber = index
    }
}

extension MyYelloViewController {
    func myYelloCount() {
        
        let queryDTO = MyYelloRequestQueryDTO(page: 0)
        
        NetworkService.shared.myYelloService.myYello(queryDTO: queryDTO) { [weak self] response in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }
                    
                    self.myYelloView.myYelloCount = data.totalCount
                    print("내 옐로 count 통신 성공")
                default:
                    print("network fail")
                    return
                }
            }
        }
    }
}
