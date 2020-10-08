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
import MovementListCommon

class MovementListViewModel: ObservableObject {
    @Published var model: SummaryListView.DataModel
    @Published var filterDate: Date
    @Published var state: MovementListState = MovementListLoadingState(viewModel: nil)

    @Published var selectedMonth: Int {
        didSet {
            self.updateDate()
        }
    }

    @Published var selectedYear: Int {
        didSet {
            self.updateDate()
        }
    }

    let dataSourceRead: DataSourceRead
    let dataSourceModify: DataSourceModify
    let categoryStoreElements: [CategoryStoreModel]
    let isIncome: Bool

    // MARK: - States

    private var loadingState = MovementListLoadingState(viewModel: nil)
    private lazy var withDataState = MovementListWithDataState(viewModel: self)
    private lazy var errorState = MovementListErrorState(viewModel: self)
    private lazy var filterByDateState = MovementListFilterByDateState(viewModel: self)

    init(filterDate: Date = Date(),
         dataSourceRead: DataSourceRead,
         dataSourceModify: DataSourceModify,
         categoryStoreElements: [CategoryStoreModel],
         isIncome: Bool) {
        self.filterDate = filterDate
        self.dataSourceRead = dataSourceRead
        self.dataSourceModify = dataSourceModify
        self.categoryStoreElements = categoryStoreElements
        self.isIncome = isIncome
        self.model = SummaryListView.DataModel()
        self.state = self.loadingState

        let calendar = Calendar.current
        self.selectedMonth = calendar.component(.month, from: filterDate)
        self.selectedYear = calendar.component(.year, from: filterDate)

        self.loadingState.viewModel = self
    }

    func updateDataModel(with elements: [ExpeditureSimpleCardModel]) {
        let month = self.filterDate.monthName
        let year = self.filterDate.yearName
        self.model = SummaryListView.DataModel(month: month, year: year, elements: elements)
    }

    func setState(_ state: MovementListStateEnum) {
        self.filterByDateState.showFilterView = false
        switch state {
        case .loading:
            self.state = self.loadingState
        case let .withData(elements):
            self.updateDataModel(with: elements)
            self.state = self.withDataState
        case let .error(error):
            self.errorState.error = error
            self.state = self.errorState
        case .filterByDate:
            self.filterByDateState.showFilterView = true
            self.state = self.filterByDateState
        }
    }

    private func updateDate() {
        let calendar = Calendar.current
        var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.filterDate)
        component.month = self.selectedMonth
        component.year = self.selectedYear
        guard let date = calendar.date(from: component) else {
            fatalError("Couldn't get date")
        }
        self.filterDate = date
    }

    private func updateSelectedElementsFromDate() {}
}
