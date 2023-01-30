import Foundation

// MARK: - Welcome
struct SearchRepositoryDataModel: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [SearchRepositoryDataModelResponse]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Item
struct SearchRepositoryDataModelResponse: Codable, Identifiable {
    let id: Int?
    let nodeID, name, fullName: String?
    let owner: Owner?
    let description: String?
    let watchersCount: Int?
    let language: String?
    let watchers: Int?
    let topics: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case description
        case watchersCount = "watchers_count"
        case language
        case topics
        case watchers
    
    }
}



// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"

    }
}
