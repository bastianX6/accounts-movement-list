//
//  MovementPreview.swift
//
//
//  Created by Bastián Véliz Vega on 01-10-20.
//

import Combine
import DataManagement
import Foundation

class MovementPreview {
    var isEmpty: Bool
    var movements: [Movement] = []

    init(isEmpty: Bool = false) {
        self.isEmpty = isEmpty
    }
}

extension MovementPreview: DataSourceRead {
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
}

extension MovementPreview: DataSourceModify {
    func save(movement: Movement) -> AnyPublisher<Void, Error> {
        let future = Future<Void, Error>() { [weak self] promise in
            guard let strongSelf = self else {
                return promise(.failure(MovementPreviewError.other))
            }
            strongSelf.movements.append(movement)
            promise(.success(()))
        }
        return future.eraseToAnyPublisher()
    }

    func delete(movement: Movement) -> AnyPublisher<Void, Error> {
        let future = Future<Void, Error>() { [weak self] promise in
            guard let strongSelf = self else {
                return promise(.failure(MovementPreviewError.other))
            }
            strongSelf.movements.removeAll(where: { $0.id == movement.id })
            promise(.success(()))
        }
        return future.eraseToAnyPublisher()
    }

    func update(movement: Movement) -> AnyPublisher<Void, Error> {
        let future = Future<Void, Error>() { [weak self] promise in
            guard let strongSelf = self else {
                return promise(.failure(MovementPreviewError.other))
            }
            strongSelf.movements.removeAll(where: { $0.id == movement.id })
            strongSelf.movements.append(movement)
            promise(.success(()))
        }
        return future.eraseToAnyPublisher()
    }
}

enum MovementPreviewError: Error {
    case other
}
