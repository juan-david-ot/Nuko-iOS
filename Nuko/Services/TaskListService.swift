//
//  TaskListService.swift
//  Nuko
//
//  Created by JuanDa on 07/11/2026.
//

import Alamofire
enum TaskListService {
    static func getTaskListsByCoreId(_ coreId: String) async throws -> [TaskList] {
        let request = AF.shared
            .request("\(AF.baseURL)/task-lists/cores/\(coreId)", method: .get)
            .validate()
        
        return try await decode([TaskList].self, from: request)
    }
}
