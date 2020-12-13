//
//  SummaryListView.swift
//
//
//  Created by Bastián Véliz Vega on 26-09-20.
//

import AccountsUI
import DependencyResolver
import MovementDetails_iOS
import MovementListCommon
import SwiftUI

struct SummaryListView: View {
    @Binding var dataModel: SummaryListView.DataModel
    @EnvironmentObject var resolver: DependencyResolver
    let viewModel: MovementListViewModel

    private var headerTitle: String {
        let incomesText = L10n.incomesOf(self.dataModel.month, self.dataModel.year)
        let expensesText = L10n.expensesOf(self.dataModel.month, self.dataModel.year)
        return self.viewModel.isIncome ?
            incomesText : expensesText
    }

    private var imageName: String {
        return self.viewModel.isIncome ? "dollarsign.square.fill" : "dollarsign.circle.fill"
    }

    init(viewModel: MovementListViewModel,
         dataModel: Binding<SummaryListView.DataModel>)
    {
        self.viewModel = viewModel
        self._dataModel = dataModel
    }

    var body: some View {
        ScrollView {
            ListHeaderView(systemImageName: self.imageName,
                           imageColor: .indigo,
                           title: self.headerTitle)
                .padding()
            ForEach(self.dataModel.elements) { element in
                self.getNavigationLink(model: element)
            }
            .padding(EdgeInsets(top: 10, leading: 14, bottom: 0, trailing: 14))
        }
    }

    func getNavigationLink(model: MovementSimpleCardModel) -> some View {
        guard let fromDate = self.viewModel.filterDate.startOfMonth(),
              let toDate = self.viewModel.filterDate.endOfMonth(),
              let currentCategoryStore = self.viewModel
              .categoryStoreElements
              .first(where: { $0.id == model.id })
        else {
            return Text("").eraseToAnyView()
        }
        let dataModel = MovementDetailsDataModel(categoryStoreData: currentCategoryStore,
                                                 isIncome: self.viewModel.isIncome,
                                                 dataSourceRead: self.viewModel.dataSourceRead,
                                                 fromDate: fromDate,
                                                 toDate: toDate)

        let detailsContainerView = MovementDetails_iOS.ContainerView(dataModel: dataModel)

        return NavigationLink(destination: detailsContainerView) {
            MovementSimpleCardView(model: model)
        }
        .accentColor(Color.foregroundColor)
        .eraseToAnyView()
    }
}

struct SummaryListView_Previews: PreviewProvider {
    @State static var dataModel: SummaryListView.DataModel = DataPreview.summaryListDataModel

    static var viewModel = MovementListViewModel(dataSourceRead: MovementPreview(),
                                                 categoryStoreElements: DataPreview.stores,
                                                 isIncome: false)
    static var previews: some View {
        SummaryListView(viewModel: self.viewModel, dataModel: self.$dataModel)
    }
}
