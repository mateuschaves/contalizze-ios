import SwiftUI

struct EstablishmentCategoryListView: View {
    @ObservedObject var establishmentCategoryListVM: EstablishmentCategoryListViewModel
    @State private var isRefreshing = false

    init(establishmentCategoryListVM: EstablishmentCategoryListViewModel) {
        self.establishmentCategoryListVM = establishmentCategoryListVM
    }

    var body: some View {
        List {
            ForEach(establishmentCategoryListVM.establishmentsCategories, id: \.id) { establishmentCategory in
                HStack {
                    Image(systemName: "storefront")
                    Text("\(establishmentCategory.establishmentCategory.establishment.name) <> \(establishmentCategory.establishmentCategory.category.name)")
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
                        deleteEstablishmentCategory(establishmentCategory: establishmentCategory)
                    }) {
                        Text("Delete")
                        Image(systemName: "trash")
                    }
                }
            }
            .onDelete(perform: deleteEstablishments)
        }
        .navigationTitle("Establishments")
        .onAppear {
            establishmentCategoryListVM.fetchEstablishmentsCategory()
        }
        .refreshable {
            establishmentCategoryListVM.fetchEstablishmentsCategory()
        }
    }

    private func deleteEstablishmentCategory(establishmentCategory: EstablishmentCategoryViewModel) {
        if let index = establishmentCategoryListVM.establishmentsCategories.firstIndex(where: { $0.id == establishmentCategory.id }) {
            Api().deleteEstablishmentCategory(establishmentCategoryID: establishmentCategory.id) { success in
                if success {
                    establishmentCategoryListVM.establishmentsCategories.remove(at: index)
                }
            }
        }
    }

    private func deleteEstablishments(at offsets: IndexSet) {
        for index in offsets {
            let establishmentCategory = establishmentCategoryListVM.establishmentsCategories[index]
            Api().deleteEstablishmentCategory(establishmentCategoryID: establishmentCategory.id) { success in
                if success {
                    establishmentCategoryListVM.establishmentsCategories.remove(at: index)
                }
            }
        }
    }
}
