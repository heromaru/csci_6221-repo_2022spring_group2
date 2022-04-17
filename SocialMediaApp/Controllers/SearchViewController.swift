//
//  SearchViewController.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/7/22.
//

import UIKit

class resultsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    
    let searchController  = UISearchController(searchResultsController: resultsVC())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        

        // Do any additional setup after loading the view.
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
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
