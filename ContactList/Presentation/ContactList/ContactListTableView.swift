import UIKit
import Contacts

private let cellIdentifier = "contactCell"

final class ContactListTableView: UITableViewController {
    
    var contacts: [CNContact] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        navigationController?.navigationBar.backgroundColor = .customBlack
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func configTableView() {
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.backgroundColor = .customBlack
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }
}

extension ContactListTableView {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        CustomHeaderTableView()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        124
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
        
        let contact = contacts[indexPath.row]
        cell.configCell(for: cell, from: contact, with: indexPath)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let separator = UIView(frame: CGRect(x: 0, y: cell.frame.size.height, width: cell.frame.size.width, height: 4))
//        separator.backgroundColor = .customBlack
//        cell.addSubview(separator)
//    }

}
