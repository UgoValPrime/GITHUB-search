import Foundation
import UIKit

public struct API {
    public static let baseUrl = "https://api.github.com"
    public static let userPath = "/search/users?q="
    public static let repoPath = "/search/repositories?q="
    public static let cache = NSCache<NSString, UIImage>()
}


public struct Controller  {
    public static let monitor = "Monitor"
    public static let title = "News Feed"
}
