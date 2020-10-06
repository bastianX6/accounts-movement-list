//
//  MovementPreview.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import Combine
import DataManagement
import Foundation

class MovementPreview: DataSourceRead {
    var isEmpty: Bool

    init(isEmpty: Bool = false) {
        self.isEmpty = isEmpty
    }

    func readMovements(query _: ReadMovementsQuery) -> AnyPublisher<[Movement], Error> {
        let future = Future<[Movement], Error>() { promise in
            promise(.success(DataPreview.movements))
        }
        return future.eraseToAnyPublisher()
    }

    func readMovement(id _: UUID) -> AnyPublisher<Movement, Error> {
        return Fail<Movement, Error>(error: MovementPreviewError.other).eraseToAnyPublisher()
    }

    func getMovementSumByCategory(query _: ReadMovementsQuery) -> AnyPublisher<[MovementsSum], Error> {
        let future = Future<[MovementsSum], Error>() { promise in
            promise(.success([]))
        }
        return future.eraseToAnyPublisher()
    }

    func getMovementSumByStore(query _: ReadMovementsQuery) -> AnyPublisher<[MovementsSum], Error> {
        let future = Future<[MovementsSum], Error>() { [unowned self] promise in
            promise(.success(self.isEmpty ? [] : DataPreview.movementSumArray))
        }
        return future.eraseToAnyPublisher()
    }

    private var movements: [Movement] = []
}

enum MovementPreviewError: Error {
    case other
}
