//
//  RecipeData.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import Foundation

struct RecipeDataDTO: Decodable {
    let id: UUID
    let name: String
    let author: String
    let portions: Int
    let sourceURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case author
        case portions
        case sourceURL = "source_url"
    }
}

struct RecipeData {
    var name: String
    var author: String
    var portions: Int
    var sourceURL: String

    init(
        name: String,
        author: String,
        portions: Int,
        sourceURL: String
    ) {
        self.name = name
        self.author = author
        self.portions = portions
        self.sourceURL = sourceURL
    }

    init(dto: RecipeDataDTO) {
        self.init(
            name: dto.name,
            author: dto.author,
            portions: dto.portions,
            sourceURL: dto.sourceURL
        )
    }
}
