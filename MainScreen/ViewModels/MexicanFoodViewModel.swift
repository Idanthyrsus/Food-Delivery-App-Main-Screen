

import Foundation

struct MexicanFoodViewModel {
    let title: String
    let difficulty: Difficulty?
    let image: String
    let price: String
    
    init(using foodModel: MexicanFoodElement) {
        self.title = foodModel.title ?? "none"
        self.difficulty = foodModel.difficulty
        self.image = foodModel.image ?? "not available"
        self.price = "от 345 р."
    }
}
