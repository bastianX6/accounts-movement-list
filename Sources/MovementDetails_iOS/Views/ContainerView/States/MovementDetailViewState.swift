//
//  MovementDetailViewState.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import Foundation
import MovementListCommon

enum MovementDetailViewStateEnum {
    case loading
    case withData(model: MovementDetailsModel)
    case error(error: Error)
}

protocol MovementDetailViewState {
    var showErrorView: Bool { get }
    var showLoadingView: Bool { get }
    var error: Error? { get set }

    func loadData()
}
