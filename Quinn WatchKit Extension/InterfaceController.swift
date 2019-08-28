//
//  InterfaceController.swift
//  Quinn WatchKit Extension
//
//  Created by Mike Simpson on 6/24/19.
//  Copyright © 2019 Smart Commuter Incorporated. All rights reserved.
//

import WatchKit
import Foundation
import SQLite3

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
var impDay = "ANALYZING6"
var initialization = 0
var parameterUpdateTimer : Timer?
var requestCounselTimer : Timer?
var openingToggle = 0

class InterfaceController: WKInterfaceController {
    
    var db: OpaquePointer?
    var pointer: OpaquePointer?
    
    @IBOutlet weak var minTempLabel: WKInterfaceLabel!
    @IBOutlet weak var maxTempLabel: WKInterfaceLabel!
    @IBOutlet weak var zipCodeLabel: WKInterfaceLabel!
    @IBOutlet weak var timeInLabel: WKInterfaceLabel!
    @IBOutlet weak var timeBackLabel: WKInterfaceLabel!
    @IBOutlet weak var QuinnImage: WKInterfaceImage!
    @IBOutlet weak var Response: WKInterfaceLabel!
    @IBOutlet weak var rationale: WKInterfaceLabel!
    @IBOutlet weak var rainToleranceButtonYes: WKInterfaceGroup!
    @IBOutlet weak var rainToleranceButtonNo: WKInterfaceGroup!
    @IBOutlet weak var rainToleranceButtons: WKInterfaceGroup!
    @IBOutlet weak var nightRiderButtonYes: WKInterfaceGroup!
    @IBOutlet weak var nightRiderButtonNo: WKInterfaceGroup!
    @IBOutlet weak var nightRiderButtons: WKInterfaceGroup!
    @IBOutlet weak var settingsButton: WKInterfaceButton!
    
    //BUTTONS START
    
