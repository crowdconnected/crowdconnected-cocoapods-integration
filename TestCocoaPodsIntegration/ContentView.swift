//
//  ContentView.swift
//  TestCocoaPodsIntegration
//
//  Created by Robert Tanase on 28/06/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("This is a Cocoapods integration test for the CrowdConnected SDK")
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
