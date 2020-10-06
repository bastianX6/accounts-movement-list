//
//  MovementDetailWithDataState.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import Foundation

class MovementDetailWithDataState: MovementDetailViewState {
    let showErrorView: Bool = false
    let showLoadingView: Bool = false
    var error: Error?

    func loadData() {}
}
