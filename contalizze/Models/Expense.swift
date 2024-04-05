//
//  Expense.swift
//  contalizze
//
//  Created by Mateus Henrique on 05/04/24.
//

import Foundation

struct UnmappedExpense: Codable {
    let Data: String
    let Estabelecimento: String
    let Portador: String
    let Valor: String
    let Parcela: String
}

struct Expense: Codable {
    let expenses: [String: Double]
    let expensesNotMapped: [UnmappedExpense]
    let expensesNotMappedValue: Double
}
