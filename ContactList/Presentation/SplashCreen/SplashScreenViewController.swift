import UIKit
import Contacts

protocol SplashScreenViewControllerDelegate: AnyObject {
    func updateIsHiddenButton()
    func updateUI(with contacts: [CNContact])
}

final class SplashScreenViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Хочу увидеть свои контакты", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .customBlue
        button.tintColor = .customWhite
        button.layer.cornerRadius = 24
        button.isHidden = true
        button.addTarget(
            self,
            action: #selector(openSettings),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    lazy var presenter: SplashScreenPresenter = {
        SplashScreenPresenter(delegate: self)
    }()
    private var contacts: [CNContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
        
        presenter.viewDidLoad()
    }
    
    private func configureView() {
        view.backgroundColor = .customBlack
        
        view.addSubview(logoImageView)
        view.addSubview(settingsButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerXAnchor
            ),
            logoImageView.centerYAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerYAnchor
            )
        ])
        
        NSLayoutConstraint.activate([
            settingsButton.heightAnchor.constraint(
                equalToConstant: 64
            ),
            settingsButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            settingsButton.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            settingsButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -58
            )
        ])
    }
    
    @objc private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
}

extension SplashScreenViewController: SplashScreenViewControllerDelegate {
    func updateIsHiddenButton() {
        self.settingsButton.isHidden = false
    }
    
    func updateUI(with contacts: [CNContact]) {
        self.contacts = contacts
        let listVC = ContactListTableView()
        let navVC = UINavigationController(rootViewController: listVC)
        navVC.modalPresentationStyle = .fullScreen
        listVC.contacts = self.contacts
        self.present(navVC, animated: true)
    }
}
