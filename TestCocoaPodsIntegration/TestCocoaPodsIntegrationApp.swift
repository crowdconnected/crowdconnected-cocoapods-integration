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
    let positionUpdater = PositionUpdater()

    init() {
        CrowdConnectedIPS.activate()
        CrowdConnectedCoreBluetooth.activate()
        CrowdConnectedGeo.activate()

        CrowdConnected.shared.start(appKey: "appkey", token: "iosuser", secret: "Ea80e182$") { deviceId, error in
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

class LocationsProvider: CrowdConnectedDelegate {
    func didUpdateLocation(_ locations: [Location]) {
        guard let location = locations.first else {
            print("📍 CrowdConnected SDK has triggered an update with no locations")
            return
        }
        print("📍 New location update from CrowdConnected SDK. (\(location.latitude),\(location.longitude))")

    }
}
