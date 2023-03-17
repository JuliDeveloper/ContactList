import UIKit

extension UIImageView {
    func configure(with imageName: String) {
        image = UIImage(named: imageName)
        frame = CGRect(x: 0, y: 0, width: 27, height: frame.width)
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.customDarkGray.cgColor
    }
}
