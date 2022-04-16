//
//  HomeViewController.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/7/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseAnalytics

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var posts : [Post] =  [
        Post(id: "1", author: "Oğuzhan Yangöz", text: "I LOVE NUTELLLA!",  time: "4 minutes ago"),
        Post(id: "2", author: "Oğuzhan Yangöz", text: "I hate mondays...", time: "2 hours ago"),
        Post(id: "3", author: "Quisch Kin", text: "I love math!", time: "42 minutes ago"),
        Post(id: "4", author: "Ouisch Kin", text: "Messi is my fav player!", time: "47 minutes ago"),
        Post(id: "5", author: "Joe Biden", text: " I will be a candidate again!", time: "2 days ago"),
        Post(id: "6", author: "Joe Biden", text: "I am the  46th US president! ",time: "2 days ago")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let cellNib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "PostCell")
        view.addSubview(tableView)
        

        
        var layoutGuide: UILayoutGuide
        
        layoutGuide = view.safeAreaLayoutGuide
        
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
    }
    
    
    @IBAction func newPostPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "HomeToNewPost", sender: self)
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
}
