import MapKit

class VehicleAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            calloutOffset = CGPoint(x: -5, y: 5)
            glyphImage = UIImage(named: "scooter")
            markerTintColor = UIColor(red: 0.25, green: 0.50, blue: 0.43, alpha: 1.00)
        }
    }
}
