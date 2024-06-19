import Foundation

enum PostRequestServiceError: Error {
    case unkonwn
    case noData
}

class PostRequestService {
    
    static let shared = PostRequestService()
    private init() {}
    
    private let baseUrl = "https://scarab-catcher-backend-67c201d7d34c.herokuapp.com"
    
    func updateData(id: Int, payload: UpdatePayload, completion: @escaping (Result<CreateResponse, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + "/api/players/\(id)") else {
            completion(.failure(PostRequestServiceError.unkonwn))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        let json = try? JSONEncoder().encode(payload)
        request.httpBody = json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = AuthTokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } else {
                do {
                    guard let data else { return }
                    let model = try JSONDecoder().decode(CreateResponse.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func createPlayer(payload: CreateRequestPayload, successCompletion: @escaping(CreateResponse) -> Void, errorCompletion: @escaping (Error) -> Void) {
        
        guard let url = URL(string: baseUrl + "/api/players/") else {
            print("Неверный URL")
            DispatchQueue.main.async {
                errorCompletion(PostRequestServiceError.unkonwn)
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = payload.makeBody()
        request.httpBody = postString.data(using: .utf8)
        
        guard let token = AuthTokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorCompletion(PostRequestServiceError.noData)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorCompletion(PostRequestServiceError.unkonwn)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let playerOne = try decoder.decode(CreateResponse.self, from: data)
                DispatchQueue.main.async {
                    successCompletion(playerOne)
                    print("successCompletion-\(playerOne)")
                }
            }catch {
                print("error", error)
                
                DispatchQueue.main.async {
                    errorCompletion(error)
                }
            }
        }
        task.resume()
    }
    
    
    
    
    
    func createPlayerUser(_ name: String) async throws -> PlayerNetworkModel {
        
        guard let token = AuthTokenService.shared.token else { return .defaultInstance }
        
        let urlString = "https://ball-color.br-soft.online/api/user"
        guard let url = URL(string: urlString) else { return .defaultInstance }
        var request = URLRequest(url: url)
        
        //var multipart = MultipartRequest()
        // multipart.add(key: "name", value: name)
        // multipart.add(key: "score", value: "0")
        
        request.httpMethod = "POST"
        
        let body = Body(name: name, username: "", password: "", imageURL: "")
        
        // request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //request.setValue(multipart.httpContentTypeHeadeValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8))
        let decoder = JSONDecoder()
        return try decoder.decode(PlayerNetworkModel.self, from: data)
    }
    
    struct Body: Codable {
        let name: String
        let username: String
        let password: String
        let imageURL: String
    }
    
    struct PlayerNetworkModel: Decodable, Identifiable {
        var id: Int
        var name: String?
        var score: Int
        
        var unwrappedName: String {
            name ?? ""
        }
        
        static var defaultInstance: PlayerNetworkModel {
            .init(id: -1, name: "", score: 0)
        }
    }
}
