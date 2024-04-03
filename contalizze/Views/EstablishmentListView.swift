import SwiftUI

struct EstablishmentListView: View {
    @ObservedObject var establishmentListVM: EstablishmentListViewModel
    @State private var isRefreshing = false


    init(establishmentListVM: EstablishmentListViewModel) {
        self.establishmentListVM = establishmentListVM
    }

    var body: some View {
        List {
            ForEach(establishmentListVM.establishments, id: \.id) { establishment in
                HStack {
                    Image(systemName: "storefront")
                    Text(establishment.name)
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
                        deleteEstablishment(establishment: establishment)
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
            establishmentListVM.fetchEstablishments()
        }
        .refreshable {
            establishmentListVM.fetchEstablishments()
        }
    }

    private func deleteEstablishment(establishment: EstablishmentViewModel) {
        if let index = establishmentListVM.establishments.firstIndex(where: { $0.id == establishment.id }) {
            
        }
    }

    private func deleteCategories(at offsets: IndexSet) {
        for index in offsets {
            let establishment = establishmentListVM.establishments[index]
            
        }
    }
}
