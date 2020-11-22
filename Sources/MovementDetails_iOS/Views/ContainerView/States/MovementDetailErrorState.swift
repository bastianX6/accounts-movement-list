//
//  MovementDetailErrorState.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import DataManagement
import Foundation

class MovementDetailErrorState: MovementDetailViewState {
    let showErrorView: Bool = true
    let showLoadingView: Bool = false
    var showEditMovementView: Bool = false
    var error: Error?
    var selectedMovement: Movement?

    func loadData() {}
}
