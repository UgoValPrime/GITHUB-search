import Foundation
import UIKit

public enum UserError: LocalizedError{
    case NoDataAvailable
    case CannotProcessData
    case InvalidURL
}

public protocol UtilityService {
    func performDataTask<T: Decodable>(url: URL, resultType: T.Type, completion: @escaping (Result<T, UserError>) -> Void)
}

public struct HTTPUtility: UtilityService {

    public func performDataTask<T: Decodable>(
        url: URL,
        resultType: T.Type,
        completion: @escaping (Result<T, UserError>) -> Void) {
            guard url != URL(string: "") else {
                completion(.failure(.InvalidURL))
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                
                    completion(.failure(.NoDataAvailable))
                    return
                }

                guard let response = response
                        as? HTTPURLResponse, (200..<210).contains(response.statusCode) else {
                    print("the reason for the crash>>>>\(response)")
                    completion(.failure(.CannotProcessData))
                    return
                }

                guard let data = data else {
                    print("the reason for the crashhh>>>>\(data)")
                    completion(.failure(.NoDataAvailable))
                    return
                }

                let decoder = JSONDecoder()

                do {
                    let jsonData = try decoder.decode(T.self, from: data)
                    _ = completion(.success(jsonData))
                } catch {
                    _ = completion(.failure(.CannotProcessData))
                }
            }.resume()
        }
    public init () {}
}
