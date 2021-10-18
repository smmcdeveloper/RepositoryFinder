//
//  ListViewController.swift
//  RepositoryFinder
//
//  Created by SMMC on 15/10/2021.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
            self.searchBar.placeholder = "Search repositories"
        }
    }
    
    private let viewModel = ListViewModel()
    private var repositories : RepoListResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.repositories.bind{ [weak self] repositories in
            self?.repositories = repositories
            self?.tableView.reloadData()
        }
        
    }
}

// MARK: - TableViewDelegate methods

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard (repositories?.items.count) != nil else {
            return 0
        }
        
        return (repositories?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repository", for: indexPath) as? RepositoryTableViewCell else { fatalError() }
        
        let cellData = repositories?.items[indexPath.row]
        cell.configureCell(name: cellData?.name ?? "", fullName: cellData?.full_name ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let storyboard = self.storyboard else { return }
        
        let cellData = repositories?.items[indexPath.row]
        guard let url = cellData?.owner?.html_url else { return }
        
        let repositoryViewController = storyboard.instantiateViewController(withIdentifier: "RepositoryViewController") as! RepositoryViewController
        repositoryViewController.url = URL(string: url)
        repositoryViewController.title = cellData?.full_name
        self.navigationController?.pushViewController(repositoryViewController, animated: true)
    }
}
    
// MARK: - UISearchBarDelegate methods
extension ListViewController: UISearchBarDelegate{
       
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        
        let whitespace = NSCharacterSet.whitespaces
        let phrase = query
        let range = phrase.rangeOfCharacter(from: whitespace)
        
        if range == nil {
            self.title = query
            self.searchBar.text = ""
            self.viewModel.searchRepositories(query)
        }
    }
    
}

  
 
      
                          
