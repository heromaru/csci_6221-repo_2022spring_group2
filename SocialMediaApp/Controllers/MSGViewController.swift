//
//  ChatViewController.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/7/22.
//

import UIKit
import MessageKit

class MSGViewController: UIViewController {
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        
    
        // Do any additional setup after loading the view.
    }
}

extension MSGViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesReusable", for: indexPath)
        cell.textLabel?.text = "Bob (test)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController()
        vc.title = "Chat"
        navigationController?.pushViewController(vc, animated: true)
    }
}


