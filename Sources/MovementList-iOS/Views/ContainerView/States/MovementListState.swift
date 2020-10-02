//
//  MovementListState.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import AccountsUI
import Combine
import DataManagement
import Foundation

protocol MovementListState {
    var showFilterView: Bool { get set }
    var showErrorView: Bool { get }
    var showLoadingView: Bool { get }
    var showEmptyView: Bool { get }

    func filterData()
}

enum MovementListStateEnum {
    case loading
    case empty
    case withData(elements: [ExpeditureSimpleCardModel])
    case error
    case filterByDate
}
