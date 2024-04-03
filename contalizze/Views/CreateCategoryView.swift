import SwiftUI

struct ToastView<Presenting>: View where Presenting: View {
    var presenting: () -> Presenting
    @Binding var isPresented: Bool
    let text: String

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                self.presenting()
                if self.isPresented {
                    VStack {
                        Text(self.text)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                            .transition(.move(edge: .top))
                            .animation(.default)
                    }
                    .padding(.horizontal, 30)
                    .frame(width: geometry.size.width)
                    .offset(y: self.isPresented ? 0 : -geometry.size.height)
                    .animation(.easeInOut(duration: 0.3))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.isPresented = false
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CreateCategoryView: View {
    @State private var categoryName = ""
    @State private var showToast = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Nome da Categoria", text: $categoryName)
            }
            .navigationTitle("Criar Categoria")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Api().createCategory(categoryName: categoryName) { success in
                            if success {
                                self.showToast = true
                            }
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .background(
                ToastView(presenting: { EmptyView() }, isPresented: $showToast, text: "Categoria criada com sucesso")
            )
        }
    }
}

struct CreateCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategoryView()
    }
}
