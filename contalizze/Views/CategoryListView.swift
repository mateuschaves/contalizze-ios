import SwiftUI

struct CategoryListView: View {
    let categories: [CategoryViewModel]
    @Binding var categoriesArray: [CategoryViewModel]

    init(categories: [CategoryViewModel], categoriesArray: Binding<[CategoryViewModel]>) {
        self.categories = categories
        self._categoriesArray = categoriesArray
    }

    var body: some View {
        List {
            ForEach(categoriesArray, id: \.id) { category in
                HStack {
                    Image(systemName: "tag")
                    Text(category.name)
                        .font(.subheadline)
                        .padding(EdgeInsets(
                            top: 8,
                            leading: 0,
                            bottom: 8,
                            trailing: 0
                        ))
                    Spacer()
                }
                .contentShape(Rectangle())
                .contextMenu {
                    Button(action: {
                        deleteCategory(category: category)
                    }) {
                        Text("Delete")
                        Image(systemName: "trash")
                    }
                }
            }
            .onDelete(perform: deleteCategories)
        }
        .navigationTitle("Categories")
    }

    private func deleteCategory(category: CategoryViewModel) {
        if let index = categoriesArray.firstIndex(where: { $0.id == category.id }) {
            Api().deleteCategory(categoryID: category.id) { success in
                if success {
                    categoriesArray.remove(at: index)
                }
            }
        }
    }

    private func deleteCategories(at offsets: IndexSet) {
        for index in offsets {
            let category = categoriesArray[index]
            Api().deleteCategory(categoryID: category.id) { success in
                if success {
                    categoriesArray.remove(at: index)
                }
            }
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let categories: [CategoryViewModel] = [
            CategoryViewModel(category:  Category(
                id: 1,
                name: "Alimentação",
                createdAt: "02/04/2024",
                updatedAt: "02/04/2024"
            ))
        ]
        return CategoryListView(categories: categories, categoriesArray: .constant(categories))
    }
}
