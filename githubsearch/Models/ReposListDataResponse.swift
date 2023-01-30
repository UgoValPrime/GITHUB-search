
import Foundation

// MARK: - WelcomeElement
struct ReposListDataResponse: Codable, Identifiable {
    let id: Int?
    let nodeID, name, fullName: String?
    let welcomePrivate: Bool?
    let owner: RepoOwner?
    let updatedAt: String?
    let language: String?
    let description: String?
    let size, stargazersCount, watchersCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case welcomePrivate = "private"
        case owner
        case updatedAt = "updated_at"
        case size, language, description
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
    }
}


// MARK: - Owner
struct RepoOwner: Codable {
    let login: String?
    let id: Int?
    let avatarURL: String?
    let htmlURL: String?
    

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        
    }
}

