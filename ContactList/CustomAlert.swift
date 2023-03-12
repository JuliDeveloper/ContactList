import UIKit

final class CustomAlert {
    private let alertView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.insertSubview(blurEffectView, at: 0)
        return view
    }()
    
    private var accessButtonTappedHandler: (() -> Void)?
    private var cancelButtonTappedHandler: (() -> Void)?
    
    func showAlert(title: String, view: UIView, accessHandler: (() -> Void)?, cancelHandler: (() -> Void)?) {
        let titleAlert: UILabel = {
            let label = UILabel()
            label.text = title
            label.font = .systemFont(ofSize: 15)
            label.textAlignment = .center
            label.textColor = .customWhite
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let firstSeparatorLine: UIView = {
            let view = UIView()
            view.configureSeparator()
            return view
        }()
        
        let secondSeparatorLine: UIView = {
            let view = UIView()
            view.configureSeparator()
            return view
        }()
        
        let accessButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Разрешить", for: .normal)
            button.tintColor = .link
            button.titleLabel?.font = .boldSystemFont(ofSize: 17)
            button.addTarget(
                self,
                action: #selector(openList),
                for: .touchUpInside
            )
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        let cancelButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Запретить", for: .normal)
            button.tintColor = .link
            button.titleLabel?.font = .systemFont(ofSize: 17)
            button.addTarget(
                self,
                action: #selector(cancelAccess),
                for: .touchUpInside
            )
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        alertView.addSubview(titleAlert)
        alertView.addSubview(firstSeparatorLine)
        alertView.addSubview(secondSeparatorLine)
        alertView.addSubview(accessButton)
        alertView.addSubview(cancelButton)
        
        view.addSubview(alertView)
        
        NSLayoutConstraint.activate([
            
            alertView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 52
            ),
            alertView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -52
            ),
            alertView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
        
            titleAlert.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor,
                constant: 16
            ),
            titleAlert.topAnchor.constraint(
                equalTo: alertView.topAnchor,
                constant: 16
            ),
            titleAlert.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor,
                constant: -16
            ),

            firstSeparatorLine.heightAnchor.constraint(
                equalToConstant: 0.5
            ),
            firstSeparatorLine.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor
            ),
            firstSeparatorLine.topAnchor.constraint(
                equalTo: titleAlert.bottomAnchor,
                constant: 16
            ),
            firstSeparatorLine.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor
            ),

            accessButton.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor,
                constant: 41
            ),
            accessButton.topAnchor.constraint(
                equalTo: firstSeparatorLine.bottomAnchor,
                constant: 11
            ),
            accessButton.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor,
                constant: -41
            ),
            
            secondSeparatorLine.heightAnchor.constraint(
                equalToConstant: 0.5
            ),
            secondSeparatorLine.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor
            ),
            secondSeparatorLine.topAnchor.constraint(
                equalTo: accessButton.bottomAnchor,
                constant: 11
            ),
            secondSeparatorLine.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor
            ),

            cancelButton.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor,
                constant: 41
            ),
            cancelButton.topAnchor.constraint(
                equalTo: secondSeparatorLine.bottomAnchor,
                constant: 11
            ),
            cancelButton.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor,
                constant: -41
            ),
            cancelButton.bottomAnchor.constraint(
                equalTo: alertView.bottomAnchor, constant: -11
            )
        ])

        if let accessHandler = accessHandler {
            accessButtonTappedHandler = accessHandler
        }
        if let cancelHandler = cancelHandler {
            cancelButtonTappedHandler = cancelHandler
        }
    }
    
    @objc private func openList() {
        accessButtonTappedHandler?()
        alertView.removeFromSuperview()
    }
    
    @objc private func cancelAccess() {
        cancelButtonTappedHandler?()
        alertView.removeFromSuperview()
    }
}
