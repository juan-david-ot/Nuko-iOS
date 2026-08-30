//
//  Core.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import Foundation

nonisolated struct Core: Codable, Sendable, Identifiable {
    var id: String? = nil
    var name: String? = nil
    var creatorId: String? = nil
    var createdAt: Date? = nil
    var users: [User]? = nil
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
