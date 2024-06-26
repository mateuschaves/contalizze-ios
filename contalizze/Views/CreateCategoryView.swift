import SwiftUI

struct CreateCategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var categoryName = ""
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Category name", text: $categoryName)
            }
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Button(action: {
                            isLoading = true
                            Api().createCategory(categoryName: categoryName) { _ in
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Image(systemName: "plus")
                        }
                        .disabled(categoryName.isEmpty)
                    }
                }
            }
        }
    }
}

struct CreateCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategoryView()
    }
}
