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
        CrowdConnected.shared.start(appKey: "testKey", token: "iosuser", secret: "Ea80e182$") { deviceId, error in
            if let deviceId = deviceId {
                print("Device id \(deviceId)")
            }
            if let error = error {
                print("Error \(error)")
            }
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
        print("Got locations \(locations)")
    }
}
