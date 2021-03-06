//
//  XCTestCase.swift
//  RepositoryFinderTests
//
//  Created by SMMC on 17/10/2021.
//

import XCTest

extension XCTestCase {
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return try! Data(contentsOf: url!)
    }
}
