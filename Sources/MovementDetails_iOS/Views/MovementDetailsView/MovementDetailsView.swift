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
    @Binding var model: MovementDetailsModel
    let tintColor: Color
    let isIncome: Bool

    private var permanentMovementsTitle: String {
        return self.isIncome ? L10n.permanentIncomes : L10n.permanentExpenses
    }

    private var otherMovementsTitle: String {
        return self.isIncome ? L10n.otherIncomes : L10n.otherExpenses
    }

    private var summaryIcon: String {
        return self.isIncome ? "dollarsign.square.fill" : "creditcard.fill"
    }

    private var permanentMovementsIcon: String {
        return self.isIncome ? "bag.fill.badge.plus" : "dollarsign.circle.fill"
    }

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
            ListHeaderView(systemImageName: self.summaryIcon,
                           imageColor: self.tintColor,
                           title: L10n.summary)

            VStack(alignment: .leading) {
                HStack {
                    Text(self.permanentMovementsTitle)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .leading)
                    Text(model.summary.permamentMovementsTotal.currencyString)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .trailing)
                }
                HStack {
                    Text(self.otherMovementsTitle)
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
            ListHeaderView(systemImageName: self.permanentMovementsIcon,
                           imageColor: self.tintColor,
                           title: self.permanentMovementsTitle)
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
                           title: self.otherMovementsTitle)
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
    @State static var model: MovementDetailsModel = DataPreview.movementDetailsModel

    static var previews: some View {
        Group {
            MovementDetailsView(model: self.$model,
                                tintColor: .indigo,
                                isIncome: false)
            MovementDetailsView(model: self.$model,
                                tintColor: .indigo,
                                isIncome: true)
        }
    }
}
