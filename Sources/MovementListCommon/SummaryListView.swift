//
//  SummaryListView.swift
//
//
//  Created by Bastián Véliz Vega on 26-09-20.
//

import AccountsUI
import SwiftUI

struct SummaryListView: View {
    let elements: [ExpeditureSimpleCardModel]
    let headerTitle: String

    var body: some View {
        ScrollView {
            ListHeaderView(systemImageName: "dollarsign.circle.fill",
                           imageColor: .indigo,
                           title: headerTitle)
                .padding()
            ForEach(self.elements, id: \.id) { element in
                ExpeditureSimpleCardView(model: element)
            }
            .padding(EdgeInsets(top: 10, leading: 14, bottom: 0, trailing: 14))
        }
    }
}

struct SummaryListView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryListView(elements: DataPreview.simpleCardModelArray,
                        headerTitle: "Gastos para Enero - 2020")
    }
}
