import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NewContactControllerDelegate, ContactDetailsControllerDelegate {
        
    var contactList: [(name: String, phone: String, email: String)] = [("Adam", "070205446", "adam@gmail.com"), ("Ana", "070213555", "ana@gmail.com"), ("Bob", "071201118", "bob@gmail.com"), ("Chris", "077247550", "chris@gmail.com")]
    
    var searchedContacts: [(name: String, phone: String, email: String)] = []
    
    var contactsSearched: Bool = false
    
    @IBOutlet weak var textInput: UISearchBar!
    
    @IBOutlet weak var contactsTable: UITableView!
    
    @IBOutlet var contactLabel: UILabel!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textInput.delegate = self
        
        contactsTable.delegate = self
        
        contactsTable.dataSource = self
        
        contactsTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText == "") {
            
            contactsSearched = false

            contactsTable.reloadData()
            
        } else {

            contactsSearched = false
            
            searchedContacts = []
            
            for contact in contactList {

                if contact.name.lowercased().hasPrefix(searchText.lowercased()) {
                    
                    searchedContacts.append((name: contact.name, phone: contact.phone, email: contact.email))

                }

            }
            
            contactsSearched = true
            
            contactsTable.reloadData()
            
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        contactsSearched ? searchedContacts.count : contactList.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if contactsSearched == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = contactList[indexPath.row].name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = searchedContacts[indexPath.row].name
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRowIndex = indexPath.row
        let selectedContactName: String = contactsSearched ? searchedContacts[selectedRowIndex].name : contactList[selectedRowIndex].name
        let selectedContactPhone: String = contactsSearched ? searchedContacts[selectedRowIndex].phone : contactList[selectedRowIndex].phone
        let selectedContactEmail: String = contactsSearched ? searchedContacts[selectedRowIndex].email : contactList[selectedRowIndex].email

        let contactDetails = (index: selectedRowIndex, name: selectedContactName, phone: selectedContactPhone, email: selectedContactEmail)
                
        performSegue(withIdentifier: "goToContactDetailsPage", sender: contactDetails)
                        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToContactDetailsPage" {

            if let contactDetails = sender as? (index: Int, name: String, phone: String, email: String) {
                
                let destinationVC = segue.destination as? ContactDetailsController
                destinationVC?.index = contactDetails.index
                destinationVC?.name = contactDetails.name
                destinationVC?.phone = contactDetails.phone
                destinationVC?.email = contactDetails.email

            }
            
            if let destinationVC = segue.destination as? ContactDetailsController {
                destinationVC.delegate = self
            }
            
        }
        
        if segue.identifier == "goToNewContactPage" {
            
            if let destinationVC = segue.destination as? NewContactController {
                
                destinationVC.delegate = self
                
            }
            
        }
        
    }
    
    func createNewContact(cname: String, cphone: String, cemail: String) {
        
        contactList.append((name: cname, phone: cphone, email: cemail))
        
        contactsTable.reloadData()
        
    }
    
    func updateContact(cindex: Int, cname: String, cphone: String, cemail: String) {
                
        contactList[cindex] = (cname, cphone, cemail)
        
        contactsTable.reloadData()
        
        navigationController?.popViewController(animated: true)
    
    }
    
    func deleteContact(dname: String, dphone: String, demail: String) {
        
        if let contactIndex = contactList.firstIndex(where: { $0.name == dname && $0.phone == dphone && $0.email == demail }) {
                        
            contactList.remove(at: contactIndex)
            
            contactsTable.reloadData()
            
            if let targetViewController = navigationController?.viewControllers.first(where: { $0 is ViewController }) as? ViewController {
                navigationController?.popToViewController(targetViewController, animated: true)
            }

        }
        
    }

}
