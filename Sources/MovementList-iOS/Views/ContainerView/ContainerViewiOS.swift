//
//  ContainerViewiOS.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import SwiftUI

struct ContainerViewiOS: View {
    @ObservedObject var viewModel: MovementListViewModel

    public init(viewModel: MovementListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            self.currentView
                .navigationBarTitle(L10n.expenses)
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
        SummaryListView(model: self.$viewModel.model)
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
                                                        stores: DataPreview.stores)
    static var previews: some View {
        ContainerViewiOS(viewModel: self.viewModel)
    }
}
