//
//  ContactViewController.swift
//  TableViewRealmSync
//
//  Created by Josman Pedro Pérez Expósito on 24/12/20.
//

import UIKit
import RealmSwift

class ContactViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var contact:Contact?
    var realm: Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFields()
    }
    
    func configureFields() {
        guard let _contact = contact else { return }
        firstName.text = _contact.firstName
        lastName.text = _contact.lastName
    }
    
    func setFeedbackLabel(with text: String, error: Bool) {
        errorLabel.textColor = error ? UIColor.systemRed : UIColor.systemGreen
        errorLabel.text = text
    }

    /// This will be better if detect if there is no change made
    @IBAction func updateContact(_ sender: Any) {
        if !firstName.hasText || !lastName.hasText {
            setFeedbackLabel(with: "FirstName & LastName are mandatory fields", error: true)
        } else {
            guard let realm = realm, let _firstName = firstName.text, let _lastName = lastName.text else {
                return
            }
            errorLabel.text?.removeAll()
            do {
                try realm.write {
                    contact?.firstName = _firstName
                    contact?.lastName = _lastName
                    self.navigationController?.popViewController(animated: true)
                }
            } catch (let error) {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
