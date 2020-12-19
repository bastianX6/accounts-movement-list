//
//  ContainerViewiOS.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import AccountsUI
import DependencyResolver
import SwiftUI

struct ContainerViewInternal: View {
    @ObservedObject var viewModel: MovementListViewModel
    @EnvironmentObject var resolver: DependencyResolver

    private var viewTitle: String {
        let incomesText = L10n.incomesOf(self.viewModel.model.month, self.viewModel.model.year)
        let expensesText = L10n.expensesOf(self.viewModel.model.month, self.viewModel.model.year)

        let title = self.viewModel.isIncome ? incomesText : expensesText

        if let selectedStoreCategoryName = self.viewModel
            .categoryStoreElements
            .first(where: { $0.id == self.viewModel.selectedStoreCategory })?
            .name
        {
            return "\(title) - \(selectedStoreCategoryName)"
        } else {
            return title
        }
    }

    public init(viewModel: MovementListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        self.currentView
            .background(Color.systemGray6)
            .fullBackgroundColor(.systemGray6)
            .onAppear(perform: {
                self.viewModel.setState(.loading)
            })
            .toolbar {
                ToolbarItem {
                    self.filterView
                }
            }
            .navigationTitle(self.viewTitle)
    }

    private var currentView: some View {
        if self.viewModel.state.showErrorView {
            return self.errorView.eraseToAnyView()
        } else if self.viewModel.state.showLoadingView {
            self.viewModel.state.filterData()
            return self.loadingView.eraseToAnyView()
        } else {
            return self.listView.eraseToAnyView()
        }
    }

    private var errorView: some View {
        GenericErrorView(title: L10n.coulndTLoadYourData,
                         error: self.viewModel.state.error)
    }

    private var loadingView: some View {
        VStack {
            ProgressView()
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .background(Color.backgroundColor.opacity(0.5))
    }

    private var listView: some View {
        SummaryListView(viewModel: self.viewModel,
                        dataModel: self.$viewModel.model,
                        selectedStoreCategory: self.$viewModel.selectedStoreCategory)
    }

    // MARK: - Toolbar items

    private var filterView: some View {
        FilterView(selectedMonth: self.$viewModel.selectedMonth,
                   selectedYear: self.$viewModel.selectedYear)
            .frame(minWidth: 100)
    }
}

struct ContainerViewiOS_Previews: PreviewProvider {
    enum FakeError: Error {
        case fake
    }

    @State static var viewModel = MovementListViewModel(dataSourceRead: MovementPreview(),
                                                        categoryStoreElements: DataPreview.stores,
                                                        isIncome: false)

    @State static var viewModelWithErrorState: MovementListViewModel = {
        let viewModel = MovementListViewModel(dataSourceRead: MovementPreview(),
                                              categoryStoreElements: DataPreview.stores,
                                              isIncome: false)
        viewModel.setState(.error(error: FakeError.fake))
        return viewModel
    }()

    static var previews: some View {
        Group {
            ContainerViewInternal(viewModel: self.viewModel)
            ContainerViewInternal(viewModel: self.viewModelWithErrorState)
        }
    }
}
