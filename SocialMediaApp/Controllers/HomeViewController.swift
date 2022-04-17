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
    //var posts : [Post] =  [
    //    Post(author: "Joe Biden", text: "I LOVE NUTELLLA!",  time: "4 minutes ago"),
    //    Post(author: "Oğuzhan Yangöz", text: "I hate mondays...", time: "2 hours ago"),
    //]
    
    var posts =  [Post]()
    
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
        
        observePosts()
        
    }
    
    func observePosts() {
    
        let refPosts = VARIABLES.database.child("posts")
        refPosts.observe(.value) { snapshot in

            if snapshot.childrenCount>0 {
                self.posts.removeAll()
                for post in snapshot.children.allObjects as! [DataSnapshot] {

                    let postObject = post.value as? [String: AnyObject]
                    let postText = postObject?["text"]
                    let postUsername = postObject?["username"]
                    let postTimestamp = postObject?["timestamp"]

                    let post =  Post(author: postUsername as? String ?? "error username", text: postText as? String ?? "error text" , time: postTimestamp as? String ?? "some value" )
                    print(post)
                    self.posts.insert(post, at: 0)
                    

                }
            self.tableView.reloadData()

            }
        }
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
        //cell.set(post: posts[indexPath.row])
        let post : Post
        post = posts[indexPath.row]
        
        cell.postTextLabel.text = post.text
        cell.usernameLabel.text = post.author
        cell.subtitleLabel.text = post.time
        
        return cell
    }
}
