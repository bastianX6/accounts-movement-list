//
//  MovementDetailsItem.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import AccountsUI
import Foundation

public struct MovementDetailsItem {
    /// Movement date. It's the same for all movements
    public let date: Date

    /// Array of `ExpeditureDetailCardModel` with movement details
    public let detailModels: [ExpeditureDetailCardModel]

    /// Default initializer
    /// - Parameters:
    ///   - date: Movement date. It's the same for all movements
    ///   - detailModels: Array of `ExpeditureDetailCardModel` with movement details
    public init(date: Date,
                detailModels: [ExpeditureDetailCardModel]) {
        self.date = date
        self.detailModels = detailModels
    }
}
