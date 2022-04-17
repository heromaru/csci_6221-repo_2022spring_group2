//
//  RegisterViewController.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/7/22.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    var ref: DatabaseReference!
    
    //let database = Database.database().reference()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
        if let email = emailTextfField.text, let password =  passwordTextField.text, let username = userNameTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil  {
                    self.authenticationError(ErrorTittle: "Registration Error",
                                        ErrorMessage: "Please make sure your password and email meet all the requirements for registration")
                } else {
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = username
                    changeRequest?.commitChanges { (error) in
                      // ...
                    }
                    
                    self.saveUserInformationToDatabase(username: username, email: email, password: password)
                    self.matchUsernameWithDisplayName()
                    self.performSegue(withIdentifier: "RegisterToHome", sender: self)
                }
                
            }
        }
    }
    
    
    public func authenticationError(ErrorTittle: String, ErrorMessage: String) {
        let alert = UIAlertController(title: ErrorTittle,
                                  message: ErrorMessage,
                                  preferredStyle:UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func saveUserInformationToDatabase(username: String, email: String, password: String) {
        let object:[ String : Any] = [
            "name": username,
            "email": email,
            "password": password,
        ]
        
        
        VARIABLES.database.child("users").childByAutoId().setValue(object)
        
    }
    
    private func matchUsernameWithDisplayName() {
        let user = Auth.auth().currentUser
           if let user = user {
               let changeRequest = user.createProfileChangeRequest()

               changeRequest.displayName = userNameTextField.text
               changeRequest.commitChanges { error in
                   if error != nil {
                    // Edit this later to customize error messages  - oguzhan
                } else {
                  // Profile updated. - oguzhan
                }
              }
            }
    }
    

    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
