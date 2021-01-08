//
//  NetworkService.swift
//  Facebook_interview_NewsApp
//
//  Created by Jian Ma on 1/7/21.
//

import Foundation

final class NetworkService{
    static let shared = NetworkService()
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }()
    private init(){}
    
    func getEverything(
        with keyword: SearchKeyword,
        completion: @escaping (Result<NewsResult, Error>) -> Void
    ) {
        guard let url = Router().getEverything(with: keyword.keyword) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                Self.dispatch {
                    completion(.failure(error))
                }
                return
            }
            
            if let data = data {
                do {
                    let result = try self.jsonDecoder.decode(NewsResult.self, from: data)
                    Self.dispatch {
                        completion(.success(result))
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    private static func dispatch(block: @escaping () ->Void) {
        DispatchQueue.main.async(execute: block)
    }
    
}

struct SearchKeyword {
    let keyword: String
    
    static let bitcoin = SearchKeyword(keyword: "bitcoin")
}
