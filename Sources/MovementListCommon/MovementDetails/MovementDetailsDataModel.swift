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
    public let categoryStoreData: CategoryStoreModel
    public let isIncome: Bool
    public let dataSourceRead: DataSourceRead
    public let fromDate: Date
    public let toDate: Date

    /// Default initializer
    /// - Parameters:
    ///   - categoryStoreData: category / store information
    ///   - isIncome: used to check is managed data is for incomes or expenses
    ///   - dataSourceRead: `DataSourceRead` instance used to get movements for the given category / store
    ///   - fromDate: starting date to query movements
    ///   - toDate: ending date to query movements
    public init(categoryStoreData: CategoryStoreModel,
                isIncome: Bool,
                dataSourceRead: DataSourceRead,
                fromDate: Date,
                toDate: Date)
    {
        self.categoryStoreData = categoryStoreData
        self.isIncome = isIncome
        self.dataSourceRead = dataSourceRead
        self.fromDate = fromDate
        self.toDate = toDate
    }
}
