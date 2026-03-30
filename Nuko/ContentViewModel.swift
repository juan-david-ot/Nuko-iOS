//
//  File.swift
//  Nuko
//
//  Created by JuanDa on 29/3/26.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func example(text: String) {
        print(text)
    }
    
    func requestExample() async throws -> String {
        let url = URL(string: "example")
        let (data, response) = try await URLSession.shared.data(from: url!)
        return "working"
    }
}
