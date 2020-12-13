//
//  MovementDetailEditState.swift
//
//
//  Created by Bastián Véliz Vega on 08-10-20.
//

import DataManagement
import Foundation

public class MovementDetailEditState: MovementDetailInitialState {
    override public init() {
        super.init()
        self.showEditMovementView = true
    }
}
