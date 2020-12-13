//
//  MovementDetailsAvailability.swift
//
//
//  Created by Bastián Véliz Vega on 09-10-20.
//

import DependencyResolver
import Foundation

enum MovementDetailsAvailability {
    case movementDetails
}

extension MovementDetailsAvailability: DataSourceAvailability {
    public func availability(for type: DataSourceType) -> Bool {
        switch type {
        case .read:
            return true
        case .modify:
            return true
        }
    }
}

extension MovementDetailsAvailability: ResourcesAvailability {
    public func availability(for type: ResourceType) -> Bool {
        switch type {
        case .incomesData:
            return true
        case .expensesData:
            return true
        }
    }
}
