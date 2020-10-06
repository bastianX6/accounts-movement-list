//
//  MovementDetailsModel.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import Foundation

public struct MovementDetailsModel {
    /// Movement summary information
    public let summary: MovementDetailsSummary

    /// Permament momvements details
    public let permanentMovements: [MovementDetailsItem]

    /// Other movements details
    public let otherMovements: [MovementDetailsItem]

    /// Default initializer
    /// - Parameters:
    ///   - summary: Movement summary information
    ///   - permanentMovements: Permament momvements details
    ///   - otherMovements: Other movements details
    public init(summary: MovementDetailsSummary,
                permanentMovements: [MovementDetailsItem],
                otherMovements: [MovementDetailsItem]) {
        self.summary = summary
        self.permanentMovements = permanentMovements
        self.otherMovements = otherMovements
    }
}
