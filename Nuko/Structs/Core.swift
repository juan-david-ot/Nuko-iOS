//
//  Core.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import Foundation

nonisolated struct Core: Codable, Sendable, Identifiable {
    let id: String?
    let name: String?
    let creatorId: String?
    let createdAt: Date?
    let users: [User]?
}

nonisolated struct CoreUser: Codable, Sendable {
    let id: String?
    let coreId: String?
    let userId: String?
    let roleId: String?
}

nonisolated struct CoreInformation: Codable, Sendable {
    let id: String
    let name: String
    let creatorId: String?
    let createdAt: Date?
    let users: [User]
}
