//
//  InterfaceController.swift
//  Quinn WatchKit Extension
//
//  Created by Mike Simpson on 6/24/19.
//  Copyright © 2019 Smart Commuter Incorporated. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    let exDel = WKExtension.shared().delegate as! ExtensionDelegate
    var parameterUpdateTimer : Timer?
    var requestCounselTimer : Timer?
    
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
        exDel.minTemp += 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func minTempCooler() {
        exDel.minTemp -= 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func maxTempWarmer() {
        exDel.maxTemp += 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func maxTempCooler() {
        exDel.maxTemp -= 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func rainToleranceYes(_ sender: Any) {
        exDel.rainTolerance = 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func rainToleranceNo(_ sender: Any) {
        exDel.rainTolerance = 0
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func nightRiderYes(_ sender: Any) {
        exDel.nightRider = 1
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func nightRiderNo(_ sender: Any) {
        exDel.nightRider = 0
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func key_0() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "0"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_1() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "1"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_2() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "2"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_3() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "3"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_4() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "4"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_5() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "5"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_6() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "6"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_7() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "7"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_8() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "8"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_9() {
        if(exDel.zipcode.count<5){
            exDel.zipcode += "9"
            drawInterface()
            NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
        }
    }
    @IBAction func key_x(_ sender: Any) {
        exDel.zipcode = ""
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func timeInLater() {
        exDel.timeIn += 15
        if(exDel.timeIn % 100 == 60){
            exDel.timeIn += 40
        }
        if(exDel.timeIn == 2400){
            exDel.timeIn = 0;
        }
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func timeInEarlier() {
        exDel.timeIn -= 15
        if(exDel.timeIn % 100 == 85){
            exDel.timeIn -= 40
        }
        if(exDel.timeIn < 0){
            exDel.timeIn = 2345;
        }
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func timeBackLater() {
        exDel.timeBack += 15
        if(exDel.timeBack % 100 == 60){
            exDel.timeBack += 40
        }
        if(exDel.timeBack == 2400){
            exDel.timeBack = 0;
        }
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
    }
    @IBAction func timeBackEarlier() {
        exDel.timeBack -= 15
        if(exDel.timeBack % 100 == 85){
            exDel.timeBack -= 40
        }
        if(exDel.timeBack < 0){
            exDel.timeBack = 2345;
        }
        drawInterface()
        NotificationCenter.default.post(name: .updateHomeInterface1, object: nil)
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
        return returnString
    }
    
    func drawInterface(){
        if minTempLabel != nil {
            minTempLabel.setText(String(exDel.minTemp))
        }
        if maxTempLabel != nil {
            maxTempLabel.setText(String(exDel.maxTemp))
        }
        if rainToleranceButtons != nil {
            if(exDel.rainTolerance == 1){
                rainToleranceButtonYes.setBackgroundColor(UIColor.orange)
                rainToleranceButtonNo.setBackgroundColor(UIColor.darkGray)
            } else {
                rainToleranceButtonYes.setBackgroundColor(UIColor.darkGray)
                rainToleranceButtonNo.setBackgroundColor(UIColor.orange)
            }
        }
        if nightRiderButtons != nil {
            if(exDel.nightRider==1){
                nightRiderButtonYes.setBackgroundColor(UIColor.orange)
                nightRiderButtonNo.setBackgroundColor(UIColor.darkGray)
            } else {
                nightRiderButtonYes.setBackgroundColor(UIColor.darkGray)
                nightRiderButtonNo.setBackgroundColor(UIColor.orange)
            }
        }
        if zipCodeLabel != nil {
            zipCodeLabel.setText(String(exDel.zipcode))
        }
        if timeInLabel != nil {
            timeInLabel.setText(parseTime(x: exDel.timeIn))
        }
        if timeBackLabel != nil {
            timeBackLabel.setText(parseTime(x: exDel.timeBack))
        }
        if QuinnImage != nil {
            if(exDel.quinnMood == 0){
                QuinnImage.setImageNamed("SadQuinn")
            }
            if(exDel.quinnMood == 1){
                QuinnImage.setImageNamed("HappyQuinn")
            }
            if(exDel.quinnMood == 2){
                QuinnImage.setImageNamed("BrokenQuinn")
            }
            if(exDel.quinnMood == 3){
                QuinnImage.setImageNamed("AnalyticalQuinn")
            }
        }
        if Response != nil {
            Response.setText(exDel.impDay)
        }
        if rationale != nil {
            rationale.setText(exDel.quinnRationale)
            if(exDel.quinnRationale.count>0){
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
    
    @objc func updateHomeInterface1(_ notification:Notification) {
        exDel.quinnMood=3
        self.drawInterface()
        parameterUpdateTimer?.invalidate()
        parameterUpdateTimer = nil
        parameterUpdateTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(updateHomeInterface1_helper), userInfo: nil, repeats: false)
        requestCounselTimer?.invalidate()
        requestCounselTimer = nil
        requestCounselTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(requestCounsel), userInfo: nil, repeats: false)
    }
    
    @objc func updateHomeInterface1_helper() {
        exDel.clearSetParameters()
    }
    
    @objc func updateHomeInterface2(_ notification:Notification) {
        self.drawInterface()
        self.requestCounsel()
    }
    
    @objc func requestCounsel(){
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = NSURLRequest.CachePolicy(rawValue: 1)!
        let session = URLSession.init(configuration: sessionConfig)
        let url = URL(string: "https://www.michaelsimpsondesign.com/sketches/services/quinn.php?minTemp="+String(exDel.minTemp)+"&maxTemp="+String(exDel.maxTemp)+"&rainTolerance="+String(exDel.rainTolerance)+"&nightRider="+String(exDel.nightRider)+"&zipcode="+exDel.zipcode+"&timeIn="+String(exDel.timeIn)+"&timeOut="+String(exDel.timeBack)+"&parameterUpdate=0&maintenance=0")!
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: ")
                print(error)
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: ")
                    print(response.statusCode)
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: ")
                    print(dataString)
                    do {
                        if let microserviceResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let mood = microserviceResponse["Counsel"] as? String {
                                self.exDel.quinnMood = Int(mood) ?? 2
                            }
                            if let day = microserviceResponse["AnalyzedDay"] as? String {
                                self.exDel.impDay = day.uppercased()
                            }
                            if let rationaleTxt = microserviceResponse["Rationale"] as? String {
                                self.exDel.quinnRationale = rationaleTxt.uppercased()
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
    
    override func willActivate() {
        //called during every background refresh
        scheduleBackgroundRefresh()
        addRemoveNotificationObservers()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if Response == nil {
            self.setTitle("Done")
        }
        if(exDel.initialization == 0){
            scheduleBackgroundRefresh()
            addRemoveNotificationObservers()
            exDel.connectDatabase()
            exDel.setClientSideVariables()
            exDel.initialization=1
        }
        drawInterface()
    }
    
    func addRemoveNotificationObservers() {
        if Response != nil {
            NotificationCenter.default.removeObserver(self, name: Notification.Name.updateHomeInterface1, object: nil)
            NotificationCenter.default.removeObserver(self, name: Notification.Name.updateHomeInterface2, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(updateHomeInterface1(_:)), name: .updateHomeInterface1, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(updateHomeInterface2(_:)), name: .updateHomeInterface2, object: nil)
        }
    }

    func scheduleBackgroundRefresh() {
        if Response != nil {
            let NOW = Date().timeIntervalSince1970
            let refreshTime = Date(timeIntervalSince1970: NOW + Double(exDel.updateInterval))
            WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: refreshTime, userInfo: nil) { (error) in
                if(error)==nil {
                    print("background refresh scheduled")
                }
            }
        }
    }
    
}

extension Notification.Name {
    static let updateHomeInterface1 = Notification.Name("updateHomeInterface1")
    static let updateHomeInterface2 = Notification.Name("updateHomeInterface2")
}
