import Foundation

class CategoryListViewModel: ObservableObject {
    @Published var categories = [CategoryViewModel]()
    
    init() {
        fetchCategories()
    }
    
    func fetchCategories() {
        Api().getAllCategories { categories in
            if let categories = categories {
                print(categories)
                self.categories = categories.map(CategoryViewModel.init)
            }
        }
    }
}

class CategoryViewModel: Identifiable, Hashable {
    var category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    var name: String {
        return self.category.name.capitalized
    }
    
    var id: Int {
        return self.category.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(category.id)
    }
    
    static func == (lhs: CategoryViewModel, rhs: CategoryViewModel) -> Bool {
        return lhs.category.id == rhs.category.id
    }
}
