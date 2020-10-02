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

    public init(dataModel: MovementListDataModel) {
        self.dataModel = dataModel
    }

    /// View's body
    public var body: some View {
        let viewModel = MovementListViewModel(readDataSource: self.dataModel.dataSource,
                                              stores: self.dataModel.resources.stores)

        return ContainerViewiOS(viewModel: viewModel)
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView(dataModel: MovementListDataModel(dataSource: MovementPreview(),
                                                           resources: DataPreview.movementResources))
        }
    }
}
