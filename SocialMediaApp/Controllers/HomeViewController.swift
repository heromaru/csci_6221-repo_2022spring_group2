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
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView = UITableView(frame: view.bounds, style: .plain)
        
       
        
        let cellNib = UINib(nibName: "PostCell", bundle: nil)
        homeTableView.register(cellNib, forCellReuseIdentifier: "ReusableCell")
        view.addSubview(homeTableView)
        
        var layoutGuide: UILayoutGuide
        layoutGuide = view.safeAreaLayoutGuide
        
        homeTableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        homeTableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        homeTableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
    
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.tableFooterView = UIView()
        homeTableView.backgroundColor = UIColor.blue
        homeTableView.reloadData()
        
        observePosts()

        // Do any additional setup after loading the view.
    }
    
    func observePosts() {
        let postsRef = Database.database().reference().child("posts")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Post]{}
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let uid = author["uid"] as? String,
                    let username = author["username"] as? String,
                    let photoURL = author["photoURL"] as? String,
                    let url = URL(string:photoURL),
                    let text = dict["text"] as? String,
                    let timestamp = dict["timestamp"] as? Double {
                    
                    let userProfile = UserProfile(uid: uid, username: username, photoURL: url)
                    let post = Post(id: childSnapshot.key, author: userProfile, text: text, timestamp:timestamp)
                    tempPosts.append(post)
                }
            }
            
            self.posts = tempPosts
            self.tableView.reloadData()
            
        })
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! PostCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
}
