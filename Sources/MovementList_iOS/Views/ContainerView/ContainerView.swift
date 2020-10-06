//
//  ContainerView.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import AccountsUI
import SwiftUI

public struct ContainerView: View {
    private let dataModel: MovementListDataModel

    private var categoryStoreElements: [CategoryStoreModel] {
        return self.dataModel.isIncome ? self.dataModel.resources.categories : self.dataModel.resources.stores
    }

    public init(dataModel: MovementListDataModel) {
        self.dataModel = dataModel
    }

    /// View's body
    public var body: some View {
        let viewModel = MovementListViewModel(readDataSource: self.dataModel.dataSource,
                                              categoryStoreElements: self.categoryStoreElements,
                                              isIncome: self.dataModel.isIncome)

        return ContainerViewiOS(viewModel: viewModel)
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView(dataModel: MovementListDataModel(dataSource: MovementPreview(),
                                                           resources: DataPreview.movementResources,
                                                           isIncome: false))
        }
    }
}
