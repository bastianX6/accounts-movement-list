//
//  ContainerViewiOS.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import AccountsUI
import DependencyResolver
import SwiftUI

struct ContainerViewiOS: View {
    @ObservedObject var viewModel: MovementListViewModel
    @EnvironmentObject var resolver: DependencyResolver

    private var viewTitle: String {
        return self.viewModel.isIncome ? L10n.incomes : L10n.expenses
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
            .navigationBarTitle(self.viewTitle)
            .navigationBarItems(trailing: self.filterButton)
            .navigationBarTitleDisplayMode(.inline)
            .wrapInNavigationViewIfNeeded()
            .navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: self.$viewModel.state.showFilterView,
                   onDismiss: {
                       self.viewModel.setState(.loading)
                   },
                   content: {
                       NavigationView {
                           self.filterView
                       }
                       .accentColor(self.resolver.appearance.accentColor)
            })
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

    private var filterView: some View {
        FilterView(selectedMonth: self.$viewModel.selectedMonth,
                   selectedYear: self.$viewModel.selectedYear)
            .navigationBarTitle(L10n.filter)
            .navigationBarItems(leading: self.cancelButton,
                                trailing: self.applyFilterButton)
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
                        dataModel: self.$viewModel.model)
    }

    // MARK: - Navigation items

    private var filterButton: some View {
        Button {
            self.viewModel.setState(.filterByDate)
        } label: {
            Text(L10n.filter)
        }
        .disabled(self.viewModel.state.showLoadingView)
    }

    private var applyFilterButton: some View {
        Button {
            self.viewModel.setState(.loading)
        } label: {
            Text(L10n.filter)
        }
    }

    private var cancelButton: some View {
        Button {
            self.viewModel.setState(.loading)
        } label: {
            Text(L10n.cancel)
        }
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
            ContainerViewiOS(viewModel: self.viewModel)
            ContainerViewiOS(viewModel: self.viewModelWithErrorState)
        }
    }
}
