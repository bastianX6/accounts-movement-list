//
//  MovementDetailInitialState.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import DataManagement
import Foundation

public class MovementDetailInitialState: MovementDetailViewState {
    public var showErrorView: Bool = false
    public var showLoadingView: Bool = false
    public var showEditMovementView: Bool = false
    public var error: Error?
    public var selectedMovement: Movement?

    public func loadData() {}
}
