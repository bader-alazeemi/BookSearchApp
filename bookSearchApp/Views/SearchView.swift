import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchQuery = ""
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search for books...", text: $searchQuery)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onSubmit {
                        viewModel.searchBooks(query: searchQuery)
                    }
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List(viewModel.books) { book in
                        BookRow(book: book, favoritesVM: FavoritesViewModel(context: context))
                    }
                }
            }
            .navigationTitle("Book Search")
        }
    }
}