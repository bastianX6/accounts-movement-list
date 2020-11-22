@testable import MovementListCommon
import XCTest

final class MovementDetailsMapperTests: XCTestCase {
    func testGetModel() {
        let date1 = Date()

        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        guard let date2 = dateFormat.date(from: "2018-02-01") else {
            XCTFail("Can't get dates")
            return
        }

        let calendar = Calendar.current
        let dateComponents1 = calendar.dateComponents([.day, .year, .month],
                                                      from: date1)
        let dateComponents2 = calendar.dateComponents([.day, .year, .month],
                                                      from: date2)

        guard let filteredDate1 = calendar.date(from: dateComponents1),
            let filteredDate2 = calendar.date(from: dateComponents2) else {
            XCTFail("Can't get filtered dates")
            return
        }

        let movement1 = MockMovement(amount: 100, date: date1, isPermanent: true)
        let movement2 = MockMovement(amount: 200, date: date1)
        let movement3 = MockMovement(amount: 300, date: date1, isPermanent: true)
        let movement4 = MockMovement(amount: 400, date: date2)
        let movement5 = MockMovement(amount: 500, date: date2, isPermanent: true)
        let movement6 = MockMovement(amount: 600, date: date2)

        let movements = [movement1, movement2, movement3, movement4, movement5, movement6]

        let model = MovementDetailsMapper.getModel(from: movements, icon: "", tintColor: .clear)

        // check summary
        let allMovementsTotal = movements.reduce(into: 0) { $0 += $1.amount }
        let permamentMovementsTotal = movements.reduce(into: 0) { $0 += $1.isPermanent ? $1.amount : 0 }
        let otherMovementsTotal = movements.reduce(into: 0) { $0 += $1.isPermanent ? 0 : $1.amount }

        XCTAssertEqual(model.summary.allMovementsTotal, allMovementsTotal)
        XCTAssertEqual(model.summary.permamentMovementsTotal, permamentMovementsTotal)
        XCTAssertEqual(model.summary.otherMovementsTotal, otherMovementsTotal)

        // check items
        XCTAssertEqual(model.otherMovements.count, 2)
        XCTAssertEqual(model.permanentMovements.count, 2)

        // Check permanent movements
        guard let firstPermanentMovement = model.permanentMovements.first,
            let lastPermanentMovement = model.permanentMovements.last else {
            XCTFail("Can't get permanent movements")
            return
        }

        XCTAssertEqual(firstPermanentMovement.date, filteredDate1)
        XCTAssertEqual(firstPermanentMovement.detailModels.count, 2)

        XCTAssertEqual(lastPermanentMovement.date, filteredDate2)
        XCTAssertEqual(lastPermanentMovement.detailModels.count, 1)

        // Check other movements
        guard let firstOtherMovement = model.otherMovements.first,
            let lastOtherMovement = model.otherMovements.last else {
            XCTFail("Can't get other movements")
            return
        }
        XCTAssertEqual(firstOtherMovement.date, filteredDate1)
        XCTAssertEqual(firstOtherMovement.detailModels.count, 1)

        XCTAssertEqual(lastOtherMovement.date, filteredDate2)
        XCTAssertEqual(lastOtherMovement.detailModels.count, 2)
    }

    func testGetSummary() {
        let date1 = Date()

        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        guard let date2 = dateFormat.date(from: "2018-02-01") else {
            XCTFail("Can't get dates")
            return
        }

        let movement1 = MockMovement(amount: 100, date: date1, isPermanent: true)
        let movement2 = MockMovement(amount: 200, date: date1)
        let movement3 = MockMovement(amount: 300, date: date2, isPermanent: true)
        let movement4 = MockMovement(amount: 400, date: date2)

        let movements = [movement1, movement2, movement3, movement4]

        let summary = MovementDetailsMapper.getSummary(movements: movements)

        XCTAssertEqual(summary.allMovementsTotal, movement1.amount
            + movement2.amount
            + movement3.amount
            + movement4.amount)

        XCTAssertEqual(summary.otherMovementsTotal, movement2.amount + movement4.amount)
        XCTAssertEqual(summary.permamentMovementsTotal, movement1.amount + movement3.amount)
    }

    func testGetGroupedDictionary() {
        let date1 = Date()

        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        guard let date2 = dateFormat.date(from: "2018-02-01") else {
            XCTFail("Can't get dates")
            return
        }

        let movement1 = MockMovement(date: date1)
        let movement2 = MockMovement(date: date1)
        let movement3 = MockMovement(date: date2)
        let movement4 = MockMovement(date: date2)

        let array = [movement1, movement2, movement3, movement4]

        let dict = MovementDetailsMapper.getGroupedDictionary(movements: array)

        XCTAssertEqual(dict.keys.count, 2)

        let calendar = Calendar.current
        let dateComponents1 = calendar.dateComponents([.day, .year, .month],
                                                      from: date1)
        let dateComponents2 = calendar.dateComponents([.day, .year, .month],
                                                      from: date2)

        guard let filteredDate1 = calendar.date(from: dateComponents1),
            let filteredDate2 = calendar.date(from: dateComponents2) else {
            XCTFail("Can't get filtered dates")
            return
        }

        XCTAssert(dict.keys.contains(filteredDate1))
        XCTAssert(dict.keys.contains(filteredDate2))

        guard let date1Elements = dict[filteredDate1],
            let date2Elements = dict[filteredDate2] else {
            XCTFail("Can't get arrays")
            return
        }

        XCTAssert(date1Elements.contains(where: { $0.id == movement1.id }))
        XCTAssert(date1Elements.contains(where: { $0.id == movement2.id }))

        XCTAssert(date2Elements.contains(where: { $0.id == movement3.id }))
        XCTAssert(date2Elements.contains(where: { $0.id == movement4.id }))
    }

    func tesGetArrayFromDictionary() {
        // Dates
        let date1 = Date()

        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        guard let date2 = dateFormat.date(from: "2018-02-01") else {
            XCTFail("Can't get dates")
            return
        }

        let calendar = Calendar.current
        let dateComponents1 = calendar.dateComponents([.day, .year, .month],
                                                      from: date1)
        let dateComponents2 = calendar.dateComponents([.day, .year, .month],
                                                      from: date2)

        guard let filteredDate1 = calendar.date(from: dateComponents1),
            let filteredDate2 = calendar.date(from: dateComponents2) else {
            XCTFail("Can't get filtered dates")
            return
        }

        // Movements

        let movement1 = MockMovement(date: date1)
        let movement2 = MockMovement(date: date1)
        let movement3 = MockMovement(date: date2)
        let movement4 = MockMovement(date: date2)

        let array = [movement1, movement2, movement3, movement4]

        let dict = MovementDetailsMapper.getGroupedDictionary(movements: array)
        let detailsItemArray = MovementDetailsMapper.getArrayFromDictionary(dict,
                                                                            icon: "",
                                                                            color: .clear)

        XCTAssertEqual(detailsItemArray.count, 2)

        guard let firstItem = detailsItemArray.first,
            let lastItem = detailsItemArray.last else {
            XCTFail("Can't get detail items")
            return
        }

        XCTAssertEqual(firstItem.date, filteredDate1)
        XCTAssert(firstItem.detailModels.contains(where: { $0.id == movement1.id }))
        XCTAssert(firstItem.detailModels.contains(where: { $0.id == movement2.id }))

        XCTAssertEqual(lastItem.date, filteredDate2)
        XCTAssert(firstItem.detailModels.contains(where: { $0.id == movement3.id }))
        XCTAssert(firstItem.detailModels.contains(where: { $0.id == movement4.id }))
    }
}
