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
    var error: Error? { get set }

    func filterData()
}

enum MovementListStateEnum {
    case loading
    case withData(elements: [MovementSimpleCardModel])
    case error(error: Error?)
    case filterByDate
}
