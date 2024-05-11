//
//  ContactDetailsController.swift
//  contacts-app
//
//  Created by Engjell Sela on 3.5.24.
//

import UIKit

protocol ContactDetailsControllerDelegate: AnyObject {
    func updateContact(cindex: Int, cname: String, cphone: String, cemail: String)
    func deleteContact(dname: String, dphone: String, demail: String)
}

class ContactDetailsController: UIViewController, EditContactControllerDelegate {
    
    weak var delegate: ContactDetailsControllerDelegate?
    
    @IBOutlet weak var contactLetter: UILabel!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var phoneNumSection: UIView!
    @IBOutlet weak var messageBoxSection: UIView!
    @IBOutlet weak var mobileBoxSection: UIView!
    @IBOutlet weak var facetimeBoxSection: UIView!
    @IBOutlet weak var emailBoxSection: UIView!
    @IBOutlet weak var payBoxSection: UIView!
    @IBOutlet weak var contactEmailBoxSection: UIView!
    
    var index: Int?
    var name: String?
    var phone: String?
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set corners to rounded
        contactLetter.layer.masksToBounds = true
        contactLetter.layer.cornerRadius = 30
        phoneNumSection.layer.masksToBounds = true
        phoneNumSection.layer.cornerRadius = 5
        messageBoxSection.layer.masksToBounds = true
        messageBoxSection.layer.cornerRadius = 5
        mobileBoxSection.layer.masksToBounds = true
        mobileBoxSection.layer.cornerRadius = 5
        facetimeBoxSection.layer.masksToBounds = true
        facetimeBoxSection.layer.cornerRadius = 5
        emailBoxSection.layer.masksToBounds = true
        emailBoxSection.layer.cornerRadius = 5
        payBoxSection.layer.masksToBounds = true
        payBoxSection.layer.cornerRadius = 5
        contactEmailBoxSection.layer.masksToBounds = true
        contactEmailBoxSection.layer.cornerRadius = 5
        
        if let getName = name {

            // handle contact letter
            if let getContactLetter = getName.first {
            
                contactLetter.text = String(getContactLetter)
                
            } else {
                
                contactLetter.text = ""
                
            }
            
            contactName.text = getName
            
        } else {
        
            contactLetter.text = ""
            contactName.text = ""
            
        }
        
        contactPhone.text = phone ?? ""
        
        contactEmail.text = email ?? ""
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "goToContactEditPage" {
         
            if let destinationVC = segue.destination as? EditContactController {
                
                destinationVC.delegate = self
                destinationVC.name = name
                destinationVC.phone = phone
                destinationVC.email = email

            }
            
        }
        
    }
    
    func deleteContactState(state: Bool) {
        if (state) {
            delegate?.deleteContact(dname: name ?? "", dphone: phone ?? "", demail: email ?? "")
        }
    }
    
    func updateContactDetails(cindex: Int, cname: String, cphone: String, cemail: String) {
                
        contactLetter.text = cname.prefix(1).uppercased()
        contactName.text = cname
        contactPhone.text = cphone
        contactEmail.text = cemail
        
        delegate?.updateContact(cindex: index!, cname: cname, cphone: cphone, cemail: cemail)
        
    }

}
