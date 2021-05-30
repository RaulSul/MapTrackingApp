//
//  Vehicle.swift
//  MapTrackingApp
//
//  Created by Raul Sulaimanov on 29.05.21.
//

import MapKit
import UIKit

class Vehicle: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var vehicleInfo: CurrentVehicle
    var title: String?

    init(coordinate: CLLocationCoordinate2D, vehicleInfo: CurrentVehicle) {
        self.coordinate = coordinate
        self.vehicleInfo = vehicleInfo
        self.title = vehicleInfo.model.rawValue
    }
}
