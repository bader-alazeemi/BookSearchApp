import Foundation

struct Book: Codable, Identifiable {
    let id: String
    let title: String
    let authors: [String]?
    let publisher: String?
    let coverID: Int?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "key"
        case title
        case authors = "author_name"
        case publisher
        case coverID = "cover_i"
        case description
    }
    
    var coverImageURL: URL? {
        guard let coverID = coverID else { return nil }
        return URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg")
    }
}

struct BookResponse: Codable {
    let docs: