//
//  MovementDetailErrorState.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import DataManagement
import Foundation

public class MovementDetailErrorState: MovementDetailInitialState {
    override public init() {
        super.init()
        self.showErrorView = true
    }
}
