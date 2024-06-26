import Foundation

struct EstablishmentCategory: Decodable, Hashable {
    let id: Int
    let categoryId: Int
    let establishmentId: Int
    let establishment: Establishment
    let category: Category
    let createdAt: String
    let updatedAt: String
}
