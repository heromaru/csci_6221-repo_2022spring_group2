//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/4/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func NewPostButtonPressed(_ sender: UIButton) {
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    
  
    
}

