import SwiftUI

struct BookRow: View {
    let book: Book
    @ObservedObject var favoritesVM: FavoritesViewModel
    
    var isFavorite: Bool {
        favoritesVM.favoriteBooks.contains { $0.id == book.id }
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: book.coverImageURL) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 70)
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.authors?.joined(separator: ", ") ?? "Unknown Author")
                    .font(.subheadline)
                Text(book.publisher ?? "Unknown Publisher")
                    .font(.caption)
            }
            
            Spacer()
            
            Button {
                if isFavorite {
                    if let entity = favoritesVM.favoriteBooks.first(where: { $0.id == book.id }) {
                        favoritesVM.removeFavorite(book: entity)
                    }
                } else {
                    favoritesVM.addFavorite(book: book)
                }
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
            }
        }
    }
}