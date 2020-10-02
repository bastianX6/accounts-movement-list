//
//  MovementListWithDataState.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import Foundation

class MovementListWithDataState: MovementListState {
    var showFilterView: Bool = false
    let showErrorView: Bool = false
    let showLoadingView: Bool = false
    let showEmptyView: Bool = false
    var error: Error?

    weak var viewModel: MovementListViewModel?

    init(viewModel: MovementListViewModel) {
        self.viewModel = viewModel
    }

    func filterData() {
        guard let viewModel = self.viewModel else {
            fatalError("You must set a viewmodel")
        }

        viewModel.setState(.filterByDate)
    }
}
