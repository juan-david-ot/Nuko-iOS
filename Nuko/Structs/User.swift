//
//  User.swift
//  Nuko
//
//  Created by JuanDa on 26/08/2026.
//

import Foundation

nonisolated struct User: Codable, Sendable {
    var id: String? = nil
    var email: String? = nil
    var username: String? = nil
    var password: String? = nil
    var name: String? = nil
    var surname: String? = nil
    var createdAt: Date? = nil
    var passwordChangedAt: Date? = nil
}
