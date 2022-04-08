//
//  RegisterViewController.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/7/22.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextfField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
        if let email = emailTextfField.text, let password =  passwordTextField.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil  {
                    self.authenticationError(ErrorTittle: "Registration Error",
                                        ErrorMessage: "Please make sure your password and email meet all the requirements for registration")
                } else {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
