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
    let dataSourceRead: DataSourceRead
    let dataSourceModify: DataSourceModify
    let resources: MovementResources
    let isIncome: Bool

    /// Default initializer
    /// - Parameters:
    ///   - dataSourceRead: data source used to read data
    ///   - dataSourceModify: data source used to store data
    ///   - resources: data with category and stores
    ///   - isIncome: flag that indicates if given data is for incomes or expenses
    public init(dataSourceRead: DataSourceRead,
                dataSourceModify: DataSourceModify,
                resources: MovementResources,
                isIncome: Bool) {
        self.dataSourceRead = dataSourceRead
        self.dataSourceModify = dataSourceModify
        self.resources = resources
        self.isIncome = isIncome
    }
}
