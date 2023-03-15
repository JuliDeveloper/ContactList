import UIKit

final class CustomHeaderTableView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Контакты"
        label.textColor = .customWhite
        label.font = .boldSystemFont(ofSize: 34)
        return label
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "sortButton"), for: .normal)
        button.tintColor = .customWhite
        button.addTarget(self, action: #selector(sortedContact), for: .touchUpInside)
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "filterButton"), for: .normal)
        button.tintColor = .customWhite
        button.addTarget(self, action: #selector(filteredContact), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeader() {
        setupConstraints()
    }
    
    private func showButtonStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [
            filterButton, sortButton
        ])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 21
        return stack
    }
    
    private func showHeaderStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel, showButtonStackView()
        ])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 17
        return stack
    }
    
    private func setupConstraints() {
        let headerStack = showHeaderStackView()
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerStack)
        
        NSLayoutConstraint.activate([
            headerStack.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            headerStack.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 0
            ),
            headerStack.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            headerStack.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -31
            )
        ])
    }
    
    @objc private func sortedContact() {
        print("sortedContact")
    }
    
    @objc private func filteredContact() {
        print("filteredContact")
    }
    
}
