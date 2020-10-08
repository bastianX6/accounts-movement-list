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
    let dataSourceRead: DataSourceRead
    let dataSourceModify: DataSourceModify
    let fromDate: Date
    let toDate: Date

    /// Default initializer
    /// - Parameters:
    ///   - categoryStoreData: category / store information
    ///   - isIncome: used to check is managed data is for incomes or expenses
    ///   - dataSourceRead: `DataSourceRead` instance used to get movements for the given category / store
    ///   - dataSourceModify: `DataSourceModify` instance used to edit / delete a single movement
    ///   - fromDate: starting date to query movements
    ///   - toDate: ending date to query movements
    public init(categoryStoreData: CategoryStoreModel,
                isIncome: Bool,
                dataSourceRead: DataSourceRead,
                dataSourceModify: DataSourceModify,
                fromDate: Date,
                toDate: Date) {
        self.categoryStoreData = categoryStoreData
        self.isIncome = isIncome
        self.dataSourceRead = dataSourceRead
        self.dataSourceModify = dataSourceModify
        self.fromDate = fromDate
        self.toDate = toDate
    }
}
