import SwiftUI

struct ExpenseView: View {
    let expenses: [String: Double] = [
        "Transporte": 850.24,
        "Casa": 160,
        "Assinaturas": 312.94,
        "Imposto": 0,
        "Alimentação": 2762.99,
        "Saúde": 504.73,
        "Roupa": 379.8,
        "Viagem": 162,
        "Entretenimento": 360,
        "Bar & Restaurante": 423.5,
        "Compras": 533.33,
        "Cuidados pessoais": 60
    ]
    
    var sortedExpenses: [(String, Double)] {
        return expenses.sorted(by: { $0.value > $1.value })
    }
    
    @State private var showAllExpenses = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(showAllExpenses ? sortedExpenses : Array(sortedExpenses.prefix(5)), id: \.0) { expense in
                    NavigationLink(destination: Text("Detail view for \(expense.0)")) {
                        HStack {
                            Text(expense.0)
                            Spacer()
                            Text("R$ \(String(format: "%.2f", expense.1))")
                                .frame(width: 90, alignment: .leading)
                        }
                    }
                }
                
                if showAllExpenses && sortedExpenses.count > 5 {
                    Button(action: {
                        withAnimation {
                            showAllExpenses = false
                        }
                    }) {
                        Text("Show less")
                    }
                    .foregroundColor(.blue)
                } else if !showAllExpenses && sortedExpenses.count > 5 {
                    Button(action: {
                        withAnimation {
                            showAllExpenses = true
                        }
                    }) {
                        Text("Show all expenses")
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Expenses")
        }
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView()
    }
}
