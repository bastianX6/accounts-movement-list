//
//  MovementDetailsDataModel.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import AccountsUI
import DataManagement
import Foundation
import SwiftUI

/// Struct with all required data to init the module
public struct MovementDetailsDataModel {
    let categoryStoreData: CategoryStoreModel
    let isIncome: Bool
    let dataSource: DataSourceRead
    let fromDate: Date
    let toDate: Date

    /// Default initializer
    /// - Parameters:
    ///   - categoryStoreData: category / store information
    ///   - isIncome: used to check is managed data is for incomes or expenses
    ///   - dataSource: `DataSourceRead` instance used to get movements for the given category / store
    ///   - fromDate: starting date to query movements
    ///   - toDate: ending date to query movements
    public init(categoryStoreData: CategoryStoreModel,
                isIncome: Bool,
                dataSource: DataSourceRead,
                fromDate: Date,
                toDate: Date) {
        self.categoryStoreData = categoryStoreData
        self.isIncome = isIncome
        self.dataSource = dataSource
        self.fromDate = fromDate
        self.toDate = toDate
    }
}
