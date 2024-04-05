import Foundation

class EstablishmentListViewModel: ObservableObject {
    @Published var establishments = [EstablishmentViewModel]()
    
    init() {
        fetchEstablishments()
    }
    
    func fetchEstablishments() {
        Api().getAllEstablishments { establishments in
            if let establishments = establishments {
                print(establishments)
                self.establishments = establishments.map(EstablishmentViewModel.init)
            }
        }
    }
}

class EstablishmentViewModel: Identifiable, Hashable {
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(establishment.id)
    }
    
    static func == (lhs: EstablishmentViewModel, rhs: EstablishmentViewModel) -> Bool {
        return lhs.establishment.id == rhs.establishment.id
    }
}
