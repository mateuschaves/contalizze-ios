import Foundation
import SwiftUI
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import Sentry

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // App Center SDK
        AppCenter.start(withAppSecret: "{Your app secret here}", services:[
          Analytics.self,
          Crashes.self
        ])
        
        // Sentry SDK
        SentrySDK.start { options in
            options.dsn = ""
            options.attachViewHierarchy = true
            options.enablePreWarmedAppStartTracing = true
            options.enableMetricKit = true
            options.enableTimeToFullDisplayTracing = true
            options.swiftAsyncStacktraces = true
            
            options.tracesSampleRate = 1.0
        }
        return true
    }
}
