import Foundation

class CategoryListViewModel: ObservableObject {
    @Published var categories = [CategoryViewModel]()
    
    init() {
        fetchCategories()
    }
    
    func fetchCategories() {
        Api().getAllCategories { categories in
            if let categories = categories {
                self.categories = categories.map(CategoryViewModel.init)
            }
        }
    }
}

class CategoryViewModel {
    let id = UUID()

    var category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    var name: String {
        return self.category.name.capitalized
    }
}
