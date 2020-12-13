//
//  MovementDetailsViewModel.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import Combine
import DataManagement
import Foundation
import MovementListCommon
import SwiftUI

class MovementDetailsViewModel: ObservableObject, MovementDetailsViewModelProtocol {
    @Published var model: MovementDetailsModel
    @Published var state: MovementDetailViewState
    var movements: [Movement] = []

    private let errorState = MovementDetailErrorState()
    private let withDataState = MovementDetailWithDataState()
    private let editState = MovementDetailEditState()
    private let loadingState: MovementDetailLoadingState

    let dataModel: MovementDetailsDataModel

    init(dataModel: MovementDetailsDataModel) {
        self.dataModel = dataModel
        self.model = MovementDetailsMapper.getModel(from: [],
                                                    icon: "",
                                                    tintColor: .clear)
        let loadingState = MovementDetailLoadingState(viewModel: nil)
        self.loadingState = loadingState
        self.state = loadingState
        loadingState.viewModel = self
    }

    func setState(_ state: MovementDetailViewStateEnum) {
        switch state {
        case let .error(error):
            self.errorState.error = error
            self.state = self.errorState
        case let .withData(model):
            self.model = model
            self.state = self.withDataState
        case .loading:
            self.state = self.loadingState
        case let .editMovement(id):
            let movement = self.movements.first(where: { $0.id == id })
            self.editState.showEditMovementView = true
            self.editState.selectedMovement = movement
            self.state = self.editState
        }
    }
}
