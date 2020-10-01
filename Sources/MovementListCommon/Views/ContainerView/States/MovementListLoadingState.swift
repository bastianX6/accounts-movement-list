//
//  MovementListLoadingState.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import AccountsUI
import Combine
import DataManagement
import Foundation

class MovementListLoadingState: MovementListState {
    let showFilterView: Bool = false
    let showErrorView: Bool = false
    let showLoadingView: Bool = true
    let showEmptyView: Bool = false

    private var cancellables: [AnyCancellable] = []

    weak var viewModel: MovementListViewModel?

    init(viewModel: MovementListViewModel) {
        self.viewModel = viewModel
    }

    func filterData() {
        self.cancellables.forEach { $0.cancel() }
        self.cancellables.removeAll()

        guard let viewModel = self.viewModel else {
            fatalError("You must set a viewmodel")
        }

        guard let startDate = viewModel.filterDate.startOfMonth(),
            let endDate = viewModel.filterDate.endOfMonth() else { return }
        let query = ReadMovementsQuery(fromDate: startDate, toDate: endDate)
        let cancellable = viewModel.readDataSource
            .getMovementSumByStore(query: query).sink { completion in
                switch completion {
                case .finished:
                    // Check receive value to make state transition
                    break
                case let .failure(error):
                    viewModel.setState(.error)
                }
            } receiveValue: { movementData in
                guard !movementData.isEmpty else {
                    viewModel.setState(.empty)
                    return
                }

                let stores = viewModel.isIncome ? viewModel.incomeData.stores : viewModel.expeditureData.stores

                let elements = stores.map { store -> ExpeditureSimpleCardModel in
                    let movementSum = movementData.first(where: { $0.id == store.id })?.sum ?? 0
                    return ExpeditureSimpleCardModel(name: store.name,
                                                     amount: "$ \(movementSum)",
                                                     systemImageName: "creditcard.fill",
                                                     imageTintColor: .indigo)
                }

                viewModel.setState(.withData(elements: elements))
            }

        self.cancellables.append(cancellable)
    }
}
