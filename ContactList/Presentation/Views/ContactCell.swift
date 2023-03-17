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
    
    private let appStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = -4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let telegramImageView: UIImageView = {
        let image = UIImageView()
        image.configure(with: "telegram")
        return image
    }()
    private let whatsAppImageView: UIImageView = {
        let image = UIImageView()
        image.configure(with: "whatsApp")
        return image
    }()
    private let viberImageView: UIImageView = {
        let image = UIImageView()
        image.configure(with: "viber")
        return image
    }()
    private let signalImageView: UIImageView = {
        let image = UIImageView()
        image.configure(with: "signal")
        return image
    }()
    private let threemaImageView: UIImageView = {
        let image = UIImageView()
        image.configure(with: "threema")
        return image
    }()
    private let phoneImageView: UIImageView = {
        let image = UIImageView()
        image.configure(with: "phone")
        return image
    }()
    private let emailImageView: UIImageView = {
        let image = UIImageView()
        image.configure(with: "email")
        return image
    }()
    
    func configCell(for cell: ContactCell, from contact: CNContact, with indexPath: IndexPath) {
        backgroundColor = .clear
        selectionStyle = .none
        
        addElements()
        setupPositionView()
        configConstraints()
        
        if contact.thumbnailImageData != nil {
            contactPhoto.backgroundColor = .customDarkGray
            contactPhoto.image = UIImage(data: contact.thumbnailImageData ?? Data())
        } else {
            contactPhoto.contentMode = .center
            contactPhoto.image = UIImage(named: "theatermasks.fill")
        }
        
        if !contact.givenName.isEmpty || !contact.familyName.isEmpty {
            nameLabel.text = "\(contact.givenName) \(contact.familyName)"
        } else {
            nameLabel.text = ""
        }
        
        if contact.phoneNumbers.first?.value != nil {
            guard let contactNumber = contact.phoneNumbers.first?.value else { return }
            let number = contactNumber.stringValue
            if  number.count == 12 {
                guard let formattedNumber = formatPhoneNumber(number) else { return }
                phoneLabel.text = "\(formattedNumber)"
                print(formattedNumber)
            } else {
                phoneLabel.text = "\(contactNumber.stringValue)"
            }
        } else {
            phoneLabel.text = ""
        }
    }
    
    private func formatPhoneNumber(_ phoneNumber: String) -> String? {
        let formattedNumber: String
        
        let digits = phoneNumber.filter { $0.isNumber }

        if digits.count != 11 {
            print("Неверная длина номера телефона")
            return nil
        }

        guard let countryPart = digits.first else { return "" }
        let firstPart = digits.dropFirst().prefix(3)
        let secondPart = digits.dropFirst(4).prefix(3)
        let thirdPart = digits.dropFirst(7)

        formattedNumber = "+\(countryPart) (\(firstPart)) \(secondPart)-\(thirdPart)"
        return formattedNumber
    }

    
    private func addElements() {
        addSubview(mainView)
        
        mainView.addSubview(contactPhoto)
        mainView.addSubview(nameLabel)
        mainView.addSubview(phoneLabel)
        mainView.addSubview(appStackView)
        
        appStackView.addArrangedSubview(telegramImageView)
        appStackView.addArrangedSubview(whatsAppImageView)
        appStackView.addArrangedSubview(viberImageView)
        appStackView.addArrangedSubview(signalImageView)
        appStackView.addArrangedSubview(threemaImageView)
        appStackView.addArrangedSubview(phoneImageView)
        appStackView.addArrangedSubview(emailImageView)
    }
    
    private func setupPositionView() {
        let countStack = appStackView.arrangedSubviews.count
        for (index, view) in appStackView.arrangedSubviews.enumerated() {
            view.layer.zPosition = CGFloat(countStack - index)
        }
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            mainView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            mainView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            mainView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -4
            ),
            
            contactPhoto.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 12
            ),
            contactPhoto.centerYAnchor.constraint(
                equalTo: mainView.centerYAnchor
            ),
            contactPhoto.widthAnchor.constraint(
                equalToConstant: 96
            ),
            contactPhoto.heightAnchor.constraint(
                equalTo: contactPhoto.widthAnchor
            ),
            
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
                constant: 6
            ),
            phoneLabel.trailingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor
            ),
            
            appStackView.bottomAnchor.constraint(
                equalTo: contactPhoto.bottomAnchor
            ),
            appStackView.leadingAnchor.constraint(
                equalTo: phoneLabel.leadingAnchor
            )
        ])
    }
}
