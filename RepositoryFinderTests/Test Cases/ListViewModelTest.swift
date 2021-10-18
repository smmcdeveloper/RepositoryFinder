//
//  ListViewModelTest.swift
//  RepositoryFinderTests
//
//  Created by SMMC on 17/10/2021.
//

import XCTest
@testable import RepositoryFinder

class ListViewModelTest: XCTestCase {
    
     var repositoriesResponse: RepoListResponse?
     
     override func setUp() {
         super.setUp()
         
         // Load Stub
         let data = loadStub(name: "gitHubRespositoryExample", extension: "json")
         
         // Initialize JSON Decoder
         let decoder = JSONDecoder()
         
         // Configure JSON Decoder
         decoder.dateDecodingStrategy = .secondsSince1970
         
         // Initialize repositories Response
         repositoriesResponse = try! decoder.decode(RepoListResponse.self, from: data)
     }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTotalCount() {
        
        XCTAssertEqual(repositoriesResponse?.totalCount, 220066)
    }
    
    func testIncompleteResults() {

        XCTAssertEqual(repositoriesResponse?.incompleteResults, false)
        
    }
    
    func testViewModelForFirstIndex() {
        
        let data = repositoriesResponse?.items[0]
        
        XCTAssertEqual(data?.name, "free-programming-books-zh_CN")
        XCTAssertEqual(data?.full_name, "justjavac/free-programming-books-zh_CN")
        XCTAssertEqual(data?.owner?.html_url, "https://github.com/justjavac")
    }
    
    func testViewModelForSecondIndex() {
        
        let data = repositoriesResponse?.items[1]
        
        XCTAssertEqual(data?.name, "swift")
        XCTAssertEqual(data?.full_name, "apple/swift")
        XCTAssertEqual(data?.owner?.html_url, "https://github.com/apple")
    }
}
