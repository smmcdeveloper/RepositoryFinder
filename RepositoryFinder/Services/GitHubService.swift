//
//  GitHubService.swift
//  RepositoryFinder
//
//  Created by SMMC on 17/10/2021.
//


import Foundation

enum RepositoriesError: Error {
  case invalidResponse
  case noData
  case failedRequest
  case invalidData
}

class GitHubService {
  typealias RepositoriesDataCompletion = (RepoListResponse?, RepositoriesError?) -> ()
    
  static func queryItems(with parameters: [String : String]) -> [URLQueryItem] {
        return parameters.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
  }
    
  static func searchUrl(with query: String) -> URL? {
    var components = URLComponents()
    components.scheme = Constants.APIScheme
    components.host = Constants.APIHost
    components.path = Constants.APIPath
    components.queryItems = queryItems(with: ["q":query])

    return components.url
  }
  
  static func fetchRepositories(searchText: String, completion: @escaping RepositoriesDataCompletion) {
    
    guard let searchUrl = searchUrl(with: searchText) else { return }
   
    URLSession.shared.dataTask(with: searchUrl) { (data, response, error) in
     
      DispatchQueue.main.async {
        guard error == nil else {
          print("Failed request from repositories: \(error!.localizedDescription)")
          completion(nil, .failedRequest)
          return
        }
        
        guard let data = data else {
          print("No data returned from repositories")
          completion(nil, .noData)
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          print("Unable to process repositories response")
          completion(nil, .invalidResponse)
          return
        }
        
        guard response.statusCode == 200 else {
          print("Failure response from repositories: \(response.statusCode)")
          completion(nil, .failedRequest)
          return
        }
        
        do {
          let decoder = JSONDecoder()
          let repositoriesData: RepoListResponse = try decoder.decode(RepoListResponse.self, from: data)
          completion(repositoriesData, nil)
        } catch {
          print("Unable to decode repositoriesData response: \(error.localizedDescription)")
          completion(nil, .invalidData)
        }
      }
    }.resume()
  }
}

