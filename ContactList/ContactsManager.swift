import Foundation
import Contacts

final class ContactsManager {
    static let shared = ContactsManager()
    
    let contactStore = CNContactStore()
    
    func requestContactsAccess(completion: @escaping (Bool) -> Void) {
        contactStore.requestAccess(for: .contacts) { (granted, error) in
            completion(granted)
        }
    }
    
    func fetchContacts(completion: @escaping (Result<[CNContact], Error>) -> Void) {
        let keysToFetch = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey
        ] as [CNKeyDescriptor]

        let request = CNContactFetchRequest(keysToFetch: keysToFetch)

        do {
            var contacts: [CNContact] = []
            try contactStore.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                contacts.append(contact)
            })
            completion(.success(contacts))
        } catch let error {
            completion(.failure(error))
        }
    }

}
