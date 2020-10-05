import Foundation
import Combine

public enum YoutubeLive {
    static let baseURL: URL = URL(string: "https://www.googleapis.com/youtube/v3")!
    
    public struct Client {
        let accessToken: String
        
        public init(accessToken: String) {
            self.accessToken = accessToken
        }
        
        func get<T: Codable>(path: String, queryItems: [URLQueryItem] = []) -> AnyPublisher<T, Error> {
            let endpoint = YoutubeLive.baseURL.appendingPathComponent(path)
            var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = queryItems
            var request = URLRequest(url: urlComponents.url!)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            let session = URLSession(configuration: .default)
            return session.dataTaskPublisher(for: request).tryMap { (data, response) -> T in
                print(String(data: data, encoding: .utf8), response)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    return try decoder.decode(T.self, from: data)
                } catch let (error) {
                    if let clientError = try? decoder.decode(YoutubeLiveError.self, from: data) {
                        throw clientError
                    } else {
                        throw error
                    }
                }
            }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
        }
    }
}
