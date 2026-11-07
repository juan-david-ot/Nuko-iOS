//
//  TaskList.swift
//  Nuko
//
//  Created by JuanDa on 07/11/2026.
//

import Foundation

nonisolated struct TaskList: Codable, Sendable, Identifiable {
    var id: String? = nil
    var coreId: String? = nil
    var name: String? = nil
    var icon: String? = nil
    var color: String? = nil
    var position: Double? = nil
    var creatorId: String? = nil
    var archivedAt: Date? = nil
    var createdAt: Date? = nil
}
