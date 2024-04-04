//
//  Establishment.swift
//  contalizze
//
//  Created by Mateus Henrique on 02/04/24.
//

import Foundation


struct Establishment: Decodable, Hashable {
    let id: Int
    let name: String
    let createdAt: String
    let updatedAt: String
}
