//
//  DataPreview.swift
//
//
//  Created by Bastián Véliz Vega on 26-09-20.
//

import AccountsUI
import Foundation
import SwiftUI

enum DataPreview {
    static var simpleCardModelArray: [ExpeditureSimpleCardModel] {
        var array = [ExpeditureSimpleCardModel]()

        array.append(self.getSimpleCardModel(name: "Falabella",
                                             color: .green,
                                             amount: "$ 9.999.999"))

        array.append(self.getSimpleCardModel(name: "Santander",
                                             color: .red,
                                             amount: "$ 9.999.999"))

        array.append(self.getSimpleCardModel(name: "Banco de Chile",
                                             color: .blue,
                                             amount: "$ 9.999.999"))

        array.append(self.getSimpleCardModel(name: "Otros",
                                             color: .indigo,
                                             amount: "$ 9.999.999"))

        return array
    }

    static func getSimpleCardModel(name: String, color: Color, amount: String) -> ExpeditureSimpleCardModel {
        return ExpeditureSimpleCardModel(name: name,
                                         amount: amount,
                                         systemImageName: "creditcard.fill",
                                         imageTintColor: color)
    }
}
