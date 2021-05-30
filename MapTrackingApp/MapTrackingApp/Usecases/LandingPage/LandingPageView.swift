//
//  LandingPageView.swift
//  MapTrackingApp
//
//  Created by Raul Sulaimanov on 29.05.21.
//

import UIKit
import MapKit

class LandingPageView: UIView {
    lazy var mapView: MKMapView = {
        let view: MKMapView = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        return view
    }()

    lazy var userLocationButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 0.25, green: 0.50, blue: 0.43, alpha: 1.00)
        if let image = UIImage(named: "navigation") {
            button.setImage(image, for: .normal)
        }
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        userLocationButton.addTarget(self, action: #selector(userLocationButtonClicked), for: .touchUpInside)
        
        addSubview(mapView)
        addSubview(userLocationButton)
        
        //MARK: Layout
        mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        userLocationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        userLocationButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -190).isActive = true
        userLocationButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        userLocationButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    @objc func userLocationButtonClicked() {
        var center = CLLocationCoordinate2D(
            latitude: mapView.userLocation.coordinate.latitude,
            longitude: mapView.userLocation.coordinate.longitude
        )
        
        if center.latitude == 0.0 && center.longitude == 0.0 { // For Simulator testing purposes (relocalises on Alexanderplatz, Berlin, Germany)
            center = CLLocationCoordinate2D(
                latitude: 52.521473,
                longitude: 13.414363
            )
        }
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        print(center)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
