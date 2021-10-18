//
//  ListViewModel.swift
//  RepositoryFinder
//
//  Created by SMMC on 17/10/2021.
//

import Foundation

public class ListViewModel {
 
    var repositories: Box<RepoListResponse?> = Box(nil)
        
    func searchRepositories(_ text: String) {
    
        GitHubService.fetchRepositories(searchText: text) {  [weak self] (repositoriesData, error) in
        guard
            let self = self,
            let repositoriesData = repositoriesData
            else {
            return
            }
       
        self.repositories.value = repositoriesData
    }
 }
}
