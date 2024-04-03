import Foundation

class EstablishmentListViewModel: ObservableObject {
    @Published var establishments = [EstablishmentViewModel]()
    
    init() {
        fetchEstablishments()
    }
    
    func fetchEstablishments() {
        Api().getAllEstablishments { establishments in
            if let establishments = establishments {
                self.establishments = establishments.map(EstablishmentViewModel.init)
            }
        }
    }
}

class EstablishmentViewModel {
    var establishment: Establishment
    
    init(establishment: Establishment) {
        self.establishment = establishment
    }
    
    var name: String {
        return self.establishment.name.capitalized
    }
    
    var id: Int {
        return self.establishment.id
    }
}
