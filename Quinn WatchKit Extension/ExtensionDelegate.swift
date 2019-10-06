//
//  ExtensionDelegate.swift
//  Quinn WatchKit Extension
//
//  Created by Michael Simpson on 8/14/19.
//  Copyright © 2019 Smart Commuter Incorporated. All rights reserved.
//

import WatchKit
import SQLite3

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    var minTemp = 40
    var maxTemp = 110
    var rainTolerance = 1
    var nightRider = 1
    var zipcode = "75039"
    var timeIn = 730
    var timeBack = 1815
    var timeInDisplay = ""
    var timeBackDisplay = ""
    var currentLocation = ""
    var quinnMood = 3
    var quinnRationale = ""
    var impDay = "ANALYZING"
    var initialization = 0
    var updateInterval = 20
    var db: OpaquePointer?
    var pointer: OpaquePointer?

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        // App Open
        NotificationCenter.default.post(name: .updateHomeInterface2, object: nil)
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
        // App Close
        let server=CLKComplicationServer.sharedInstance()
        for comp in (server.activeComplications!) {
            server.reloadTimeline(for: comp)
        }
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                let NOW = Date().timeIntervalSince1970
                let refreshTime = Date(timeIntervalSince1970: NOW + Double(updateInterval))
                WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: refreshTime, userInfo: nil) { (error) in
                    if(error)==nil {
                        print("background refresh scheduled")
                    }
                }
                let sessionConfig = URLSessionConfiguration.default
                sessionConfig.requestCachePolicy = NSURLRequest.CachePolicy(rawValue: 1)!
                let session = URLSession.init(configuration: sessionConfig)
                self.connectDatabase()
                self.setClientSideVariables()
                let url = URL(string: "https://www.michaelsimpson.io/sketches/services/quinn.php?minTemp="+String(minTemp)+"&maxTemp="+String(maxTemp)+"&rainTolerance="+String(rainTolerance)+"&nightRider="+String(nightRider)+"&zipcode="+zipcode+"&timeIn="+String(timeIn)+"&timeOut="+String(timeBack)+"&parameterUpdate=0&maintenance=0")!
                let task = session.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("error:")
                        print(error)
                    } else {
                        if let response = response as? HTTPURLResponse {
                            print("statusCode:")
                            print(response.statusCode)
                        }
                        if let data = data, let dataString = String(data: data, encoding: .utf8) {
                            print("data: ")
                            print(dataString)
                            do {
                                if let microserviceResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                    if let mood = microserviceResponse["Counsel"] as? String {
                                        self.quinnMood = Int(mood) ?? 2
                                    }
                                    if let day = microserviceResponse["AnalyzedDay"] as? String {
                                        self.impDay = day.uppercased()
                                    }
                                }
                                NotificationCenter.default.post(name: .updateHomeInterface2, object: nil)
                                let server=CLKComplicationServer.sharedInstance()
                                for comp in (server.activeComplications!) {
                                    server.reloadTimeline(for: comp)
                                }
                                backgroundTask.setTaskCompletedWithSnapshot(true)
                            } catch {
                                let server=CLKComplicationServer.sharedInstance()
                                for comp in (server.activeComplications!) {
                                    server.reloadTimeline(for: comp)
                                }
                                backgroundTask.setTaskCompletedWithSnapshot(true)
                            }
                        }
                    }
                }
                task.resume()
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
    
    //SQLITE CODE START
    
    func connectDatabase() {
        print("Connecting To Database...")
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("test.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        if sqlite3_exec(db, "CREATE TABLE if not exists parameters (id integer primary key autoincrement, minTemp integer, maxTemp integer, rainTolerance integer, nightRider integer, zipcode text, timeIn integer, timeBack integer)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        print("Connected To Database")
    }
    
    @objc func clearSetParameters(){
        clearTable()
        let query = "INSERT INTO parameters ('minTemp','maxTemp','rainTolerance','nightRider','zipcode','timeIn','timeBack') VALUES ("+String(minTemp)+","+String(maxTemp)+","+String(rainTolerance)+","+String(nightRider)+","+zipcode+","+String(timeIn)+","+String(timeBack)+")"
        if sqlite3_prepare(db, query, -1, &pointer, nil) != SQLITE_OK{
            print("Error Binding Query")
        }
        if sqlite3_step(pointer) == SQLITE_DONE {
            print("We've written to the table!")
        }
    }
    
    func setClientSideVariables(){
        let query = "SELECT * FROM parameters"
        if sqlite3_prepare(db,query,-1,&pointer,nil) == SQLITE_OK {
            while sqlite3_step(pointer) == SQLITE_ROW {
                //let rowID = sqlite3_column_int(pointer, 0)
                minTemp = Int(sqlite3_column_int(pointer, 1))
                maxTemp = Int(sqlite3_column_int(pointer, 2))
                rainTolerance = Int(sqlite3_column_int(pointer, 3))
                nightRider = Int(sqlite3_column_int(pointer, 4))
                zipcode = String(cString: sqlite3_column_text(pointer, 5))
                timeIn = Int(sqlite3_column_int(pointer, 6))
                timeBack = Int(sqlite3_column_int(pointer, 7))
            }
        }
    }
    
    func clearTable(){
        let query = "DELETE FROM parameters"
        if sqlite3_prepare(db, query, -1, &pointer, nil) != SQLITE_OK{
            print("Error Binding Query")
        }
        if sqlite3_step(pointer) == SQLITE_DONE {
            print("We've cleared the table!")
        }
    }
    
    //SQLITE CODE END

}
