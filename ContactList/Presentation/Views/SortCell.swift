import UIKit

final class SortCell: UITableViewCell {
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .customDarkGray
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customWhite
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let radioButton: RadioButton = {
        let button = RadioButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func configCell(for cell: SortCell, title: String) {
        backgroundColor = .clear
        titleLabel.text = title
        selectionStyle = .none
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        addSubview(mainView)
        
        mainView.addSubview(titleLabel)
        mainView.addSubview(radioButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            mainView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            mainView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            mainView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -4
            ),
            
            titleLabel.leadingAnchor.constraint(
                equalTo: mainView.leadingAnchor,
                constant: 16
            ),
            titleLabel.centerYAnchor.constraint(
                equalTo: mainView.centerYAnchor
            ),
            
            radioButton.trailingAnchor.constraint(
                equalTo: mainView.trailingAnchor,
                constant: -16
            ),
            radioButton.centerYAnchor.constraint(
                equalTo: mainView.centerYAnchor
            )
        ])
    }
}
