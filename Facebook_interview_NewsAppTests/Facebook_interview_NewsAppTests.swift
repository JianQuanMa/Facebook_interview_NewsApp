//
//  Facebook_interview_NewsAppTests.swift
//  Facebook_interview_NewsAppTests
//
//  Created by Jian Ma on 1/7/21.
//

import XCTest
//@testable import Facebook_interview_NewsApp

class Facebook_interview_NewsAppTests: XCTestCase {

    func test() {
//        print("-=- testing ")
        
        let dateString = "2021-01-02T12:59:00Z"
        
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        
        let temp = formatter.date(from: dateString)
        print("-=- temp \(temp)")
    }

}
