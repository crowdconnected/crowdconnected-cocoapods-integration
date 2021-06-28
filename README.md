## How to implement the CrowdConnectedSDK using CocoaPods

### Add pods
Add the following dependencies to your `Podfile`: 
```
pod 'CrowdConnectedIPS'
pod 'CrowdConnectedCore'
```

### Set up framework imports
Open the project configuration settings and navigate to the `Build Settings` tab for your main target.
Search for `Import Paths` and add the following non-recursive values:
```
$(SRCROOT)/Pods/CrowdConnectedCore/CrowdConnectedCore.xcframework/ios-x86_64-simulator
$(SRCROOT)/Pods/CrowdConnectedCore/CrowdConnectedCore.xcframework/ios-arm64
$(SRCROOT)/Pods/CrowdConnectedIPS/CrowdConnectedIPS.xcframework/ios-x86_64-simulator
$(SRCROOT)/Pods/CrowdConnectedIPS/CrowdConnectedIPS.xcframework/ios-arm64
```

### Consume the library
In your `AppDelegate` file or the main `App` file (for SwiftUI Apps) import the follwoing libraries:
```
import CrowdConnectedIPS
import CrowdConnectedCore
```

In your `application(_:didFinishLaunchingWithOptions:)` method (for UIKit apps) or `init()` method (for SwiftUI apps) add the following:
```
CrowdConnectedIPS.activate()
CrowdConnected.shared.start(appKey: "YOUR_APP_KEY", token: "YOUR_TOKEN", secret: "YOUR_SECRET") { deviceId, error in
   // Your code here ...
}
```
