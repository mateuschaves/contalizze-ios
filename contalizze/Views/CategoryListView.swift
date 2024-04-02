import SwiftUI

struct CategoryListView: View {
    let categories: [CategoryViewModel]
    
    init(categories: [CategoryViewModel]) {
        self.categories = categories
    }
    
    var body: some View {
        List {
            ForEach(self.categories, id:\.id)  { category in
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
                }
            }
        }
    }
}

#Preview {
    CategoryListView(
        categories: [CategoryViewModel(
            category:  Category(
                id: 1,
                name: "Alimentação", 
                createdAt: "02/04/2024",
                updatedAt: "02/04/2024"
            )
        )]
    )
}
