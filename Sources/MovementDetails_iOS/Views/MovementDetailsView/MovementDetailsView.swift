//
//  MovementDetailsView.swift
//
//
//  Created by Bastián Véliz Vega on 03-10-20.
//

import AccountsUI
import MovementListCommon
import SwiftUI

struct MovementDetailsView: View {
    let tintColor: Color
    let model: MovementDetailsModel

    var body: some View {
        ScrollView {
            self.summaryView
            self.permanentExpensesView
            self.otherExpensesView
        }
        .background(Color.systemGray6)
    }

    private var summaryView: some View {
        VStack {
            ListHeaderView(systemImageName: "creditcard.fill",
                           imageColor: self.tintColor,
                           title: L10n.summary)

            VStack(alignment: .leading) {
                HStack {
                    Text(L10n.permanentExpenses)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .leading)
                    Text(model.summary.permamentMovementsTotal.currencyString)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .trailing)
                }
                HStack {
                    Text(L10n.otherExpenses)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .leading)
                    Text(model.summary.otherMovementsTotal.currencyString)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .trailing)
                }
                Divider()
                HStack {
                    Text(L10n.total)
                        .bold()
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .leading)
                    Text(model.summary.allMovementsTotal.currencyString)
                        .bold()
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .trailing)
                }
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
        .padding()
    }

    private var permanentExpensesView: some View {
        VStack {
            ListHeaderView(systemImageName: "dollarsign.circle.fill",
                           imageColor: self.tintColor,
                           title: L10n.permanentExpenses)
            ForEach(self.model.permanentMovements) { movementItem in
                Text(movementItem.date.relativeDateString)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           alignment: .leading)
                ForEach(movementItem.detailModels) { movement in
                    ExpeditureDetailCardView(model: movement)
                }
            }
        }
        .padding()
    }

    private var otherExpensesView: some View {
        VStack {
            ListHeaderView(systemImageName: "bag.fill",
                           imageColor: self.tintColor,
                           title: L10n.otherExpenses)
            ForEach(self.model.otherMovements) { movementItem in
                Text(movementItem.date.relativeDateString)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           alignment: .leading)
                ForEach(movementItem.detailModels) { movement in
                    ExpeditureDetailCardView(model: movement)
                }
            }
        }
        .padding()
    }
}

struct MovementDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovementDetailsView(tintColor: .indigo,
                            model: DataPreview.movementDetailsModel)
    }
}
