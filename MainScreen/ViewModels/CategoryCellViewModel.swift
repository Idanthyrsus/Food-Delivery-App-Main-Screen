//
//  CategoryCellViewModel.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation

enum CategoryType: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case tacos = "Tacos"
    case drinks = "Cocktails"
}

struct CategoryCellViewModel {
    let categories: [CategoryType] = CategoryType.allCases
}
