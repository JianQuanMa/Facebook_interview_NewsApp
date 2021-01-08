//
//  Routers.swift
//  Facebook_interview_NewsApp
//
//  Created by Jian Ma on 1/7/21.
//

import Foundation

struct Router{
    func getEverything(with keyword: String) -> URL?{
        guard let url = URL(string: "\(Constants.baseURLString)?q=\(keyword)&apiKey=\(Constants.apiKeyString)") else{return nil}
        return url
    }
}

enum Constants {
    static let apiKeyString = "255fb6a0c8e44a2f9ecd4d008e1db384"
    static let baseURLString = "https://newsapi.org/v2/everything"
}
