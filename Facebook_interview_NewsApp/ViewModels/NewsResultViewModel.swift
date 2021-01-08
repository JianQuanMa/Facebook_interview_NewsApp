//
//  NewsResultViewModel.swift
//  Facebook_interview_NewsApp
//
//  Created by Jian Ma on 1/7/21.
//

import Foundation

protocol NewsResultViewModelDelegate: AnyObject{
    func update()
}

class NewsResultViewModel{
    weak var newsResultViewModelDelegate: NewsResultViewModelDelegate?
    var decoder = JSONDecoder()
    var newsResult = NewsResult(status: "", totalResults: 0, articles: []){
        didSet{
        //    NewsResult.init(status: "", totalResults: "", articles: [])
            newsResultViewModelDelegate?.update()
        }
    }
}
