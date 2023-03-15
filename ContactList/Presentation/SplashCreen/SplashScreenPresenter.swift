import Foundation
import Contacts

protocol SplashScreenPresenterProtocol {
    func viewDidLoad()
    func fetchContactsAccess()
    func loadContact()
}

final class SplashScreenPresenter: SplashScreenPresenterProtocol {
    
    weak var delegate: SplashScreenViewControllerDelegate?
    private let contactsManager: ContactsManager
    
    init(contactsManager: ContactsManager = .shared, delegate: SplashScreenViewControllerDelegate) {
        self.contactsManager = contactsManager
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        fetchContactsAccess()
    }
    
    func fetchContactsAccess() {
        contactsManager.requestContactsAccess { [weak self] access in
            guard let self = self else { return }
            if access {
                self.loadContact()
                print("Доступ разрешен")
            } else {
                print("Доступ запрещен")
                DispatchQueue.main.async {
                    self.delegate?.updateIsHiddenButton()
                }
            }
        }
    }
    
    func loadContact() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.contactsManager.fetchContacts { result in
                switch result {
                case .success(let contacts):
                    DispatchQueue.main.async {
                        self.delegate?.updateUI(with: contacts)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
