//
//  NetworkService.swift
//  Facebook_interview_NewsApp
//
//  Created by Jian Ma on 1/7/21.
//

import Foundation

final class NetworkService{
    static let shared = NetService()
    private init(){}
    
    func getEverything(with keyword: String, completion: @escaping (NewsResult) -> Void){
        guard let url = Router.init().getEverything(with: keyword) else {return}
        URLSession.shared.dataTask(with: url){ data, response,error in
            if let error = error{
                print(error.localizedDescription)
            }
            //           else if let response = response{
            //                guard let httpResponse = response as? HTTPURLResponse else{return}
            //                switch httpResponse.statusCode{
            //                    case
            //                }
            //           }
            if let data = data{
                do{
                    let result = try JSONDecoder().decode(NewsResult.self, from: data)
                    completion(result)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
