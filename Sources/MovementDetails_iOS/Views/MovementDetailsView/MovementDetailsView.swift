//
//  MovementDetailsView.swift
//
//
//  Created by Bastián Véliz Vega on 03-10-20.
//

import AccountsUI
import SwiftUI

struct MovementDetailsView: View {
    let tintColor: Color

    var body: some View {
        ScrollView {
            self.summaryView
            self.permanentExpensesView
            self.otherExpensesView
        }
        .padding(EdgeInsets(top: 0, leading: 14, bottom: 14, trailing: 14))
        .background(Color.systemGray6)
    }

    private var summaryView: some View {
        VStack {
            ListHeaderView(systemImageName: "creditcard.fill",
                           imageColor: self.tintColor,
                           title: L10n.summary)
            Text("Summary view")
        }
    }

    private var permanentExpensesView: some View {
        VStack {
            ListHeaderView(systemImageName: "dollarsign.circle.fill",
                           imageColor: self.tintColor,
                           title: L10n.permanentExpenses)
            Text("permanent expenses")
        }
    }

    private var otherExpensesView: some View {
        VStack {
            ListHeaderView(systemImageName: "bag.fill",
                           imageColor: self.tintColor,
                           title: L10n.otherExpenses)
            Text("Other expenses")
        }
    }
}

struct MovementDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovementDetailsView(tintColor: .indigo)
    }
}
