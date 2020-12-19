//
//  MovementDetailsViewModelProtocol.swift
//
//
//  Created by Bastián Véliz Vega on 13-12-20.
//

import Foundation
import DataManagement

public protocol MovementDetailsViewModelProtocol: AnyObject {
    var dataModel: MovementDetailsDataModel { get }
    var movements: [Movement] { get set }
    func setState(_ state: MovementDetailViewStateEnum)
}
