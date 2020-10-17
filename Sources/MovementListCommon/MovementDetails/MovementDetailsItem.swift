//
//  MovementDetailsItem.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import AccountsUI
import Foundation

public struct MovementDetailsItem: Identifiable {
    /// Item id. Default value: UUID()
    public let id: UUID = UUID()

    /// Movement date. It's the same for all movements
    public let date: Date

    /// Array of `MovementDetailCardModel` with movement details
    public let detailModels: [MovementDetailCardModel]

    /// Default initializer
    /// - Parameters:
    ///   - date: Movement date. It's the same for all movements
    ///   - detailModels: Array of `MovementDetailCardModel` with movement details
    public init(date: Date,
                detailModels: [MovementDetailCardModel]) {
        self.date = date
        self.detailModels = detailModels
    }
}
