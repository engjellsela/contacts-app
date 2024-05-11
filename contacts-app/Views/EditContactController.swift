import UIKit

protocol EditContactControllerDelegate: AnyObject {
    func deleteContactState(state: Bool)
    func updateContactDetails(cindex: Int, cname: String, cphone: String, cemail: String)
}

class EditContactController: UIViewController {
    
    var name: String?
    var phone: String?
    var email: String?
    
    weak var delegate: EditContactControllerDelegate?
    @IBOutlet var editContactBtn: UIBarButtonItem!
    @IBOutlet var contactLetter: UILabel!
    @IBOutlet var contactName: UITextField!
    @IBOutlet var contactPhone: UITextField!
    @IBOutlet var contactEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editContactBtn.isEnabled = false
        
        contactLetter.layer.masksToBounds = true
        contactLetter.layer.cornerRadius = 30
        
        if let getName = name {
            
            // handle contact letter
            if let getContactLetter = getName.first {
            
                contactLetter.text = String(getContactLetter)
                
            } else {
                
                contactLetter.text = ""
                
            }
            
            contactName.text = getName
            
        }
        
        contactPhone.text = phone ?? ""
        
        contactEmail.text = email ?? ""

    }
    
    @IBAction func nameInputChanged(_ sender: Any) {
                
        if let updatedNameField = contactName.text {
            
            editContactBtn.isEnabled = updatedNameField != name ? true : false

            contactLetter.text = String(updatedNameField.prefix(1)).uppercased()

        }
        
    }
    
    
    @IBAction func phoneInputChanged(_ sender: Any) {
        
        if let updatedPhoneField = contactPhone.text {
            
            editContactBtn.isEnabled = updatedPhoneField != phone ? true : false

            contactLetter.text = String(updatedPhoneField.prefix(1)).uppercased()

        }
        
    }
    
    @IBAction func emailInputChanged(_ sender: Any) {
        
        if let updatedEmailField = contactEmail.text {
            
            editContactBtn.isEnabled = updatedEmailField != email ? true : false

            contactLetter.text = String(updatedEmailField.prefix(1)).uppercased()

        }
            
    }
    
    @IBAction func updateContact(_ sender: Any) {
            
        delegate?.updateContactDetails(cindex: nil ?? -1, cname: contactName.text ?? "", cphone: contactPhone.text ?? "", cemail: contactEmail.text ?? "")
                
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        
        // set alert title & msg to null, hide title section
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // delete action
        let deleteAction = UIAlertAction(title: "Delete Contact", style: .default) { (action:UIAlertAction) in
            self.deleteContactState(state: true)
        }
        
        deleteAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        alertController.addAction(deleteAction)
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // present alert
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func deleteContactState(state: Bool) {
        
        delegate?.deleteContactState(state: true)
        
    }
    
}
