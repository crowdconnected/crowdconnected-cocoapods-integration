//
//  TestCocoaPodsIntegrationApp.swift
//  TestCocoaPodsIntegration
//
//  Created by Robert Tanase on 28/06/2021.
//

import SwiftUI
import CrowdConnectedIPS
import CrowdConnectedCore
import CoreLocation

@main
struct TestCocoaPodsIntegrationApp: App {
    
    let locationsProvider = LocationsProvider()
    let locationManager = CLLocationManager()

    init() {
        CrowdConnectedIPS.activate()
        CrowdConnected.shared.start(appKey: "YOUR_APP_KEY", token: "YOUR_TOKEN", secret: "YOUR_SECRET") { deviceId, error in
            guard let id = deviceId else {
                // Check the error and make sure to start the library correctly
                return
            }

            // Library started successfully
        }
        
        CrowdConnected.shared.delegate = locationsProvider
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class LocationsProvider: CrowdConnectedDelegate {
    func didUpdateLocation(_ locations: [Location]) {
        // Use the location updates as you need
    }
}
