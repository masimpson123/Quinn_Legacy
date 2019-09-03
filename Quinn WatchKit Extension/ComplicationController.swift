//
//  ComplicationController.swift
//  QuinnMaster WatchKit Extension
//
//  Created by Michael Simpson on 8/11/19.
//  Copyright © 2019 Michael Simpson. All rights reserved.
//

import ClockKit
import WatchKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        let exDel = WKExtension.shared().delegate as! ExtensionDelegate
        switch complication.family {
        case .modularSmall:
            handler(nil)
        case .modularLarge:
            handler(nil)
        case .utilitarianSmall:
            handler(nil)
        case .utilitarianSmallFlat:
            handler(nil)
        case .utilitarianLarge:
            handler(nil)
        case .circularSmall:
            handler(nil)
        case .extraLarge:
            handler(nil)
        case .graphicCorner:
            handler(nil)
        case .graphicBezel:
            let graphicCircularTemplate = CLKComplicationTemplateGraphicCircularImage()
            if(exDel.quinnMood == 0){
                graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "sadQuinnComplication")!)
            }
            if(exDel.quinnMood == 1){
                graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "happyQuinnComplication")!)
            }
            if(exDel.quinnMood == 2){
                graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "brokenQuinnComplication")!)
            }
            if(exDel.quinnMood == 3){
                graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "analyticalQuinnComplication")!)
            }
            let template = CLKComplicationTemplateGraphicBezelCircularText()
            template.circularTemplate = graphicCircularTemplate
            var analyzedDayBezel = ""
            let now = Date().timeIntervalSince1970
            let date = Date(timeIntervalSince1970: now)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E MMM dd"
            let formattedToday = dateFormatter.string(from: date)
            if (exDel.impDay == formattedToday.uppercased()) {
                analyzedDayBezel = "TODAY"
            } else {
                analyzedDayBezel = "TOMORROW"
            }
            template.textProvider = CLKSimpleTextProvider.init(text: analyzedDayBezel)
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularImage()
            if(exDel.quinnMood == 0){
                template.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "sadQuinnComplication")!)
            }
            if(exDel.quinnMood == 1){
                template.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "happyQuinnComplication")!)
            }
            if(exDel.quinnMood == 2){
                template.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "brokenQuinnComplication")!)
            }
            if(exDel.quinnMood == 3){
                template.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "analyticalQuinnComplication")!)
            }
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .graphicRectangular:
            handler(nil)
        @unknown default:
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        var template: CLKComplicationTemplate?
        switch complication.family {
        case .modularSmall:
            template = nil
        case .modularLarge:
            template = nil
        case .utilitarianSmall:
            template = nil
        case .utilitarianSmallFlat:
            template = nil
        case .utilitarianLarge:
            template = nil
        case .circularSmall:
            template = nil
        case .extraLarge:
            template = nil
        case .graphicCorner:
            template = nil
        case .graphicBezel:
            let graphicCircularTemplate = CLKComplicationTemplateGraphicCircularImage()
            graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "analyticalQuinnComplication")!)
            let graphicBezelTemplate = CLKComplicationTemplateGraphicBezelCircularText()
            graphicBezelTemplate.circularTemplate = graphicCircularTemplate
            graphicBezelTemplate.textProvider = CLKSimpleTextProvider.init(text: "ANALYZING")
            template = graphicBezelTemplate
        case .graphicCircular:
            let graphicCircularTemplate = CLKComplicationTemplateGraphicCircularImage()
            graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "analyticalQuinnComplication")!)
            template = graphicCircularTemplate
        case .graphicRectangular:
            template = nil
        @unknown default:
            template = nil
        }
        handler(template)
    }
    
}
