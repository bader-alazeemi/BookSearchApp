import CoreData
import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favoriteBooks: [BookEntity] = []
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchFavorites()
    }
    
    func fetchFavorites() {
        let request = BookEntity.fetchRequest()
        do {
            favoriteBooks = try context.fetch(request)
        } catch {
            print("Error fetching favorites: \(error)")
        }
    }
    
    func addFavorite(book: Book) {
        let entity = BookEntity(context: context)
        entity.id = book.id
        entity.title = book.title
        entity.authors = book.authors?.joined(separator: ", ")
        entity.publisher = book.publisher
        entity.coverID = Int64(book.coverID ?? 0)
        entity.bookDescription = book.description
        
        saveContext()
    }
    
    func removeFavorite(book: BookEntity) {
        context.delete(book)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
            fetchFavorites()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}