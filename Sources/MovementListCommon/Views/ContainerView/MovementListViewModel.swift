//
//  MovementListViewModel.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import AccountsUI
import Combine
import DataManagement
import Foundation

class MovementListViewModel: ObservableObject {
    @Published var model: SummaryListView.DataModel
    @Published var filterDate: Date

    let readDataSource: DataSourceRead
    let incomeData: MovementResources
    let expeditureData: MovementResources
    let isIncome: Bool = true

    // MARK: - States

    private lazy var loadingState: MovementListState = MovementListLoadingState(viewModel: self)
    private lazy var emptyState: MovementListState = MovementListEmptyState(viewModel: self)
    private lazy var withDataState: MovementListState = MovementListWithDataState(viewModel: self)
    private lazy var errorState: MovementListState = MovementListErrorState(viewModel: self)
    private lazy var filterByDateState: MovementListState = MovementListFilterByDateState(viewModel: self)

    private(set) lazy var state: MovementListState = self.loadingState

    init(filterDate: Date = Date(),
         readDataSource: DataSourceRead,
         incomeData: MovementResources,
         expeditureData: MovementResources) {
        self.filterDate = filterDate
        self.readDataSource = readDataSource
        self.incomeData = incomeData
        self.expeditureData = expeditureData
        self.model = SummaryListView.DataModel()
    }

    func updateDataModel(with elements: [ExpeditureSimpleCardModel]) {
        let month = self.filterDate.monthName
        let year = self.filterDate.yearName
        self.model = SummaryListView.DataModel(month: month, year: year, elements: elements)
    }

    func setState(_ state: MovementListStateEnum) {
        switch state {
        case .loading:
            self.state = self.loadingState
        case .error:
            self.state = self.emptyState
        case let .withData(elements):
            self.updateDataModel(with: elements)
            self.state = self.withDataState
        case .error:
            self.state = self.errorState
        case .filterByDate:
            self.state = self.filterByDateState
        }
    }
}
