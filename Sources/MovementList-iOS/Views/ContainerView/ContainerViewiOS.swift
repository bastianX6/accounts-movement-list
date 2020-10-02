//
//  ContainerViewiOS.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import SwiftUI

struct ContainerViewiOS: View {
    @ObservedObject var viewModel: MovementListViewModel

    private var viewTitle: String {
        return self.viewModel.isIncome ? L10n.incomes : L10n.expenses
    }

    public init(viewModel: MovementListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            self.currentView
                .navigationBarTitle(self.viewTitle)
                .navigationBarItems(trailing: self.filterButton)
        }
        .sheet(isPresented: self.$viewModel.state.showFilterView,
               onDismiss: {
                   self.viewModel.setState(.loading)
               },
               content: {
                   NavigationView {
                       self.filterView
                   }
        })
    }

    private var currentView: some View {
        if self.viewModel.state.showEmptyView {
            return self.emptyView.eraseToAnyView()
        } else if self.viewModel.state.showErrorView {
            return self.errorView.eraseToAnyView()
        } else if self.viewModel.state.showLoadingView {
            self.viewModel.state.filterData()
            return self.loadingView.eraseToAnyView()
        } else {
            return self.listView.eraseToAnyView()
        }
    }

    private var emptyView: some View {
        Text("Empty view")
    }

    private var filterView: some View {
        Text("Filter view")
    }

    private var errorView: some View {
        Text("Error view")
    }

    private var loadingView: some View {
        VStack {
            if #available(iOS 14.0, *) {
                ProgressView()
            } else {
                Text("Loading")
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .background(Color.backgroundColor.opacity(0.5))
    }

    private var listView: some View {
        SummaryListView(model: self.$viewModel.model,
                        isIncome: self.viewModel.isIncome)
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
}

struct ContainerViewiOS_Previews: PreviewProvider {
    @State static var viewModel = MovementListViewModel(readDataSource: MovementPreview(),
                                                        categoryStoreElements: DataPreview.stores,
                                                        isIncome: false)
    static var previews: some View {
        ContainerViewiOS(viewModel: self.viewModel)
    }
}
