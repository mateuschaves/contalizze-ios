import SwiftUI

struct ContentView: View {
    @ObservedObject private var categoryListVM = CategoryListViewModel()
    
    var body: some View {
        NavigationView {
            CategoryListView(categories: self.categoryListVM.categories)
                .navigationTitle("Categorias")
        }
    }
}

#Preview {
    ContentView()
}
