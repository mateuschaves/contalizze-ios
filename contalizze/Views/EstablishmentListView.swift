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
            .onDelete(perform: deleteEstablishments)
        }
        .navigationTitle("Establishments")
        .onAppear {
            establishmentListVM.fetchEstablishments()
        }
        .refreshable {
            establishmentListVM.fetchEstablishments()
        }
    }

    private func deleteEstablishment(establishment: EstablishmentViewModel) {
        if let index = establishmentListVM.establishments.firstIndex(where: { $0.id == establishment.id }) {
            Api().deleteEstablishment(establishmentID: establishment.id) { success in
                if success {
                    establishmentListVM.establishments.remove(at: index)
                }
            }
        }
    }

    private func deleteEstablishments(at offsets: IndexSet) {
        for index in offsets {
            let establishment = establishmentListVM.establishments[index]
            Api().deleteEstablishment(establishmentID: establishment.id) { success in
                if success {
                    establishmentListVM.establishments.remove(at: index)
                }
            }
        }
    }
}
