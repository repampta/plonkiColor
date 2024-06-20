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
    
    func updateUser(userId: Int, name: String) {
            let url = URL(string: "https://ball-color.br-soft.online/api/user")!
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
        guard let token = AuthTokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
            
            let parameters: [String: Any] = [
                "user_id": userId,
                "name": name,
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print("Response: \(json)")
                    }
                } catch {
                    print("Error parsing response: \(error)")
                }
            }
            
            task.resume()
        }
}
