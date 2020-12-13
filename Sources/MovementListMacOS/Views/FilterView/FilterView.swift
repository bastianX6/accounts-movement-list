//
//  FilterView.swift
//
//
//  Created by Bastián Véliz Vega on 02-10-20.
//

import AccountsUI
import SwiftUI

struct FilterView: View {
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int

    var years: [PickerElement<Int, String>] {
        var array = [PickerElement<Int, String>]()
        array.append(PickerElement<Int, String>(id: 2019, element: "2019"))
        array.append(PickerElement<Int, String>(id: 2020, element: "2020"))
        array.append(PickerElement<Int, String>(id: 2021, element: "2021"))
        return array
    }

    init(selectedMonth: Binding<Int>,
         selectedYear: Binding<Int>)
    {
        self._selectedMonth = selectedMonth
        self._selectedYear = selectedYear
    }

    var body: some View {
        HStack {
            MonthPickerView(title: L10n.month,
                            selection: self.$selectedMonth,
                            showTitle: false)
            LabelPickerView(title: L10n.year,
                            elements: self.years,
                            selection: self.$selectedYear,
                            showTitle: false)
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    @State static var selectedMonth: Int = 1
    @State static var selectedYear: Int = 2019

    static var previews: some View {
        FilterView(selectedMonth: self.$selectedMonth,
                   selectedYear: self.$selectedYear)
    }
}
