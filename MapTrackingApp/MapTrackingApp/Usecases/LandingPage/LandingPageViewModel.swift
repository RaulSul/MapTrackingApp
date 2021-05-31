import Foundation

class LandingPageViewModel {
    
    var mapAPI: MapAPI
    var currentVehicles: [CurrentVehicle] = []
    var numberOfRetries: Int = 0
    
    init(mapAPI: MapAPI) {
        self.mapAPI = mapAPI
    }
    
    func downloadScooterLocations(onDownload: (() -> Void)?, onDownloadFail: (() -> Void)?) {
        mapAPI.fetchMapRequest(
            onSuccess: { response in
                self.currentVehicles = response.data.current
                onDownload?()
            },
            onError: { _ in
                if self.numberOfRetries < 10 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.numberOfRetries += 1
                        self.downloadScooterLocations(onDownload: onDownload, onDownloadFail: onDownloadFail)
                    }
                } else {
                    print(">>> Unable to download Scooter Locations...")
                    onDownloadFail?()
                }
                
            }
        )
    }
    
    
}
