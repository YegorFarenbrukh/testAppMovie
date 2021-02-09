//
//  LoginViewModel.swift
//  testAppMovie
//
//  Created by apple on 2/5/21.
//

import Foundation
import KeychainSwift
import Alamofire

final class LoginViewModel: ObservableObject {
    
    @Published var loginModel = LoginModel(success: false)
    @Published var requestTokenModel = RequestToken(request_token: "")
    
    
    private let apiKey = "993da9372678f88552da6ee78e942f0f"
    private let url = "https://api.themoviedb.org/3/authentication/token/new?api_key="
    
    //@Published var model = LoginModel()
    @Published var userName = KeychainSwift().get("userName") ?? ""
    @Published var password = KeychainSwift().get("password") ?? ""
    
    //completion: (Bool) -> Void
    func signIn(completion: (Bool) -> Void) {
        if userName.count != 0 && userName != KeychainSwift().get("userName") {
            KeychainSwift().set(userName, forKey: "userName")
        }
        
        if password.count != 0 && userName != KeychainSwift().get("password") {
            KeychainSwift().set(password, forKey: "password")
        }
        
        //DispatchGroup().enter()
        if self.requestTokenModel.request_token == "" {
            self.requestToken(URLString: self.url + self.apiKey)
        }
        requestLogin() { success in
            completion(success)
        }
        
        print("sign in method has been ended")
        completion(loginModel.success)
    }
}


private extension LoginViewModel {
    // MARK: - Request
    func requestToken(URLString: String) {
        guard let url = URL(string: URLString) else {
            print("Request func: URL has value \(URLString)")
            return
        }
        AF.request(url)
            .responseDecodable() { (response: DataResponse<RequestToken,AFError>) in
                switch response.result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.requestTokenModel = data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func requestLogin(completion: (Bool) -> Void) {
        
        let loginUrl = "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(apiKey)"
        
        let parameters: [String: String] = [
            "username": userName,
            "password": password,
            "request_token": requestTokenModel.request_token
        ]
        guard URL(string: loginUrl) != nil else {
            print("Request func: URL has value \(loginUrl)")
            return
        }
        AF.request(loginUrl, method: .post, parameters: parameters).responseDecodable() { [self] (response: DataResponse<LoginModel,AFError>) in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.loginModel = data
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Text field symbols limiter
extension LoginViewModel {
    func limitText(_ upper: Int) {
        if userName.count > upper {
            userName = String(userName.prefix(upper))
        }
    }
}
