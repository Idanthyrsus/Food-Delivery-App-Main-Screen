
import Foundation

// MARK: - MexicanFoodElement
struct MexicanFoodElement: Codable {
    let id, title: String?
    let difficulty: Difficulty?
    let image: String?
}

enum Difficulty: String, Codable {
    case easy = "Easy"
    case medium = "Medium"
}

typealias MexicanFood = [MexicanFoodElement]
