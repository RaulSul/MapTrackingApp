//
//  LandingPageViewModel.swift
//  MapTrackingApp
//
//  Created by Raul Sulaimanov on 29.05.21.
//

import Foundation

class LandingPageViewModel {
    
    var mapAPI: MapAPI
    var currentVehicles: [CurrentVehicle] = []
    
    init(mapAPI: MapAPI) {
        self.mapAPI = mapAPI
        
//        downloadScooterLocations(onDownload: {
//            print(self.currentVehicles.count)
//        })
    }
    
    func downloadScooterLocations(onDownload: (() -> Void)?) {
        mapAPI.fetchMapRequest(
            onSuccess: { response in
                self.currentVehicles = response.data.current
                onDownload?()
            },
            onError: { error in
                if let errorMessage = error {
                    print(errorMessage)
                }
            }
        )
    }
    
    
}
