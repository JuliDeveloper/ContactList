import UIKit
import Contacts

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
    
    private let customAlert = CustomAlert()
    
    private var contacts: [CNContact] = []
    private let contactsManager = ContactsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
        
        fetchContacts()
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
    
    private func fetchContacts() {
        contactsManager.requestContactsAccess { [weak self] access in
            guard let self = self else { return }
            if access {
                self.loadContact()
                print("Доступ разрешен")
            } else {
                print("Доступ запрещен")
                DispatchQueue.main.async {
                    self.settingsButton.isHidden = false
                }
            }
        }
    }
    
    private func loadContact() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.contactsManager.fetchContacts { result in
                switch result {
                case .success(let contacts):
                    DispatchQueue.main.async {
                        self.contacts = contacts
                        let listVC = ContactListTableView()
                        listVC.modalPresentationStyle = .fullScreen
                        listVC.contacts = self.contacts
                        self.present(listVC, animated: true)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
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
