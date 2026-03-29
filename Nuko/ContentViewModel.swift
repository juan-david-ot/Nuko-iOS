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
}
