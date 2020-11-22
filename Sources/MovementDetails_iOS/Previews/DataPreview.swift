//
//  DataPreview.swift
//
//
//  Created by Bastián Véliz Vega on 26-09-20.
//

import AccountsUI
import DataManagement
import Foundation
import MovementListCommon
import SwiftUI

enum DataPreview {
    // MARK: - Simple card model previews

    static var simpleCardModelArray: [MovementSimpleCardModel] {
        var array = [MovementSimpleCardModel]()

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

    static func getSimpleCardModel(name: String, color: Color, amount: String) -> MovementSimpleCardModel {
        return MovementSimpleCardModel(id: UUID(),
                                         name: name,
                                         amount: amount,
                                         systemImageName: "creditcard.fill",
                                         imageTintColor: color)
    }

    // MARK: - Movement previews

    static var movements: [Movement] {
        let date1 = Date()

        let calendar = Calendar.current
        let date2 = calendar.date(byAdding: .day, value: -2, to: date1) ?? Date()

        let movement1 = PreviewMovement(id: self.storeCategory.id,
                                        name: "movement 1",
                                        description: "This is a movement",
                                        amount: 100,
                                        date: date1,
                                        isPermanent: true)
        let movement2 = PreviewMovement(id: self.storeCategory.id,
                                        name: "movement 2",
                                        description: "This is a movement",
                                        amount: 200,
                                        date: date1)
        let movement3 = PreviewMovement(id: self.storeCategory.id,
                                        name: "movement 3",
                                        description: "This is a movement",
                                        amount: 300,
                                        date: date1,
                                        isPermanent: true)
        let movement4 = PreviewMovement(id: self.storeCategory.id,
                                        name: "movement 4",
                                        description: "This is a movement",
                                        amount: 400,
                                        date: date2)
        let movement5 = PreviewMovement(id: self.storeCategory.id,
                                        name: "movement 5",
                                        description: "This is a movement",
                                        amount: 500,
                                        date: date2,
                                        isPermanent: true)
        let movement6 = PreviewMovement(id: self.storeCategory.id,
                                        name: "movement 6",
                                        description: "This is a movement",
                                        amount: 600,
                                        date: date2)

        let movements = [movement1,
                         movement2,
                         movement3,
                         movement4,
                         movement5,
                         movement6]

        return movements
    }

    static var movementDetailsModel: MovementDetailsModel {
        return MovementDetailsMapper.getModel(from: self.movements,
                                              icon: "creditcard.fill",
                                              tintColor: .indigo)
    }

    static var movementDetailsViewModel: MovementDetailsViewModel {
        return MovementDetailsViewModel(dataModel: self.dataModel)
    }

    private struct PreviewMovement: Movement {
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

    static var storeCategory: CategoryStoreModel = {
        CategoryStoreModel(name: "Store 1", id: UUID(), color: .indigo, icon: "creditcard.fill")
    }()

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

    static var dataModel: MovementDetailsDataModel {
        let movementPreview = MovementPreview()
        let date1 = Date()

        let calendar = Calendar.current
        let date2 = calendar.date(byAdding: .day, value: -2, to: date1) ?? Date()

        return MovementDetailsDataModel(categoryStoreData: self.storeCategory,
                                        isIncome: false,
                                        dataSourceRead: movementPreview,
                                        fromDate: date2,
                                        toDate: date1)
    }
}