    @IBAction func minTempWarmer() {
        minTemp += 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func minTempCooler() {
        minTemp -= 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func maxTempWarmer() {
        maxTemp += 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func maxTempCooler() {
        maxTemp -= 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func rainToleranceYes(_ sender: Any) {
        rainTolerance = 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func rainToleranceNo(_ sender: Any) {
        rainTolerance = 0
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func nightRiderYes(_ sender: Any) {
        nightRider = 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func nightRiderNo(_ sender: Any) {
        nightRider = 0
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func key_0() {
        if(zipcode.count<5){
            zipcode += "0"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_1() {
        if(zipcode.count<5){
            zipcode += "1"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_2() {
        if(zipcode.count<5){
            zipcode += "2"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_3() {
        if(zipcode.count<5){
            zipcode += "3"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_4() {
        if(zipcode.count<5){
            zipcode += "4"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_5() {
        if(zipcode.count<5){
            zipcode += "5"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_6() {
        if(zipcode.count<5){
            zipcode += "6"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_7() {
        if(zipcode.count<5){
            zipcode += "7"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_8() {
        if(zipcode.count<5){
            zipcode += "8"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_9() {
        if(zipcode.count<5){
            zipcode += "9"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
        }
    }
    @IBAction func key_x(_ sender: Any) {
        zipcode = ""
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func timeInLater() {
        timeIn += 15
        if(timeIn % 100 == 60){
            timeIn += 40
        }
        if(timeIn == 2400){
            timeIn = 0;
        }
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func timeInEarlier() {
        timeIn -= 15
        if(timeIn % 100 == 85){
            timeIn -= 40
        }
        if(timeIn < 0){
            timeIn = 2345;
        }
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func timeBackLater() {
        timeBack += 15
        if(timeBack % 100 == 60){
            timeBack += 40
        }
        if(timeBack == 2400){
            timeBack = 0;
        }
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    @IBAction func timeBackEarlier() {
        timeBack -= 15
        if(timeBack % 100 == 85){
            timeBack -= 40
        }
        if(timeBack < 0){
            timeBack = 2345;
        }
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface, object: nil)
    }
    
    @IBAction func openSettings(_ sender: Any) {
        self.presentController(withNames: ["MinTempUI","MaxTempUI","RainToleranceUI","DarknessToleranceUI","ZipcodeUI","TimeInUI","TimeBackUI"], contexts: nil)
    }
    
    @IBAction func openSettings() {
        self.presentController(withNames: ["MinTempUI","MaxTempUI","RainToleranceUI","DarknessToleranceUI","ZipcodeUI","TimeInUI","TimeBackUI"], contexts: nil)
    }
    
    //BUTTONS END
    
    func parseTime(x: Int) -> String{
        var returnString = ""
        var suffix = ""
        if(x>=1200){
            suffix = "pm"
        } else {
            suffix = "am"
        }
        if(x>=1300){
            returnString=String(x-1200)
        } else {
            if(x<100){
                returnString=String(x+1200)
            } else {
                returnString=String(x)
            }
        }
        if(returnString.count<2){
            returnString="0"+returnString
        }
        if(returnString.count<3){
            returnString="0"+returnString
        }
        if(returnString.count<4){
            returnString="0"+returnString
        }
        returnString.insert(":", at: returnString.index(returnString.startIndex, offsetBy: 2))
        returnString+=suffix
        print(returnString)
        return returnString
    }
    
    func happy() {
        print("happy() ran")
        if QuinnImage != nil {
            QuinnImage.setImageNamed("HappyQuinn")
        }
    }
    func broken() {
        print("broken() ran")
        if QuinnImage != nil {
            QuinnImage.setImageNamed("BrokenQuinn")
        }
    }
    func sad() {
        print("sad() ran")
        if QuinnImage != nil {
            QuinnImage.setImageNamed("SadQuinn")
        }
    }
    func analytical() {
        print("analytical() ran")
        if QuinnImage != nil {
            QuinnImage.setImageNamed("AnalyticalQuinn")
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
    
    func drawInterface(){
        print("drawInterface() ran")
        if minTempLabel != nil {
            minTempLabel.setText(String(minTemp))
        }
        if maxTempLabel != nil {
            maxTempLabel.setText(String(maxTemp))
        }
        if rainToleranceButtons != nil {
            if(rainTolerance == 1){
                rainToleranceButtonYes.setBackgroundColor(UIColor.orange)
                rainToleranceButtonNo.setBackgroundColor(UIColor.darkGray)
            } else {
                rainToleranceButtonYes.setBackgroundColor(UIColor.darkGray)
                rainToleranceButtonNo.setBackgroundColor(UIColor.orange)
            }
        }
        if nightRiderButtons != nil {
            if(nightRider==1){
                nightRiderButtonYes.setBackgroundColor(UIColor.orange)
                nightRiderButtonNo.setBackgroundColor(UIColor.darkGray)
            } else {
                nightRiderButtonYes.setBackgroundColor(UIColor.darkGray)
                nightRiderButtonNo.setBackgroundColor(UIColor.orange)
            }
        }
        if zipCodeLabel != nil {
            zipCodeLabel.setText(String(zipcode))
        }
        if timeInLabel != nil {
            timeInLabel.setText(parseTime(x: timeIn))
        }
        if timeBackLabel != nil {
            timeBackLabel.setText(parseTime(x: timeBack))
        }
        if(quinnMood == 0){
            sad()
        }
        if(quinnMood == 1){
            happy()
        }
        if(quinnMood == 2){
            broken()
        }
        if(quinnMood == 3){
            analytical()
        }
        if Response != nil {
            Response.setText(impDay)
        }
        if rationale != nil {
            rationale.setText(quinnRationale)
            if(quinnRationale.count>0){
                self.rationale.setRelativeHeight(0.1,withAdjustment: 0)
                self.QuinnImage.setRelativeHeight(0.61,withAdjustment: 0)
                self.settingsButton.setRelativeHeight(0.15,withAdjustment: 0)
            } else {
                self.rationale.setRelativeHeight(0,withAdjustment: 0)
                self.QuinnImage.setRelativeHeight(0.66,withAdjustment: 0)
                self.settingsButton.setRelativeHeight(0.2,withAdjustment: 0)
            }
        }
    }
    
    @objc func clearSetParameters(){
        print("clearSetParameters() ran");
        clearTable()
        let query = "INSERT INTO parameters ('minTemp','maxTemp','rainTolerance','nightRider','zipcode','timeIn','timeBack') VALUES ("+String(minTemp)+","+String(maxTemp)+","+String(rainTolerance)+","+String(nightRider)+","+zipcode+","+String(timeIn)+","+String(timeBack)+")"
        if sqlite3_prepare(db, query, -1, &pointer, nil) != SQLITE_OK{
            print("Error Binding Query")
        }
        if sqlite3_step(pointer) == SQLITE_DONE {
            print("We've written to the table!")
        }
    }
    
    @objc func updateHomeInterface(_ notification:Notification) {
        print("updateHomeInterface() ran");
        quinnMood=3
        self.drawInterface()
        parameterUpdateTimer?.invalidate()
        parameterUpdateTimer = nil
        parameterUpdateTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(clearSetParameters), userInfo: nil, repeats: false)
        requestCounselTimer?.invalidate()
        requestCounselTimer = nil
        requestCounselTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(requestCounsel), userInfo: nil, repeats: false)
    }
    
    @objc func requestCounselAppOpen(_ notification:Notification) {
        print("requestCounselAppOpen() ran")
        requestCounsel()
    }
    
    @objc func requestCounsel(){
        print("requestCounsel() ran")
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = NSURLRequest.CachePolicy(rawValue: 1)!
        let session = URLSession.init(configuration: sessionConfig)
        let url = URL(string: "https://www.michaelsimpsondesign.com/sketches/services/quinn.php?minTemp="+String(minTemp)+"&maxTemp="+String(maxTemp)+"&rainTolerance="+String(rainTolerance)+"&nightRider="+String(nightRider)+"&zipcode="+zipcode+"&timeIn="+String(timeIn)+"&timeOut="+String(timeBack)+"&parameterUpdate=0&maintenance=0")!
        print(url)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                    do {
                        if let bingo = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let mood = bingo["Counsel"] as? String {
                                print(mood)
                                quinnMood = Int(mood) ?? 0
                            }
                            if let day = bingo["AnalyzedDay"] as? String {
                                print(day)
                                impDay = day.uppercased()
                            }
                            if let rationaleTxt = bingo["Rationale"] as? String {
                                print(rationaleTxt)
                                quinnRationale = rationaleTxt.uppercased()
                            }
                            self.drawInterface()
                        }
                    } catch {
                        self.Response.setText("FAIL")
                    }
                }
            }
        }
        task.resume()
    }
    
    override func awake(withContext context: Any?) {
        print("awake() ran")
        super.awake(withContext: context)
        if Response == nil {
            self.setTitle("Done")
        }
        if(initialization == 0){
            //Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(requestCounsel), userInfo: nil, repeats: true)
            NotificationCenter.default.addObserver(self, selector: #selector(updateHomeInterface(_:)), name: .updateHomeInterface, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(requestCounselAppOpen(_:)), name: .requestCounselAppOpen, object: nil)
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
            //Simulate FTUE
            //clearTable()
            setClientSideVariables()
            initialization=1
        }
        let NOW = Date().timeIntervalSince1970
        let refreshTime = Date(timeIntervalSince1970: NOW + 60)
        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: refreshTime, userInfo: nil) { (error) in
            if(error)==nil {
                print("background refresh scheduled")
            }
        }
        drawInterface()
    }
    
}

extension Notification.Name {
    static let updateHomeInterface = Notification.Name("updateHomeInterface")
    static let requestCounselAppOpen = Notification.Name("requestCounselAppOpen")
}
