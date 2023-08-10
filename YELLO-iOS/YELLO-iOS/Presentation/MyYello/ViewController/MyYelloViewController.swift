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
        self.myYelloCount()
        self.myYelloView.myYelloListView.isFinishPaging = false
        self.myYelloView.myYelloListView.fetchingMore = false
        self.myYelloView.myYelloListView.pageCount = -1
        self.myYelloView.myYelloListView.myYello()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.myYelloView.myYelloListView.applySnapshot(animated: true)
        if MyYelloListView.myYelloModelDummy.isEmpty == false {
            self.myYelloView.myYelloListView.myYelloTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        myYelloView.handleUnlockButton = self
        myYelloView.myYellowNavigationBarView.handleShopButton = self
    }
    
    private func setAddTarget() {
        myYelloView.myYelloListView.refreshControl.addTarget(self, action: #selector(refreshCount), for: .valueChanged)
    }
    
    @objc func refreshCount() {
        self.myYelloCount()
    }
}

// MARK: - extension
// MARK: HandleUnlockButton
extension MyYelloViewController: HandleUnlockButton {
    func unlockButtonTapped() {
        if myYelloView.haveTicket {
            view.showToast(message: StringLiterals.MyYello.List.toastMessage)
        } else {
            let paymentPlusViewController = PaymentPlusViewController()
            navigationController?.pushViewController(paymentPlusViewController, animated: true)
        }
    }
}

// MARK: HandleUnlockButton
extension MyYelloViewController: HandleShopButton {
    func shopButtonTapped() {
        let paymentPlusViewController = PaymentPlusViewController()
        navigationController?.pushViewController(paymentPlusViewController, animated: true)
    }
}

// MARK: HandleMyYelloCellDelegate
extension MyYelloViewController: HandleMyYelloCellDelegate {
    func pushMyYelloDetailViewController(index: Int) {
            let myYelloDetailViewController = MyYelloDetailViewController()
            self.navigationController?.pushViewController(myYelloDetailViewController, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.myYelloView.myYelloListView.indexNumber = index
            myYelloDetailViewController.myYelloDetailView.voteIdNumber = MyYelloListView.myYelloModelDummy[index].id
            myYelloDetailViewController.myYelloDetail(voteId: MyYelloListView.myYelloModelDummy[index].id)
            myYelloDetailViewController.myYelloDetailView.indexNumber = index
        }
    }
}

extension MyYelloViewController {
    func myYelloCount() {

        let queryDTO = MyYelloRequestQueryDTO(page: 0)

        NetworkService.shared.myYelloService.myYello(queryDTO: queryDTO) { [weak self] response in
            guard let self = self else { return }
                switch response {
                case .success(let data):
                    guard let data = data.data else { return }

                    MyYelloView.myYelloCount = data.totalCount
                    print(MyYelloView.myYelloCount)
                    print("내 옐로 count 통신 성공")
                    self.myYelloView.resetLayout()
                default:
                    print("network fail")
                    return
                }
        }
    }
}
