//
//  MovementListAvailability.swift
//
//
//  Created by Bastián Véliz Vega on 09-10-20.
//

import DependencyResolver
import Foundation

enum MovementListAvailability {
    case movementList
}

extension MovementListAvailability: DataSourceAvailability {
    public func availability(for type: DataSourceType) -> Bool {
        switch type {
        case .read:
            return true
        case .modify:
            return false
        }
    }
}
