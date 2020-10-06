//
//  MovementDetailLoadingState.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import Combine
import DataManagement
import Foundation
import MovementListCommon

class MovementDetailLoadingState: MovementDetailViewState {
    weak var viewModel: MovementDetailsViewModel?

    var showErrorView: Bool = false
    var showLoadingView: Bool = true
    var error: Error?

    var cancellables: [AnyCancellable] = []

    init(viewModel: MovementDetailsViewModel?) {
        self.viewModel = viewModel
    }

    func loadData() {
        guard let viewModel = self.viewModel else {
            fatalError("You should set a viewModel")
        }

        self.cancellables.forEach { $0.cancel() }
        self.cancellables.removeAll()

        let query = ReadMovementsQuery(fromDate: viewModel.dataModel.fromDate,
                                       toDate: viewModel.dataModel.toDate,
                                       storeId: viewModel.dataModel.isIncome ? nil : viewModel.dataModel.categoryStoreData.id,
                                       categoryId: viewModel.dataModel.isIncome ? viewModel.dataModel.categoryStoreData.id : nil,
                                       paymentId: nil)

        let cancellable = viewModel.dataModel.dataSource.readMovements(query: query)
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    viewModel.setState(.error(error: error))
                case .finished:
                    break
                }
            } receiveValue: { movements in
                let model = MovementDetailsMapper.getModel(from: movements,
                                                           icon: viewModel.dataModel.categoryStoreData.icon,
                                                           tintColor: viewModel.dataModel.categoryStoreData.color)
                viewModel.setState(.withData(model: model))
            }

        self.cancellables.append(cancellable)
    }
}
