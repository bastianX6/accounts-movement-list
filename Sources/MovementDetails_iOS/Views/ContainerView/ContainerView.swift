//
//  ContainerView.swift
//
//
//  Created by Bastián Véliz Vega on 06-10-20.
//

import AccountsUI
import SwiftUI

public struct ContainerView: View {
    private let dataModel: MovementDetailsDataModel

    public init(dataModel: MovementDetailsDataModel) {
        self.dataModel = dataModel
    }

    /// View's body
    public var body: some View {
        let viewModel = MovementDetailsViewModel(dataModel: self.dataModel)

        return ContainerViewiOS(viewModel: viewModel)
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerView(dataModel: DataPreview.dataModel)
        }
    }
}
