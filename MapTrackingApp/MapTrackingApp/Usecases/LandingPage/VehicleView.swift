import Foundation
import UIKit

class VehicleView: UIView {
    
    var onOkPressed: (() -> Void)?
    
    lazy var pictureImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        if let image: UIImage = UIImage(named: "scooter") {
            imageView.image = image
        }
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 16)
        label.text = "Vehicle #: "
        return label
    }()
    
    lazy var batteryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 16)
        label.text = "Battery: "
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 16)
        label.text = "Status: "
        return label
    }()
    
    lazy var okButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 0.25, green: 0.50, blue: 0.43, alpha: 1.00)
        button.setTitle("Ok", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        okButton.addTarget(self, action: #selector(okPressed), for: .touchUpInside)
        
        addSubview(pictureImageView)
        addSubview(titleLabel)
        addSubview(batteryLabel)
        addSubview(statusLabel)
        addSubview(okButton)
        
        // MARK: Layout
        pictureImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        pictureImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        pictureImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        batteryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        batteryLabel.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: 20).isActive = true
        batteryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        batteryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        statusLabel.topAnchor.constraint(equalTo: batteryLabel.bottomAnchor).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: 20).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        okButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        okButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 30).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    @objc func okPressed() {
        onOkPressed?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
