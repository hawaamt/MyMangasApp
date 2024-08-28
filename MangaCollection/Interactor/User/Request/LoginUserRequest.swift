//
//  LoginUserRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 27/8/24.
//

import Foundation

struct LoginUserRequest: APIRequest {

    typealias Response = String
    
    let model: UserModel
    
    var method: HTTPMethodType {
        .post
    }
    
    var path: String {
        "/users/login"
    }
    
    var body: [String : Any] {
        [:]
    }
    
    var queryParameters: [String : Any] {
        [:]
    }
}
