//
//  MovementDetailsMapper.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import AccountsUI
import DataManagement
import Foundation
import SwiftUI

/// Enum with static methods to map a `Movement`array  to a `MovementsDetailsModel` instance
public enum MovementDetailsMapper {
    /**
     Maps a `Movement` array to a `MovementsDetailsModel` instance

     - Parameters:
        - movements: Movements information
        - icon: System icon name (used by `ExpeditureDetailCardModel`)
        - tintColor: Icon tint color (used by `ExpeditureDetailCardModel`)

     - Returns: A instance of `MovementsDetailsModel`
     */
    public static func getModel(from movements: [Movement],
                                icon: String,
                                tintColor: Color) -> MovementsDetailsModel {
        let permanentMovements = movements.filter { $0.isPermanent }
        let otherMovements = movements.filter { !$0.isPermanent }

        // summary
        let permamentMovementsTotal = permanentMovements.reduce(into: 0) { $0 += $1.amount }
        let otherMovementsTotal = otherMovements.reduce(into: 0) { $0 += $1.amount }
        let allMovementsTotal = permamentMovementsTotal + otherMovementsTotal

        let summary = MovementDetailsSummary(permamentMovementsTotal: permamentMovementsTotal,
                                             otherMovementsTotal: otherMovementsTotal,
                                             allMovementsTotal: allMovementsTotal)

        // grouping elements

        // permament movements
        let permanentMovementsDict = self.getGroupedDictionary(movements: permanentMovements)
        let permanentsMovementItems = self.getArrayFromDictionary(permanentMovementsDict,
                                                                  icon: icon,
                                                                  color: tintColor)

        // other movements
        let otherMovementsDict = self.getGroupedDictionary(movements: otherMovements)
        let otherMovementItems = self.getArrayFromDictionary(otherMovementsDict,
                                                             icon: icon,
                                                             color: tintColor)

        return MovementsDetailsModel(summary: summary,
                                     permanentMovements: permanentsMovementItems,
                                     otherMovements: otherMovementItems)
    }

    /// Groups a `Movement` array by date
    /// - Parameter movements: movements to group
    /// - Returns: A dictionary with a `Date` as key and a `Movement` array as values
    static func getGroupedDictionary(movements: [Movement]) -> [Date: [Movement]] {
        return Dictionary(grouping: movements) { movement -> Date in
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.day, .year, .month],
                                                         from: movement.date)

            guard let date = dateComponents.date else { return Date() }

            return date
        }
    }

    /// Maps a dictionary to an array of `MovementDetailsItem`
    /// - Parameters:
    ///   - dict: grouped dictionary (obtained from `getGroupedDictionary` method)
    ///   - icon: System icon name (used by `ExpeditureDetailCardModel`)
    ///   - color: con tint color (used by `ExpeditureDetailCardModel`)
    /// - Returns: An array of `MovementDetailsItem` elements
    static func getArrayFromDictionary(_ dict: [Date: [Movement]],
                                       icon: String,
                                       color: Color) -> [MovementDetailsItem] {
        return dict.map { date, movements -> MovementDetailsItem in
            let detailCardModel = movements.map {
                ExpeditureDetailCardModel(systemImageName: icon,
                                          imageTintColor: color,
                                          title: $0.name,
                                          description: $0.description,
                                          amount: $0.amount.currencyString)
            }

            return MovementDetailsItem(date: date, detailModels: detailCardModel)
        }
    }
}
