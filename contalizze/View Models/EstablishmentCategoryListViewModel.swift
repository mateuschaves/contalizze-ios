//
//  EstablishmentCategoryListViewModel.swift
//  contalizze
//
//  Created by Mateus Henrique on 03/04/24.
//

import Foundation

class EstablishmentCategoryListViewModel: ObservableObject {
    @Published var establishmentsCategories = [EstablishmentCategoryViewModel]()
    
    init() {
        fetchEstablishmentsCategory()
    }
    
    func fetchEstablishmentsCategory() {
        Api().getAllEstablishmentsCategory { establishmentCategories  in
            if let establishmentCategories = establishmentCategories {
                print(establishmentCategories)
                self.establishmentsCategories = establishmentCategories.map(EstablishmentCategoryViewModel.init)
            }
        }
    }
}

class EstablishmentCategoryViewModel {
    var establishmentCategory: EstablishmentCategory
    
    init(establishmentCategory: EstablishmentCategory) {
        self.establishmentCategory = establishmentCategory
    }
    
    
    var categoryId: Int {
        return self.establishmentCategory.categoryId
    }
    
    var establishmentId: Int {
        return self.establishmentCategory.establishmentId
    }
    
    var id: Int {
        return self.establishmentCategory.id
    }
}
