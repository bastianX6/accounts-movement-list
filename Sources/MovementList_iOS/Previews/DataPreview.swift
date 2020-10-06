//
//  DataPreview.swift
//
//
//  Created by Bastián Véliz Vega on 26-09-20.
//

import AccountsUI
import DataManagement
import Foundation
import SwiftUI

enum DataPreview {
    // MARK: - Simple card model previews

    static var simpleCardModelArray: [ExpeditureSimpleCardModel] {
        var array = [ExpeditureSimpleCardModel]()

        array.append(self.getSimpleCardModel(name: "Falabella",
                                             color: .green,
                                             amount: "$ 9.999.999"))

        array.append(self.getSimpleCardModel(name: "Santander",
                                             color: .red,
                                             amount: "$ 9.999.999"))

        array.append(self.getSimpleCardModel(name: "Banco de Chile",
                                             color: .blue,
                                             amount: "$ 9.999.999"))

        array.append(self.getSimpleCardModel(name: "Otros",
                                             color: .indigo,
                                             amount: "$ 9.999.999"))

        return array
    }

    static func getSimpleCardModel(name: String, color: Color, amount: String) -> ExpeditureSimpleCardModel {
        return ExpeditureSimpleCardModel(id: UUID(),
                                         name: name,
                                         amount: amount,
                                         systemImageName: "creditcard.fill",
                                         imageTintColor: color)
    }

    static var summaryListDataModel: SummaryListView.DataModel {
        return SummaryListView.DataModel(month: "Mayo",
                                         year: "2019",
                                         elements: self.simpleCardModelArray)
    }

    // MARK: - MovementSum Previews

    private struct PreviewMovementSum: MovementsSum {
        var id: UUID
        var sum: Float
    }

    static var movementSumArray: [MovementsSum] {
        var array = [MovementsSum]()

        array.append(PreviewMovementSum(id: self.stores[0].id, sum: 9_999_999))
        array.append(PreviewMovementSum(id: self.stores[1].id, sum: 1_111_111))
        array.append(PreviewMovementSum(id: self.stores[2].id, sum: 6_666_666))

        return array
    }

    // MARK: - Stores

    static var stores: [CategoryStoreModel] = {
        var array = [CategoryStoreModel]()
        array.append(CategoryStoreModel(name: "Store 1", id: UUID(), color: .indigo, icon: "creditcard.fill"))
        array.append(CategoryStoreModel(name: "Store 2", id: UUID(), color: .indigo, icon: "creditcard.fill"))
        array.append(CategoryStoreModel(name: "Store 3", id: UUID(), color: .indigo, icon: "creditcard.fill"))
        return array
    }()

    // MARK: - Resources

    static var movementResources: MovementResources {
        return MovementResources(categories: [], stores: self.stores)
    }
}
