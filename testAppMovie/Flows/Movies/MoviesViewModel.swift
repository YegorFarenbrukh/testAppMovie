//
//  MoviesViewModel.swift
//  testAppMovie
//
//  Created by apple on 2/5/21.
//

import Foundation
import Alamofire

fileprivate enum Constants {
    static let apiKey = "993da9372678f88552da6ee78e942f0f"
    static let url = "https://api.themoviedb.org/3/authentication/token/new?api_key="
}

final class MoviesViewModel: ObservableObject {
    
    @Published var moviesModel = MoviesModel.defaultPlaceholder
    @Published var results = [Results]()
    
    
    init() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=993da9372678f88552da6ee78e942f0f") else { return }
        URLSession.shared.dataTask(with: url) { ( data, resp, err ) in
            guard let data = data else {  return }
            do {
                let movies = try JSONDecoder().decode(MoviesModel.self, from: data)
                self.results = movies.results
                debugPrint(movies.results)
            } catch {
                print(err?.localizedDescription as Any)
                
            }
        }.resume()
        
    }
}

private extension MoviesViewModel {
    func requestToken(URLString: String) {
        guard let url = URL(string: URLString) else {
            print("Request func: URL has value \(URLString)")
            return
        }
        AF.request(url)
            .responseDecodable() { (response: DataResponse<MoviesModel,AFError>) in
                switch response.result {
                case .success(let data):
                    self.moviesModel = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

