//
//  TestCocoaPodsIntegrationApp.swift
//  TestCocoaPodsIntegration
//
//  Created by Robert Tanase on 28/06/2021.
//

import SwiftUI
import CrowdConnectedCore
import CrowdConnectedIPS
import CrowdConnectedShared
import CrowdConnectedGeo
import CrowdConnectedCoreBluetooth
import CoreLocation

@main
struct TestCocoaPodsIntegrationApp: App {
    
    let manager = CLLocationManager()
    let positionUpdater = LocationsProvider()

    init() {
        CrowdConnectedIPS.activate()
        CrowdConnectedCoreBluetooth.activate()
        CrowdConnectedGeo.activate()

        CrowdConnected.shared.start(appKey: "DgHLHQnk", token: "35df4a7e4dfb4b6aaa0bc881e5151362", secret: "Y6896N775lLh3cPaT4TE7L9G3o68lp28") { deviceId, error in
            if let errorMessage = error {
                print("⚠️ CrowdConnected SDK has failed to start. Error: \(errorMessage)")
                return
            }
            if let deviceId = deviceId {
                print("✅ CrowdConnected SDK has started with device ID \(deviceId)")
                return
            }
            print("❌ CrowdConnected SDK failed to start. Invalid callback as no error and no device ID were provided.")
        }

        CrowdConnected.shared.delegate = positionUpdater
        CrowdConnected.shared.setAlias(key: "", value: "")
        CrowdConnected.shared.activateSDKBackgroundRefresh()
        CrowdConnected.shared.scheduleRefresh()

        manager.requestWhenInUseAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

final class LocationsProvider: CrowdConnectedDelegate {
    func didUpdateLocation(_ locations: [Location]) {
        guard let location = locations.first else {
            print("📍 CrowdConnected SDK has triggered an update with no locations")
            return
        }
        print("📍 New location update from CrowdConnected SDK. (\(location.latitude),\(location.longitude)) quality \(location.quality)")
    }
}
