//
//  SummaryList+DataModel.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import AccountsUI
import Combine
import Foundation

extension SummaryListView {
    class DataModel: ObservableObject {
        let id: UUID
        let month: String
        let year: String
        let elements: [MovementSimpleCardModel]

        init(id: UUID = UUID(),
             month: String = "",
             year: String = "",
             elements: [MovementSimpleCardModel] = []) {
            self.id = id
            self.month = month
            self.year = year
            self.elements = elements
        }
    }
}
