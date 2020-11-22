//
//  MovementDetailEditState.swift
//
//
//  Created by Bastián Véliz Vega on 08-10-20.
//

import DataManagement
import Foundation

class MovementDetailEditState: MovementDetailViewState {
    var showErrorView: Bool = false
    var showLoadingView: Bool = false
    var showEditMovementView: Bool = true
    var error: Error?
    var selectedMovement: Movement?

    func loadData() {}
}
