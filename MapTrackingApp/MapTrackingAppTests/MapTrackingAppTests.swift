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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
