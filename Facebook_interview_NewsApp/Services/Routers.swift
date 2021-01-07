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
