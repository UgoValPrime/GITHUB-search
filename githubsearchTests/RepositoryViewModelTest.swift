//
//  RepositoryViewModelTest.swift
//  githubsearchTests
//
//  Created by  Henrietta Henry on 29/01/2023.
//

import XCTest
@testable import githubsearch

final class RepositoryViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        
        
    }

    override func tearDownWithError() throws {
        
        
    }

  

}

class MockGitResource: GitProtocol {
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func getUserRepoDetails(url: String, completion: @escaping (Result<[ReposListDataResponse], UserError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.InvalidURL))
        }
    }
    
    func getUserDetails(url: String, completion: @escaping (Result<UserDataModelResponse, UserError>) -> Void) {
        <#code#>
    }
    
    func getUsersListData(searchQuery: String, PageNumber: Int, completion: @escaping (Result<SearchUserDataModel, UserError>) -> Void) {
        <#code#>
    }
    
    func getReposListData(searchQuery: String, PageNumber: Int, completion: @escaping (Result<SearchRepositoryDataModel, UserError>) -> Void) {
        <#code#>
    }
    
    
}
