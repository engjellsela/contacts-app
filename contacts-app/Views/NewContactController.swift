//
//  NewContactController.swift
//  contacts-app
//
//  Created by Engjell Sela on 9.5.24.
//

import UIKit

protocol NewContactControllerDelegate: AnyObject {
    func createNewContact(cname: String, cphone: String, cemail: String)
}

class NewContactController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: NewContactControllerDelegate?
    @IBOutlet var addContactBtn: UIBarButtonItem!
    @IBOutlet var nameInputField: UITextField!
    @IBOutlet var phoneInputField: UITextField!
    @IBOutlet var emailInputField: UITextField!
    @IBOutlet var contactLetter: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
     
        addContactBtn.isEnabled = false
        
        contactLetter.layer.masksToBounds = true
        contactLetter.layer.cornerRadius = 30
        
        nameInputField.delegate = self
        
        phoneInputField.delegate = self
        
        emailInputField.delegate = self
             
        contactLetter.text = ""
        
    }
    
    @IBAction func addContact(_ sender: Any) {
                        
        delegate?.createNewContact(cname: nameInputField.text ?? "", cphone: phoneInputField.text ?? "", cemail: emailInputField.text ?? "")

        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelContactCreation(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if nameInputField.text != "" || phoneInputField.text != "" || emailInputField.text != "" {
            
            if textField == nameInputField {
                
                if let text = nameInputField.text, let getContactLetter = text.first {
                    contactLetter.text = String(getContactLetter.uppercased())
                }
                
            } else if nameInputField.text == "" {
                contactLetter.text = ""
            }
            
            addContactBtn.isEnabled = true
        } else {
            addContactBtn.isEnabled = false
        }

        return true
    }
    
}
