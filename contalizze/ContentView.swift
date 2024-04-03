import SwiftUI

struct ContentView: View {
    @ObservedObject private var categoryListVM = CategoryListViewModel()
    @State private var isCreatingCategory = false
    
    var body: some View {
        NavigationView {
            CategoryListView(categories: self.categoryListVM.categories, categoriesArray: $categoryListVM.categories)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Categories")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.isCreatingCategory = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isCreatingCategory) {
                    CreateCategoryView()
                }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Text("Toolbar Item")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
