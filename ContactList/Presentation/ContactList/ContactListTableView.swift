import UIKit
import Contacts

private let cellIdentifier = "contactCell"

final class ContactListTableView: UITableViewController {
    
    var contacts: [CNContact] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    private func configTableView() {
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.backgroundColor = .customBlack
    }
}

extension ContactListTableView {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        CustomHeaderTableView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ContactCell
        else {
            return UITableViewCell()
        }
        
        return cell
    }
}
