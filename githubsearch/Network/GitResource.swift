import Foundation
import UIKit

protocol GitProtocol{
    func fetch<T: Decodable>(from urlString: String, resultType: T.Type, completion: @escaping (Result<T, UserError>) -> Void)
}

struct GitResource: GitProtocol {

    private var httpUtility: UtilityService
    private var repoUrlString: String = "\(API.baseUrl)\(API.repoPath)"
    private var userUrlString: String = "\(API.baseUrl)\(API.userPath)"

    init(httpUtility: UtilityService = HTTPUtility()){
        self.httpUtility = httpUtility
    }

    func fetch<T>(from urlString: String, resultType: T.Type, completion: @escaping (Result<T, UserError>) -> Void) where T : Decodable {
        guard let url = URL(string: urlString) else {
            completion(.failure(.InvalidURL))
            return
        }
        
        httpUtility.performDataTask(url: url, resultType: resultType, completion: completion)
    }
}
