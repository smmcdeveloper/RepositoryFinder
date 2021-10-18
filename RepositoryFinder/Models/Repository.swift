//
//  Repository.swift
//  RepositoryFinder
//
//  Created by SMMC on 17/10/2021.
//

import Foundation

import Foundation

struct Repository: Codable {
    let id: Int?
    let name: String?
    let full_name: String?
    let owner: Owner?
}
