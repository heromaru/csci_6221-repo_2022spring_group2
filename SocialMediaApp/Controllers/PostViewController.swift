//
//  PostViewController.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/12/22.
//

import UIKit
import Firebase

class PostViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var discardButton: UIBarButtonItem!
    @IBOutlet weak var postContent: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendButtonPressed(_ sender: UIBarButtonItem) {
        
        let posts = VARIABLES.database.child("posts").childByAutoId()
        let user = Auth.auth().currentUser
        

        let postObject: [String: Any] =  [
            //"username": registerController.userNameTextField ?? "some_user",
            "username": user?.displayName ?? "some_user",
            "text" : postContent.text ?? "Something went wrong. Check the code.. - PostViewController - sendButtonPressed.",
            "timestamp" : [".sv" : "timestamp"]

        ] as [String : Any]
        posts.setValue(postObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
                       
                       
    @IBAction func discardButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }


}
