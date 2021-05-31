import Foundation

class LandingPageViewModel {
    
    var mapAPI: MapAPI
    var currentVehicles: [CurrentVehicle] = []
    
    init(mapAPI: MapAPI) {
        self.mapAPI = mapAPI
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
