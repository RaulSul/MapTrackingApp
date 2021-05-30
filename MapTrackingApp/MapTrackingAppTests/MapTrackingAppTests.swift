//
//  MapTrackingAppTests.swift
//  MapTrackingAppTests
//
//  Created by Raul Sulaimanov on 29.05.21.
//

import XCTest
import MapKit
@testable import MapTrackingApp

class MapTrackingAppTests: XCTestCase {
    var apiUnderTest: MapAPI!
    var viewModelUnderTest: LandingPageViewModel!
    var vcUnderTest: LandingPageVC!
    var vehicleUnderTest: Vehicle!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        apiUnderTest = MapAPI()
        viewModelUnderTest = LandingPageViewModel(mapAPI: apiUnderTest)
        vcUnderTest = LandingPageVC()
        vehicleUnderTest = Vehicle(
            coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
            vehicleInfo: CurrentVehicle(
                id: "someID",
                vehicleID: "someID",
                hardwareID: "someID",
                zoneID: .berlin,
                resolution: .claimed,
                resolvedBy: .iYmPlyTwy7BOUbsssugZKoTEA4F2,
                resolvedAt: "some String",
                battery: 15,
                state: .active,
                model: .aa,
                fleetbirdID: 15,
                latitude: 0.0,
                longitude: 0.0)
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModelUnderTest = nil
        vcUnderTest = nil
        apiUnderTest = nil
        vehicleUnderTest = nil
        
        try super.tearDownWithError()
    }
    
    //MARK: - Test Vehicle
    
    func testVehicle() {
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.id, "someID")
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.battery, 15)
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.fleetbirdID, 15)
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.hardwareID, "someID")
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.latitude, 0.0)
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.longitude, 0.0)
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.model, .aa)
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.resolution, .claimed)
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.resolvedBy, .iYmPlyTwy7BOUbsssugZKoTEA4F2)
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.resolvedAt, "some String")
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.state, .active)
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.vehicleID, "someID")
        XCTAssertEqual(vehicleUnderTest.vehicleInfo.zoneID, .berlin)
        XCTAssertEqual(vehicleUnderTest.coordinate.latitude, 0.0)
        XCTAssertEqual(vehicleUnderTest.coordinate.longitude, 0.0)
    }
    
    //MARK: - Test MapView
    
    func testMapViewDelegateNotNil() {
        vcUnderTest.viewDidLoad()
        
        XCTAssertNotNil(vcUnderTest.rootView.mapView.delegate)
    }
    
    func testMapViewUserLocation() {
        vcUnderTest.viewDidLoad()
        
        vcUnderTest.locateUser()
        
        XCTAssertEqual(vcUnderTest.rootView.mapView.userLocation.coordinate.latitude, 0.0) //happens because of simulator issues
        XCTAssertEqual(vcUnderTest.rootView.mapView.userLocation.coordinate.longitude, 0.0) // //happens because of simulator issues
    }
    
    //MARK: - Test ViewModel
    
    func testViewModel() {
        viewModelUnderTest.downloadScooterLocations(onDownload: {
            XCTAssert(self.viewModelUnderTest.currentVehicles.count > 0)
        })
    }
    
    //MARK: - Test API

    func testNumberOfObjectsOnApiFetch() {
        apiUnderTest.fetchMapRequest(
            onSuccess: { result in
            XCTAssertEqual(result.data.current.count, 151)
        },
            onError: {_ in}
        )
    }
    
    func testFirstResult() {
        apiUnderTest.fetchMapRequest(
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
    
    //MARK: - Test Performance
    
    func testPerformanceVCViewDidLoad() throws {
        self.measure {
            vcUnderTest.viewDidLoad()
        }
    }

    func testPerformanceDataDownload() throws {
        self.measure {
            apiUnderTest.fetchMapRequest(onSuccess: {_ in}, onError: {_ in})
        }
    }

}
