//
//  ViewController.swift
//  MapTrackingApp
//
//  Created by Raul Sulaimanov on 29.05.21.
//

import UIKit
import MapKit
import CoreLocation

class LandingPageVC: UIViewController {
    var viewModel: LandingPageViewModel?
    var locationManager: CLLocationManager?
    
    lazy var rootView: LandingPageView = {
        return LandingPageView()
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
          }
        
        view.addSubview(rootView)
        
        rootView.mapView.delegate = self
        
        viewModel = LandingPageViewModel(mapAPI: MapAPI())
        viewModel?.downloadScooterLocations(onDownload: { self.invalidate() })
        
        rootView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func invalidate() {
        viewModel?.currentVehicles.forEach { vehicle in
            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: vehicle.latitude, longitude: vehicle.longitude)
            self.rootView.mapView.addAnnotation(
                Vehicle(
                    coordinate: coordinate,
                    vehicleInfo: vehicle)
            )
        }
    }
}

extension LandingPageVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.rootView.mapView.setRegion(region, animated: true)
        }
    }
}

extension LandingPageVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation ) -> MKAnnotationView? {
        guard let annotation = annotation as? Vehicle else {  return nil }
        let identifier = "Vehicle"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let vehicle = view.annotation as? Vehicle else { return }
        
        let vehicleView: VehicleView = VehicleView()
        vehicleView.titleLabel.text = vehicleView.titleLabel.text! + "\(vehicle.vehicleInfo.vehicleID)"
        vehicleView.batteryLabel.text = vehicleView.batteryLabel.text! + "\(vehicle.vehicleInfo.battery)%"
        vehicleView.statusLabel.text = vehicleView.statusLabel.text! + "\(vehicle.vehicleInfo.state.rawValue)"
        vehicleView.onOkPressed = {
            vehicleView.removeFromSuperview()
            self.rootView.mapView.deselectAnnotation(view.annotation, animated: true)
        }
        
        self.view.insertSubview(vehicleView, aboveSubview: rootView.mapView)
        
        vehicleView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        vehicleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        vehicleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        vehicleView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.view.subviews.forEach {
            if $0 is VehicleView {
                $0.removeFromSuperview()
            }
        }
    }
}