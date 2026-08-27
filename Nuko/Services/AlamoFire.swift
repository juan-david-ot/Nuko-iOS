//
//  AlamoFire.swift
//  Nuko
//
//  Created by JuanDa on 26/08/2026.
//

import Foundation
import Alamofire

nonisolated struct MessageResponse: Decodable, Sendable {
    let message: String
}

// MARK: - Interceptor (equivalente al axios.interceptors.request.use)
final class AuthInterceptor: RequestInterceptor {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest

        if let authToken = UserDefaults.standard.string(forKey: "authToken") {
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }

        completion(.success(request))
    }
}

// MARK: - Cliente compartido (equivalente al `const axios = create(...)`)
enum AF {
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        return Session(
            configuration: configuration,
            interceptor: AuthInterceptor()
        )
    }()

    static let baseURL = Bundle.main.infoDictionary?["API_BASE_URL"] as? String ?? "http://localhost:2608"
}
