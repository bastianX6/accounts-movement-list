//
//  ContainerView.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import AccountsUI
import DependencyResolver
import SwiftUI

public struct ContainerView: View {
    private let dataModel: MovementListDataModel
    @EnvironmentObject var resolver: DependencyResolver

    private var categoryStoreElements: [CategoryStoreModel] {
        return self.dataModel.isIncome ? self.dataModel.resources.categories : self.dataModel.resources.stores
    }

    public init(dataModel: MovementListDataModel) {
        self.dataModel = dataModel
    }

    /// View's body
    public var body: some View {
        self.resolver.setDataSourceAvailability(MovementListAvailability.movementList,
                                                forType: MovementListAvailability.self)
        let viewModel = MovementListViewModel(dataSourceRead: self.dataModel.dataSourceRead,
                                              categoryStoreElements: self.categoryStoreElements,
                                              isIncome: self.dataModel.isIncome)

        return ContainerViewInternal(viewModel: viewModel)
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView(dataModel: MovementListDataModel(dataSourceRead: MovementPreview(),
                                                           resources: DataPreview.movementResources,
                                                           isIncome: false))
        }
    }
}
