import SwiftUI

struct CreateEstablishmentCategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedEstablishment: EstablishmentViewModel?
    @State private var selectedCategory: CategoryViewModel?
    @State private var isLoading = false
    
    @ObservedObject var categoryListVM: CategoryListViewModel
    @ObservedObject var establishmentListVM: EstablishmentListViewModel

    var body: some View {
        NavigationView {
            Form {
                Picker("Establishment", selection: $selectedEstablishment) {
                    ForEach(establishmentListVM.establishments, id: \.id) { establishment in
                        Text(establishment.name).tag(establishment as EstablishmentViewModel?)
                    }
                }.pickerStyle(.navigationLink)

                Picker("Category", selection: $selectedCategory) {
                    ForEach(categoryListVM.categories, id: \.id) { category in
                        Text(category.name).tag(category as CategoryViewModel?)
                    }
                }.pickerStyle(.navigationLink)
            }
            .navigationTitle("New Relation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Button(action: {
                            isLoading = true
                            if let categoryId = selectedCategory?.id, let establishmentId = selectedEstablishment?.id {
                                Api().createEstablishmentCategory(categoryId: categoryId, establishmentId: establishmentId) { _ in
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }) {
                            Image(systemName: "plus")
                        }
                        .disabled(selectedEstablishment == nil || selectedCategory == nil)
                    }
                }
            }

        }
        .onAppear {
            categoryListVM.fetchCategories()
            establishmentListVM.fetchEstablishments()
        }
    }
}

struct CreateEstablishmentCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEstablishmentCategoryView(
            categoryListVM: CategoryListViewModel(),
            establishmentListVM: EstablishmentListViewModel()
        )
    }
}
