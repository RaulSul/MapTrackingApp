import MapKit
import UIKit

class Vehicle: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var vehicleInfo: CurrentVehicle

    init(coordinate: CLLocationCoordinate2D, vehicleInfo: CurrentVehicle) {
        self.coordinate = coordinate
        self.vehicleInfo = vehicleInfo
    }
}
