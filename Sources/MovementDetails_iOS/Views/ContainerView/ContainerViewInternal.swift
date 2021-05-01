//
//  ContainerViewInternal.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import AccountsUI
import DependencyResolver
import NewMovement_iOS
import NewMovementCommon
import SwiftUI

struct ContainerViewInternal: View {
    @ObservedObject var viewModel: MovementDetailsViewModel
    @EnvironmentObject var resolver: DependencyResolver

    private var viewTitle: String {
        return self.viewModel.dataModel.categoryStoreData.name
    }

    public init(viewModel: MovementDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        self.currentView
            .background(Color.systemGray6)
            .fullBackgroundColor(.systemGray6)
            .navigationBarTitle(self.viewTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.viewModel.setState(.loading)
            }
    }

    private var currentView: some View {
        if self.viewModel.state.showErrorView {
            return self.errorView.eraseToAnyView()
        } else if self.viewModel.state.showLoadingView {
            self.viewModel.state.loadData()
            return self.loadingView.eraseToAnyView()
        } else {
            return self.movementDetailsView.eraseToAnyView()
        }
    }

    private var errorView: some View {
        GenericErrorView(title: L10n.coulndTLoadYourData,
                         error: self.viewModel.state.error)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity)
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

    private var movementDetailsView: some View {
        VStack {
            MovementDetailsView(model: self.$viewModel.model,
                                viewModel: self.viewModel,
                                tintColor: self.viewModel.dataModel.categoryStoreData.color,
                                isIncome: self.viewModel.dataModel.isIncome)
        }
        .sheet(isPresented: self.$viewModel.state.showEditMovementView,
               content: {
                   self.editView
               })
    }

    var editView: some View {
        guard let movement = self.viewModel.state.selectedMovement,
              let dataSourceModify = try? self.resolver.getDataSourceModify(forType: MovementDetailsAvailability.self),
              let incomeData = try? self.resolver.getIncomeResources(forType: MovementDetailsAvailability.self),
              let expenditureData = try? self.resolver.getExpenditureResources(forType: MovementDetailsAvailability.self)
        else {
            return Text("").eraseToAnyView()
        }

        let dataModel = NewMovementViewDataModel(dataSource: dataSourceModify,
                                                 incomeData: incomeData,
                                                 expenditureData: expenditureData)

        return NewMovement_iOS.NewMovementView(dataModel: dataModel,
                                               movement: movement,
                                               isIncome: self.viewModel.dataModel.isIncome) {
            self.viewModel.setState(.loading)
        }.eraseToAnyView()
    }
}

struct ContainerViewiOS_Previews: PreviewProvider {
    enum FakeError: Error {
        case fake
    }

    @State static var viewModel = MovementDetailsViewModel(dataModel: DataPreview.dataModel)

    @State static var viewModelWithErrorState: MovementDetailsViewModel = {
        let viewModel = MovementDetailsViewModel(dataModel: DataPreview.dataModel)
        viewModel.setState(.error(error: FakeError.fake))
        return viewModel
    }()

    @State static var viewModelWithLoadingState: MovementDetailsViewModel = {
        let viewModel = MovementDetailsViewModel(dataModel: DataPreview.dataModel)
        viewModel.setState(.loading)
        return viewModel
    }()

    static var previews: some View {
        Group {
            ContainerViewInternal(viewModel: self.viewModel)
            ContainerViewInternal(viewModel: self.viewModelWithErrorState)
            ContainerViewInternal(viewModel: self.viewModelWithLoadingState)
        }
    }
}
