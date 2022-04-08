//
//  HomeViewController.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/7/22.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var posts : [Post] = [
        Post(author: "Oğuzhan Yangöz", text: "hello hello "),
        Post(author: "Emre Gokbudak", text: "merhaba, nasil keyifler?")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        self.tabBarController?.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func newPostButtonPressedd(_ sender: Any) {
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.tabBarController?.navigationController?.popToRootViewController(animated: true)
           
        }   catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            }
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].author + " - " + posts[indexPath.row].text
        return cell
    }
}
