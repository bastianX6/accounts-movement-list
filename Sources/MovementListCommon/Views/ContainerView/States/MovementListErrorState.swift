//
//  MovementListErrorState.swift
//  
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import Foundation

class MovementListErrorState: MovementListState {
    let showFilterView: Bool = false
    let showErrorView: Bool = true
    let showLoadingView: Bool = false
    let showEmptyView: Bool = false

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
