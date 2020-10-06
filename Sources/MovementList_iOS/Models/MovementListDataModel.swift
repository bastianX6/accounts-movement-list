//
//  MovementListDataModel.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import AccountsUI
import DataManagement
import Foundation

/// Contains all the data required by MovementListView
public struct MovementListDataModel {
    let dataSource: DataSourceRead
    let resources: MovementResources
    let isIncome: Bool

    /// Default initializer
    /// - Parameters:
    ///   - dataSource: data source used to store data
    ///   - resources: data with category and stores
    ///   - isIncome: flag that indicates if given data is for incomes or expenses
    public init(dataSource: DataSourceRead,
                resources: MovementResources,
                isIncome: Bool) {
        self.dataSource = dataSource
        self.resources = resources
        self.isIncome = isIncome
    }
}
