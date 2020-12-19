//
//  ContainerView.swift
//
//
//  Created by Bastián Véliz Vega on 06-10-20.
//

import AccountsUI
import DependencyResolver
import SwiftUI
import MovementListCommon

public struct ContainerView: View {
    private let dataModel: MovementDetailsDataModel
    @EnvironmentObject var resolver: DependencyResolver

    public init(dataModel: MovementDetailsDataModel) {
        self.dataModel = dataModel
    }

    /// View's body
    public var body: some View {
        self.resolver.setDataSourceAvailability(MovementDetailsAvailability.movementDetails,
                                                forType: MovementDetailsAvailability.self)
        self.resolver.setResourcesAvailability(MovementDetailsAvailability.movementDetails,
                                                forType: MovementDetailsAvailability.self)
        let viewModel = MovementDetailsViewModel(dataModel: self.dataModel)

        return ContainerViewInternal(viewModel: viewModel)
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView(dataModel: DataPreview.dataModel)
        }
    }
}
