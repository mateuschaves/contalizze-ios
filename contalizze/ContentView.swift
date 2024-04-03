import SwiftUI

enum Tabs: String {
    case categories
    case establishments
}

struct ContentView: View {
    @ObservedObject private var categoryListVM = CategoryListViewModel()
    @ObservedObject private var establishmentListVM = EstablishmentListViewModel()
    @State private var isCreatingCategory = false
    @State private var isCreatingEstablishment = false
    @State private var selectedTab: Tabs = .categories
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                CategoryListView(categoryListVM: categoryListVM)
                    .tabItem {
                        Image(systemName: "tag")
                        Text("Categories")
                    }
                    .tag(Tabs.categories)
                
                EstablishmentListView(establishmentListVM: establishmentListVM)
                    .tabItem {
                        Image(systemName: "storefront")
                        Text("Establishments")
                    }
                    .tag(Tabs.establishments)
            }
            .navigationBarTitle(selectedTab.rawValue.capitalized)
            .navigationBarItems(trailing:
                Button(action: {
                    switch selectedTab {
                        case .categories:
                            self.isCreatingCategory = true
                        case .establishments:
                            self.isCreatingEstablishment = true
                    }
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isCreatingCategory, onDismiss: {
                categoryListVM.fetchCategories()
            }) {
                CreateCategoryView()
            }
            .sheet(isPresented: $isCreatingEstablishment, onDismiss: {
                establishmentListVM.fetchEstablishments()
            }) {
                CreateEstablishmentView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
