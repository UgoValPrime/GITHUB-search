import Foundation
import UIKit

protocol GitProtocol{
    func getUserRepoDetails(url: String, completion: @escaping(Result<[ReposListDataResponse],UserError>) -> Void)
    func getUserDetails(url: String, completion: @escaping(Result<UserDataModelResponse,UserError>) -> Void)
    func getUsersListData(searchQuery: String, PageNumber: Int, completion: @escaping(Result<SearchUserDataModel,UserError>) -> Void)
    func getReposListData(searchQuery: String, PageNumber: Int, completion: @escaping(Result<SearchRepositoryDataModel, UserError>) -> Void)
}

struct GitResource: GitProtocol {

    private var httpUtility: UtilityService
    private var repoUrlString: String = "\(API.baseUrl)\(API.repoPath)"
    private var userUrlString: String = "\(API.baseUrl)\(API.userPath)"

    init(httpUtility: UtilityService = HTTPUtility()){
        self.httpUtility = httpUtility
    }


    func getUserRepoDetails(url: String, completion: @escaping (Result<[ReposListDataResponse], UserError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.InvalidURL))
            return
        }
        httpUtility.performDataTask(url: url, resultType: [ReposListDataResponse].self) { result in
            switch result {
            case .success(let jsonData):
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getUserDetails(url: String, completion: @escaping (Result<UserDataModelResponse, UserError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.InvalidURL))
            return
        }
        httpUtility.performDataTask(url: url, resultType: UserDataModelResponse.self) { result in
            switch result {
            case .success(let jsonData):
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getUsersListData(searchQuery: String, PageNumber: Int, completion: @escaping (Result<SearchUserDataModel, UserError>) -> Void) {
        guard let url = URL(string: userUrlString + searchQuery + "&page=" + String(PageNumber)) else {
            completion(.failure(.InvalidURL))
            return
        }
        httpUtility.performDataTask(url: url, resultType: SearchUserDataModel.self) { result in
            switch result {
            case .success(let jsonData):
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getReposListData(searchQuery: String, PageNumber: Int, completion: @escaping(Result<SearchRepositoryDataModel, UserError>) -> Void){
        guard let url = URL(string: repoUrlString + searchQuery + "&page=" + String(PageNumber)) else {
            completion(.failure(.InvalidURL))
            return
        }
        httpUtility.performDataTask(url: url, resultType: SearchRepositoryDataModel.self) { result in
            switch result {
            case .success(let jsonData):
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
