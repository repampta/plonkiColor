//
//  RatingService.swift
//  plonkiColor
//
//  Created by apple on 19.06.2024.
//

import Foundation

enum RatingServiceError: Error {
    case unkonwn
    case noData
}

class RatingService {

    static let shared = RatingService()
    private init() {}
    
    private let urlString = "https://ball-color.br-soft.online/api/leaderboard"

    func fetchData(successCompletion: @escaping([User]) -> Void, errorCompletion: @escaping (Error) -> Void) {

        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
     
        
        guard let token = AuthTokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    errorCompletion(RatingServiceError.noData)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorCompletion(RatingServiceError.unkonwn)
                }
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
            
            do {
                let decoder = JSONDecoder()
                let ratingModel = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    successCompletion(ratingModel)
                    print("\(ratingModel)")
                }
            }catch {
                print("error - ", error)
                
                DispatchQueue.main.async {
                    errorCompletion(error)
                }
            }
        }
        task.resume()
    }
}
