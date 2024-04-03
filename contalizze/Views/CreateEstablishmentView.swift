import SwiftUI

struct CreateEstablishmentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var establishmentName = ""
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Establishment name", text: $establishmentName)
            }
            .navigationTitle("New Establishment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Button(action: {
                            isLoading = true
                            Api().createEstablishment(establishmentName: establishmentName) { _ in
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Image(systemName: "plus")
                        }
                        .disabled(establishmentName.isEmpty)
                    }
                }
            }
        }
    }
}

struct CreateEstablishmentView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEstablishmentView()
    }
}
