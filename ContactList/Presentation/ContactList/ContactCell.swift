import UIKit
import Contacts

final class ContactCell: UITableViewCell {
    
    private let mainView: UIView = {
       let view = UIView()
        view.backgroundColor = .customDarkGray
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contactPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .customLightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customWhite
        label.font = .systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configCell(for cell: ContactCell, from contact: CNContact, with indexPath: IndexPath) {
        
        backgroundColor = .clear
        
        if contact.thumbnailImageData != nil {
            contactPhoto.backgroundColor = .customDarkGray
            contactPhoto.image = UIImage(data: contact.thumbnailImageData ?? Data())
        } else {
            contactPhoto.contentMode = .center
            contactPhoto.image = UIImage(named: "theatermasks.fill")
        }
        
        nameLabel.text = "\(contact.givenName) \(contact.familyName)"
        
        if contact.phoneNumbers.first?.value.stringValue != nil {
            phoneLabel.text = "\(contact.phoneNumbers.first?.value.stringValue ?? "")"
        } else {
            phoneLabel.text = ""
        }
        
        configConstraints()
    }
    
    private func configConstraints() {
        
        mainView.addSubview(contactPhoto)
        mainView.addSubview(nameLabel)
        mainView.addSubview(phoneLabel)
        addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            contactPhoto.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 12
            ),
            contactPhoto.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            contactPhoto.widthAnchor.constraint(equalToConstant: 96),
            contactPhoto.heightAnchor.constraint(equalTo: contactPhoto.widthAnchor),
            
            nameLabel.leadingAnchor.constraint(
                equalTo: contactPhoto.trailingAnchor,
                constant: 12
            ),
            nameLabel.topAnchor.constraint(
                equalTo: contactPhoto.topAnchor
            ),
            nameLabel.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -12
            ),
            
            phoneLabel.leadingAnchor.constraint(
                equalTo: nameLabel.leadingAnchor
            ),
            phoneLabel.topAnchor.constraint(
                equalTo: nameLabel.bottomAnchor,
                constant: 12
            ),
            phoneLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            )
        ])
        
    }
}
