//
//  SummaryListView.swift
//
//
//  Created by Bastián Véliz Vega on 26-09-20.
//

import AccountsUI
import SwiftUI

struct SummaryListView: View {
    @Binding var model: DataModel

    init(model: Binding<DataModel>) {
        self._model = model
    }

    var body: some View {
        ScrollView {
            ListHeaderView(systemImageName: "dollarsign.circle.fill",
                           imageColor: .indigo,
                           title: L10n.expensesOf(model.month, model.year))
                .padding()
            ForEach(self.model.elements, id: \.id) { element in
                ExpeditureSimpleCardView(model: element)
            }
            .padding(EdgeInsets(top: 10, leading: 14, bottom: 0, trailing: 14))
        }
    }
}

struct SummaryListView_Previews: PreviewProvider {
    @State static var dataModel: SummaryListView.DataModel = DataPreview.summaryListDataModel
    static var previews: some View {
        SummaryListView(model: self.$dataModel)
    }
}
