//
//  ResultModel.swift
//  Facebook_interview_NewsApp
//
//  Created by Jian Ma on 1/7/21.
//

import Foundation

struct Result: Decodable{
    let status: String
    let totalResults: String
    let articles: [Article]
    
}

struct Article: Decodable{
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: URL
    let urlToImage: URL
    let publishedAt: String
    let content: String
}

struct Source: Decodable{
    let id: String?
    let name: String
}
