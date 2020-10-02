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
    let isIncome: Bool

    private var headerTitle: String {
        return self.isIncome ?
            L10n.incomesOf(self.model.month, self.model.year) : L10n.expensesOf(self.model.month, self.model.year)
    }

    private var imageName: String {
        return self.isIncome ? "dollarsign.square.fill" : "dollarsign.circle.fill"
    }

    init(model: Binding<DataModel>, isIncome: Bool) {
        self._model = model
        self.isIncome = isIncome
    }

    var body: some View {
        ScrollView {
            ListHeaderView(systemImageName: self.imageName,
                           imageColor: .indigo,
                           title: self.headerTitle)
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
        SummaryListView(model: self.$dataModel, isIncome: false)
    }
}
