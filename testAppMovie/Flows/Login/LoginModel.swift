//
//  LoginModel.swift
//  testAppMovie
//
//  Created by apple on 2/5/21.
//

import Foundation
import KeychainSwift

struct LoginModel: Decodable {
    
    var success: Bool
}

struct RequestToken: Decodable {
    var request_token: String
}
