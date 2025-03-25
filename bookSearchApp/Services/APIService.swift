import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://openlibrary.org/search.json"
    
    func fetchBooks(query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.cannotParseResponse)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(BookResponse.self, from: data)
                completion(.success(result.docs))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}