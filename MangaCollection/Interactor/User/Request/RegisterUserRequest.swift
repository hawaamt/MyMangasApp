//
//  RegisterUserRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 27/8/24.
//

import Foundation

struct RegisterUserRequest: APIRequest {

    typealias Response = String
    
    let model: UserModel
    
    var method: HTTPMethodType {
        .post
    }
    
    var path: String {
        "/users"
    }
    
    var body: [String : Any] {
        model.dictionary
    }
    
    var queryParameters: [String : Any] {
        [:]
    }
}
