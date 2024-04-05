import Foundation


struct Establishment: Decodable, Hashable, Equatable {
    let id: Int
    let name: String
    let createdAt: String
    let updatedAt: String
    let categoryEstablishment: [CategoryOfEstablishment]?
    
    static func == (lhs: Establishment, rhs: Establishment) -> Bool {
        return lhs.id == rhs.id &&
                       lhs.name == rhs.name &&
                       lhs.createdAt == rhs.createdAt &&
                       lhs.updatedAt == rhs.updatedAt &&
                       lhs.categoryEstablishment == rhs.categoryEstablishment
    }
}

struct CategoryOfEstablishment: Decodable, Hashable {
    let id: Int
    let categoryId: Int
    let establishmentId: Int
    let createdAt: String
    let updatedAt: String
}
