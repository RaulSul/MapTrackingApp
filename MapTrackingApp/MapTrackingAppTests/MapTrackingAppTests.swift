//
//  MapTrackingAppTests.swift
//  MapTrackingAppTests
//
//  Created by Raul Sulaimanov on 29.05.21.
//

import XCTest
@testable import MapTrackingApp

class MapTrackingAppTests: XCTestCase {
    var sut: MapAPI!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = MapAPI()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    func testNumberOfObjects() {
        sut.fetchMapRequest(
            onSuccess: { result in
            XCTAssertEqual(result.data.current.count, 151)
        },
            onError: {_ in}
        )
    }
    
    func testFirstResult() {
        sut.fetchMapRequest(
            onSuccess: { result in
                if let first = result.data.current.first {
                    XCTAssertEqual(first.id, "6348dfa0-1b20-40ed-98e9-fe9e232b6105")
                    XCTAssertEqual(first.battery, 91)
                    XCTAssertEqual(first.fleetbirdID, 118160)
                    XCTAssertEqual(first.hardwareID, "868446031763952")
                    XCTAssertEqual(first.latitude, 52.506731)
                    XCTAssertEqual(first.longitude, 13.289618)
                    XCTAssertEqual(first.model, .ab)
                    XCTAssertEqual(first.resolution, .claimed)
                    XCTAssertEqual(first.resolvedBy?.rawValue, "5VRiXTOvRWbWfAlIKDv10HrE8LJ2")
                    XCTAssertEqual(first.resolvedAt, "2019-10-10T06:35:21.153Z")
                    XCTAssertEqual(first.state, .active)
                    XCTAssertEqual(first.vehicleID, "8ece0495-bef0-4eac-a58e-dede2bf975a3")
                }
            },
            onError:{ _ in } )
    }

    func testPerformanceDataDownload() throws {
        self.measure {
            sut.fetchMapRequest(onSuccess: {_ in}, onError: {_ in})
        }
    }

}
