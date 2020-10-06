//
//  MovementDetailsDataModel.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import DataManagement
import Foundation
import SwiftUI

/// Struct with all required data to init the module
public struct MovementDetailsDataModel {
    let dataSource: DataSourceRead
    let isIncome: Bool
    let categoryStoreId: UUID
    let fromDate: Date
    let toDate: Date
    let tintColor: Color

    /// Default initializer
    /// - Parameters:
    ///   - dataSource: `DataSourceRead` instance used to get movements
    ///   - isIncome: used to check is managed data is for incomes or expenses
    ///   - categoryStoreId: UUID of category / store
    ///   - fromDate: starting date
    ///   - toDate: ending date
    ///   - tintColor: view tint color
    public init(dataSource: DataSourceRead,
                isIncome: Bool,
                categoryStoreId: UUID,
                fromDate: Date,
                toDate: Date,
                tintColor: Color) {
        self.dataSource = dataSource
        self.isIncome = isIncome
        self.categoryStoreId = categoryStoreId
        self.fromDate = fromDate
        self.toDate = toDate
        self.tintColor = tintColor
    }
}
