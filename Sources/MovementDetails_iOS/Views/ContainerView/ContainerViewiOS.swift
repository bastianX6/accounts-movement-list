//
//  ContainerViewiOS.swift
//
//
//  Created by Bastián Véliz Vega on 05-10-20.
//

import AccountsUI
import SwiftUI

struct ContainerViewiOS: View {
    @ObservedObject var viewModel: MovementDetailsViewModel

    private var viewTitle: String {
        return self.viewModel.dataModel.categoryStoreData.name
    }

    public init(viewModel: MovementDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        self.currentView
            .background(Color.systemGray6)
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
        MovementDetailsView(model: self.$viewModel.model,
                            tintColor: self.viewModel.dataModel.categoryStoreData.color,
                            isIncome: self.viewModel.dataModel.isIncome)
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
            ContainerViewiOS(viewModel: self.viewModel)
            ContainerViewiOS(viewModel: self.viewModelWithErrorState)
            ContainerViewiOS(viewModel: self.viewModelWithLoadingState)
        }
    }
}
