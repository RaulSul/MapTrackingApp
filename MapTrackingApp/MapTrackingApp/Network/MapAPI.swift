//
//  MapAPI.swift
//  MapTrackingApp
//
//  Created by Raul Sulaimanov on 29.05.21.
//

import Foundation


class MapAPI {
    
    init() {
        
    }
    
    func fetchMapRequest(onSuccess: ((MapResults) -> Void)?, onError: ((Error?) -> Void)?)  {
        let string = "https://api.jsonbin.io/b/5fa8ff8dbd01877eecdb898f"
        let url = NSURL(string: string)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("$2b$10$VE0tRqquld4OBl7LDeo9v.afsyRXFlXcQzmj1KpEB6K1wG2okzQcK", forHTTPHeaderField: "secret-key")
        let session = URLSession.shared

        let mData = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            guard let jsonData = data else { return }
            
            if let decodedResponse = try? JSONDecoder().decode(MapResults.self, from: jsonData) {
                onSuccess?(decodedResponse)
            } else {
                print("Error: \(String(describing: error))")
                onError?(error)
            }
        }
        mData.resume()
    }
}
