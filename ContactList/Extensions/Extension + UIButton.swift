import UIKit

extension UIButton {
    func configure(title: String, backgroundColor: UIColor) {
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16)
        tintColor = .customWhite
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 24
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
}
