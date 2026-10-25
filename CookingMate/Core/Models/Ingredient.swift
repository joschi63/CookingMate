//
//  Ingredient.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import Foundation

struct IngredientDTO: Decodable {
    let id: UUID
    let name: String
    let amount: Float
    let unit: String
    let replacementProd: UUID?
    let animalProd: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case amount
        case unit
        case replacementProd = "replacement_prod"
        case animalProd = "animal_prod"
    }
}

struct Ingredient: Identifiable {
    let id: UUID
    var serverID: UUID?
    var name: String
    var amount: Float
    var unit: String
    var replacementProd: UUID?
    var animalProd: Bool

    init(
        id: UUID = UUID(),
        serverID: UUID? = nil,
        name: String,
        amount: Float,
        unit: String,
        replacementProd: UUID?,
        animalProd: Bool
    ) {
        self.id = id
        self.serverID = serverID
        self.name = name
        self.amount = amount
        self.unit = unit
        self.replacementProd = replacementProd
        self.animalProd = animalProd
    }

    init(dto: IngredientDTO) {
        self.init(
            serverID: dto.id.normalizedServerID,
            name: dto.name,
            amount: dto.amount,
            unit: dto.unit,
            replacementProd: dto.replacementProd,
            animalProd: dto.animalProd
        )
    }
}
