//
//  UserRenewTokenRequest.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 27/8/24.
//

import Foundation

struct UserRenewTokenRequest: APIRequest {

    typealias Response = String
        
    var method: HTTPMethodType {
        .post
    }
    
    var path: String {
        "/users/renew"
    }
    
    var body: [String : Any] {
        [:]
    }
    
    var queryParameters: [String : Any] {
        [:]
    }
}
