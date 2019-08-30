//
//  ExtensionDelegate.swift
//  Quinn WatchKit Extension
//
//  Created by Michael Simpson on 8/14/19.
//  Copyright © 2019 Smart Commuter Incorporated. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    var extensionDelegateMood = "analytical"

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        print("applicationDidFinishLauncing() ran")
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive() ran")
        NotificationCenter.default.post(name: .updateHomeInterface2, object: nil)
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        print("handle() ran")
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                print("background task")
                if(quinnMood == 0){
                    extensionDelegateMood = "sad"
                }
                if(quinnMood == 1){
                    extensionDelegateMood = "happy"
                }
                if(quinnMood == 2){
                    extensionDelegateMood = "broken"
                }
                if(quinnMood == 3){
                    extensionDelegateMood = "analytical"
                }
                let NOW = Date().timeIntervalSince1970
                let refreshTime = Date(timeIntervalSince1970: NOW + Double(updateInterval))
                WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: refreshTime, userInfo: nil) { (error) in
                    if(error)==nil {
                        print("background refresh scheduled")
                    }
                }
                let server=CLKComplicationServer.sharedInstance()
                for comp in (server.activeComplications!) {
                    server.reloadTimeline(for: comp)
                }
                NotificationCenter.default.post(name: .updateHomeInterface2, object: nil)
                backgroundTask.setTaskCompletedWithSnapshot(true)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}
