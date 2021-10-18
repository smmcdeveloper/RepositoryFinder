//
//  RepoListResponse.swift
//  RepositoryFinder
//
//  Created by SMMC on 17/10/2021.
//


import Foundation

struct RepoListResponse : Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

