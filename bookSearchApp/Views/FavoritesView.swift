import SwiftUI
import CoreData

struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel = FavoritesViewModel(context: PersistenceController.shared.container.viewContext)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.favoriteBooks, id: \.id) { book in
                    VStack(alignment: .leading) {
                        Text(book.title ?? "Unknown Title")
                            .font(.headline)
                        Text(book.authors ?? "Unknown Author")
                            .font(.subheadline)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.removeFavorite(book: viewModel.favoriteBooks[index])
                    }
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
        }
    }
}