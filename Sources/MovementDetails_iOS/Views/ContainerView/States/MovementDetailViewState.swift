//
//  MovementDetailViewState.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import DataManagement
import Foundation
import MovementListCommon

enum MovementDetailViewStateEnum {
    case loading
    case withData(model: MovementDetailsModel)
    case error(error: Error)
    case editMovement(id: UUID)
}

protocol MovementDetailViewState {
    var showErrorView: Bool { get }
    var showLoadingView: Bool { get }
    var showEditMovementView: Bool { get set }
    var error: Error? { get set }
    var selectedMovement: Movement? { get set }

    func loadData()
}
