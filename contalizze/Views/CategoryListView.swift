import SwiftUI

struct CategoryListView: View {
    @ObservedObject var categoryListVM: CategoryListViewModel
    @State private var isRefreshing = false


    init(categoryListVM: CategoryListViewModel) {
        self.categoryListVM = categoryListVM
    }

    var body: some View {
        List {
            ForEach(categoryListVM.categories, id: \.id) { category in
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
        .onAppear {
            categoryListVM.fetchCategories()
        }
        .refreshable {
            categoryListVM.fetchCategories()
        }
    }

    private func deleteCategory(category: CategoryViewModel) {
        if let index = categoryListVM.categories.firstIndex(where: { $0.id == category.id }) {
            Api().deleteCategory(categoryID: category.id) { success in
                if success {
                    categoryListVM.categories.remove(at: index)
                }
            }
        }
    }

    private func deleteCategories(at offsets: IndexSet) {
        for index in offsets {
            let category = categoryListVM.categories[index]
            Api().deleteCategory(categoryID: category.id) { success in
                if success {
                    categoryListVM.categories.remove(at: index)
                }
            }
        }
    }
}
