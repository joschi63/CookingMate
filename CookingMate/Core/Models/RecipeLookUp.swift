//
//  RecipeLookUp.swift
//  CookingMate
//
//  Created by Johann Schneider on 13.09.26.
//

import Foundation

struct RecipeLookUpDTO: Decodable {
    let id: UUID
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "global_recipe_id"
        case name
    }
}

struct RecipeLookUp {
    let id: UUID
    var name: String

    init(
        id: UUID,
        name: String,
    ) {
        self.id = id
        self.name = name
    }

    init(dto: RecipeLookUpDTO) {
        self.init(
            id: dto.id,
            name: dto.name,
        )
    }
}

