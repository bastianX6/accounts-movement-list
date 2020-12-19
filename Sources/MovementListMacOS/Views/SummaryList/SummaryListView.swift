//
//  SummaryListView.swift
//
//
//  Created by Bastián Véliz Vega on 26-09-20.
//

import AccountsUI
import DependencyResolver
import MovementDetailsMacOS
import MovementListCommon
import SwiftUI

struct SummaryListView: View {
    @Binding var dataModel: SummaryListView.DataModel
    @Binding var selectedStoreCategory: UUID
    @EnvironmentObject var resolver: DependencyResolver

    let viewModel: MovementListViewModel

    private var imageName: String {
        return self.viewModel.isIncome ? "dollarsign.square.fill" : "dollarsign.circle.fill"
    }

    init(viewModel: MovementListViewModel,
         dataModel: Binding<SummaryListView.DataModel>,
         selectedStoreCategory: Binding<UUID>)
    {
        self.viewModel = viewModel
        self._dataModel = dataModel
        self._selectedStoreCategory = selectedStoreCategory
    }

    var body: some View {
        NavigationView {
            self.storeCategoryListView
                .frame(minWidth: 300)
            self.storeCategoryDetailView
        }
    }

    private var storeCategoryListView: some View {
        ScrollView {
            ForEach(self.dataModel.elements) { element in
                self.getStoreCategoryView(model: element)
            }
            .padding(EdgeInsets(top: 10,
                                leading: 14,
                                bottom: 0,
                                trailing: 14))
        }
    }

    func getStoreCategoryView(model: MovementSimpleCardModel) -> some View {
        return MovementSimpleCardView(model: model)
            .onTapGesture {
                self.selectedStoreCategory = model.id
            }
            .accentColor(Color.foregroundColor)
            .eraseToAnyView()
    }

    var storeCategoryDetailView: some View {
        guard let fromDate = self.viewModel.filterDate.startOfMonth(),
              let toDate = self.viewModel.filterDate.endOfMonth(),
              let currentCategoryStore = self.viewModel
              .categoryStoreElements
              .first(where: { $0.id == self.selectedStoreCategory })
        else {
            return Text("")
                .eraseToAnyView()
        }
        let dataModel = MovementDetailsDataModel(categoryStoreData: currentCategoryStore,
                                                 isIncome: self.viewModel.isIncome,
                                                 dataSourceRead: self.viewModel.dataSourceRead,
                                                 fromDate: fromDate,
                                                 toDate: toDate)

        return MovementDetailsMacOS.ContainerView(dataModel: dataModel)
            .eraseToAnyView()
    }
}

struct SummaryListView_Previews: PreviewProvider {
    @State static var dataModel: SummaryListView.DataModel = DataPreview.summaryListDataModel
    @State static var selectedStoreCategory = UUID()

    static var viewModel = MovementListViewModel(dataSourceRead: MovementPreview(),
                                                 categoryStoreElements: DataPreview.stores,
                                                 isIncome: false)
    static var previews: some View {
        SummaryListView(viewModel: self.viewModel,
                        dataModel: self.$dataModel,
                        selectedStoreCategory: self.$selectedStoreCategory)
    }
}
