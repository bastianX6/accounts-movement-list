//
//  MovementDetailsSummary.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import Foundation

/// Summary of movement amounts
public struct MovementDetailsSummary {
    /// Sum of all permanent movements
    public let permamentMovementsTotal: Float

    /// Sum of all other movements
    public let otherMovementsTotal: Float

    /// Sum of all movements (permanent + other)
    public let allMovementsTotal: Float

    /// Default initializer
    /// - Parameters:
    ///   - permamentMovementsTotal: Sum of all permanent movements
    ///   - otherMovementsTotal: Sum of all other movements
    ///   - allMovementsTotal: Sum of all movements (permanent + other)
    public init(permamentMovementsTotal: Float,
                otherMovementsTotal: Float,
                allMovementsTotal: Float) {
        self.permamentMovementsTotal = permamentMovementsTotal
        self.otherMovementsTotal = otherMovementsTotal
        self.allMovementsTotal = allMovementsTotal
    }
}
