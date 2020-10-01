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

    /// Default initializer
    /// - Parameters:
    ///   - dataSource: data source used to store data
    ///   - resources: data with category and stores
    public init(dataSource: DataSourceRead,
                resources: MovementResources) {
        self.dataSource = dataSource
        self.resources = resources
    }
}
