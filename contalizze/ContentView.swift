import SwiftUI

enum Tabs: String {
    case expenses
    case categories
    case establishments
    case relations
}

struct ContentView: View {
    @ObservedObject private var categoryListVM = CategoryListViewModel()
    @ObservedObject private var establishmentListVM = EstablishmentListViewModel()
    @ObservedObject private var establishmentCategoryListVM = EstablishmentCategoryListViewModel()
    @State private var isCreatingCategory = false
    @State private var isCreatingEstablishment = false
    @State private var isCreatingEstablishmentCategory = false
    @State private var isCreatingDashboard = false
    @State private var selectedTab: Tabs = .expenses
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                ExpenseView()
                    .tabItem {
                        Image(systemName: "chart.pie")
                        Text("Expenses")
                    }
                    .tag(Tabs.expenses)

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
                
                EstablishmentCategoryListView(establishmentCategoryListVM: establishmentCategoryListVM)
                    .tabItem {
                        Image(systemName: "slider.horizontal.3")
                        Text("Relations")
                    }
                    .tag(Tabs.relations)
                
                
            }
            .navigationBarTitle(selectedTab.rawValue.capitalized)
            .navigationBarItems(trailing:
                                    Button(action: {
                switch selectedTab {
                    case .expenses:
                        self.isCreatingDashboard = true
                    case .categories:
                        self.isCreatingCategory = true
                    case .establishments:
                        self.isCreatingEstablishment = true
                    case .relations:
                        self.isCreatingEstablishmentCategory = true
                    
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
            .sheet(isPresented: $isCreatingEstablishmentCategory, onDismiss: {
                establishmentCategoryListVM.fetchEstablishmentsCategory()
            }) {
                CreateEstablishmentCategoryView(
                    categoryListVM: CategoryListViewModel(),
                    establishmentListVM: EstablishmentListViewModel()
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
