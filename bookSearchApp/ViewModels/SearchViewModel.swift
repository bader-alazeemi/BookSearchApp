import Foundation

class SearchViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func searchBooks(query: String) {
        guard !query.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        APIService.shared.fetchBooks(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let books):
                    self?.books = books
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}