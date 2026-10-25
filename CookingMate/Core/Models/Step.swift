//
//  Step.swift
//  CookingMate
//
//  Created by Johann Schneider on 22.08.26.
//

import Foundation

struct StepDTO: Decodable {
    let id: UUID
    let description: String
    let order: Int

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case order = "step_order"
    }
}

struct Step: Identifiable {
    let id: UUID
    var serverID: UUID?
    var description: String
    var order: Int

    init(
        id: UUID = UUID(),
        serverID: UUID? = nil,
        description: String,
        order: Int
    ) {
        self.id = id
        self.serverID = serverID
        self.description = description
        self.order = order
    }

    init(dto: StepDTO) {
        self.init(
            serverID: dto.id.normalizedServerID,
            description: dto.description,
            order: dto.order
        )
    }
}
