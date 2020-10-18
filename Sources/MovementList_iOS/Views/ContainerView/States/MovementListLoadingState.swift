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
    var showFilterView: Bool = false
    let showErrorView: Bool = false
    let showLoadingView: Bool = true
    let showEmptyView: Bool = false
    var error: Error?

    private var cancellables: [AnyCancellable] = []

    weak var viewModel: MovementListViewModel?

    init(viewModel: MovementListViewModel?) {
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
        let publisher: AnyPublisher<[MovementsSum], Error>

        if viewModel.isIncome {
            publisher = viewModel.dataSourceRead.getMovementSumByCategory(query: query)
        } else {
            publisher = viewModel.dataSourceRead.getMovementSumByStore(query: query)
        }

        let cancellable = publisher
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    // Check receive value to make state transition
                    break
                case let .failure(error):
                    viewModel.setState(.error(error: error))
                }
            } receiveValue: { movementData in
                let elements = viewModel.categoryStoreElements.map { element -> MovementSimpleCardModel in
                    let movementSum = movementData.first(where: { $0.id == element.id })?.sum ?? 0
                    return MovementSimpleCardModel(id: element.id,
                                                     name: element.name,
                                                     amount: movementSum.currencyString,
                                                     systemImageName: element.icon,
                                                     imageTintColor: element.color)
                }

                viewModel.setState(.withData(elements: elements))
            }

        self.cancellables.append(cancellable)
    }
}
