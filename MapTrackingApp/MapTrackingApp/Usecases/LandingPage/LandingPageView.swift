import UIKit
import MapKit

class LandingPageView: UIView {
    var onUserLocationButtonClicked: (() -> Void)?
    
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
        mapView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        userLocationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        userLocationButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -190).isActive = true
        userLocationButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        userLocationButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    @objc func userLocationButtonClicked() {
        onUserLocationButtonClicked?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
