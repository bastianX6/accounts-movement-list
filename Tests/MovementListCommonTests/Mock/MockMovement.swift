//
//  MockMovement.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import DataManagement
import Foundation

struct MockMovement: Movement, Equatable {
    var id: UUID = UUID()
    var name: String = ""
    var description: String = ""
    var amount: Float = 0
    var date: Date = Date()
    var isPaid: Bool = false
    var isPermanent: Bool = false
    var storeId: UUID = UUID()
    var categoryId: UUID = UUID()
    var paymentId: UUID?
}
