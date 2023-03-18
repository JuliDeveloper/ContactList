import UIKit

private let identifierSortCell = "sortCell"

protocol SortListTableViewControllerDelegate: AnyObject {
    func switchButton()
}

final class SortListTableViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .customBlack
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 11
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.configure(
            title: "Сбросить",
            backgroundColor: .customBlack
        )
        button.addTarget(
            self,
            action: #selector(close),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.configure(
            title: "Применить",
            backgroundColor: .customLightGray
        )
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    
    private let titleList = [
        "По имени (А-Я / A-Z)",
        "По имени (Я-А / Z-A)",
        "По фамилии (А-Я / A-Z)",
        "По фамилии (Я-А / Z-A)"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlack
        configureTableView()
        addElements()
        configureConstraints()
    }
    
    private func configureTableView() {
        tableView.register(SortCell.self, forCellReuseIdentifier: identifierSortCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    private func addElements() {
        view.addSubview(tableView)
        view.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(cancelButton)
        buttonStack.addArrangedSubview(saveButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 46
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            tableView.bottomAnchor.constraint(
                equalTo: buttonStack.topAnchor
            ),
            
            buttonStack.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            buttonStack.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24
            ),
            buttonStack.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            )
        ])
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
    @objc private func save() {
        dismiss(animated: true)
    }
}

extension SortListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierSortCell, for: indexPath) as? SortCell
        else {
            return UITableViewCell()
        }
        
        let title = titleList[indexPath.row]
        cell.configCell(for: cell, title: title, delegate: self)
        
        return cell
    }
}

extension SortListTableViewController: SortListTableViewControllerDelegate {
    func switchButton() {
        saveButton.backgroundColor = .customBlue
    }
}
