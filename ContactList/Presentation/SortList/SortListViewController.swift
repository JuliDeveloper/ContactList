import UIKit
import Contacts

private let identifierSortCell = "sortCell"

protocol RadioButtonDelegate: AnyObject {
    func radioButtonSelected(_ radioButton: RadioButton)
}

protocol ContactsSortingDelegate: AnyObject {
    func didSortContacts(sortedContacts: [CNContact])
}

final class SortListViewController: UIViewController {
    
    private let smallView: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
            action: #selector(cancel),
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
        button.addTarget(
            self,
            action: #selector(save),
            for: .touchUpInside
        )
        return button
    }()
    
    private let titleList = [
        "По имени (А-Я / A-Z)",
        "По имени (Я-А / Z-A)",
        "По фамилии (А-Я / A-Z)",
        "По фамилии (Я-А / Z-A)"
    ]
    
    private var selectedIndexPath: IndexPath?
    
    weak var delegate: ContactsSortingDelegate?
    var contacts: [CNContact] = []

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
        tableView.separatorStyle = .none
    }
    
    private func addElements() {
        view.addSubview(smallView)
        view.addSubview(tableView)
        view.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(cancelButton)
        buttonStack.addArrangedSubview(saveButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            smallView.widthAnchor.constraint(
                equalToConstant: 50
            ),
            smallView.heightAnchor.constraint(
                equalToConstant: 4
            ),
            smallView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10
            ),
            smallView.centerXAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerXAnchor
            ),
            
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
    
    private func sortData() {
        if let indexPath = selectedIndexPath {
            switch indexPath.row {
            case SortList.sortNameAZ.rawValue:
                contacts.sort { contact1, contact2 in
                     contact1
                        .givenName
                        .localizedCaseInsensitiveCompare(
                            contact2.givenName
                        ) == .orderedAscending
                }
            case SortList.sortNameZA.rawValue:
                contacts.sort { contact1, contact2 in
                    contact2
                        .givenName
                        .localizedCaseInsensitiveCompare(
                            contact1.givenName
                        ) == .orderedAscending
                }
            case SortList.sortLastNameAZ.rawValue:
                contacts.sort { contact1, contact2 in
                     contact1
                        .familyName
                        .localizedCaseInsensitiveCompare(
                            contact2.familyName
                        ) == .orderedAscending
                }
            case SortList.sortLastNameZA.rawValue:
                contacts.sort { contact1, contact2 in
                    contact2
                        .familyName
                        .localizedCaseInsensitiveCompare(
                            contact1.familyName
                        ) == .orderedAscending
                }
            default:
                break
            }
            delegate?.didSortContacts(sortedContacts: contacts)
        }
    }
    
    func updateSaveButtonColor() {
        if selectedIndexPath != nil {
            saveButton.backgroundColor = .customBlue
        } else {
            saveButton.backgroundColor = .customLightGray
        }
    }
    
    func resetSelectionButton() {
        if let previousSelectedIndexPath = selectedIndexPath,
           let previousSelectedCell = tableView.cellForRow(at: previousSelectedIndexPath) as? SortCell {
            previousSelectedCell.radioButton.isSelected = false
        }
        
        selectedIndexPath = nil
        
        updateSaveButtonColor()
    }
    
    @objc private func cancel() {
        resetSelectionButton()
    }
    
    @objc private func save() {
        sortData()
        dismiss(animated: true)
    }
}

extension SortListViewController: UITableViewDelegate, UITableViewDataSource {
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

        cell.configCell(for: cell, title: title)
        cell.radioButton.delegate = self
        cell.radioButton.isSelected = indexPath == selectedIndexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SortCell else { return }
        cell.radioButton.sendActions(for: .touchUpInside)
    }
}

extension SortListViewController: RadioButtonDelegate {
    func radioButtonSelected(_ radioButton: RadioButton) {
        guard
            let indexPath = tableView.indexPath(for: radioButton.superview?.superview as? SortCell ?? UITableViewCell() )
        else { return }
        
        if let previousSelectedIndexPath = selectedIndexPath, let previousSelectedCell = tableView.cellForRow(at: previousSelectedIndexPath) as? SortCell {
            previousSelectedCell.radioButton.isSelected = false
        }
        
        selectedIndexPath = indexPath
        radioButton.isSelected = true
        updateSaveButtonColor()
    }
}
