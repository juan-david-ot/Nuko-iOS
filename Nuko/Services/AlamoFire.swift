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

        if let authToken = KeychainStorage.getToken() {
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        request.setValue("ios", forHTTPHeaderField: "X-Client-Platform")

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

    static let baseURL = Bundle.main.infoDictionary?["API_BASE_URL"] as? String ?? "https://api.nukoapp.com"
}

func decode<T: Decodable>(_ type: T.Type, from request: DataRequest, decoder: JSONDecoder = JSONDecoder.nukoDecoder) async throws -> T {
    let response = await request.serializingDecodable(T.self, decoder: decoder).response

    switch response.result {
    case .success(let value):
        return value
    case .failure:
        if let data = response.data,
           let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
            throw AppError.api(apiError.error)
        }
        throw AppError.unknown
    }
}
