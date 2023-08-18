import UIKit

class ProgressBarViewController: UIViewController {
    private let progressBar = UIProgressView(progressViewStyle: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateProgressBar), name: Notification.Name("ProgressBarUpdated"), object: nil)
    }
    
    func setupProgressBar() {
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top).offset(30)
            $0.height.equalTo(5)
        }
        
    }
    
    @objc func updateProgressBar() {
        progressBar.progress = Float(ProgressBarManager.shared.progress)
    }
}
