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
        print("getSupportedTimeTravelDirections()")
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        print("getTimelineStartDate()")
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        print("getTimelineEndDate()")
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        print("getPrivacyBehavior()")
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        print("getCurrentTimelineEntry()")
        // Call the handler with the current timeline entry
        let extensionDelegateVariables = WKExtension.shared().delegate as! ExtensionDelegate
        let complicationMood = extensionDelegateVariables.extensionDelegateMood
        switch complication.family {
        case .modularSmall:
            /*
             let template = CLKComplicationTemplateModularSmallStackText()
             template.line1TextProvider = CLKSimpleTextProvider(text: "Modular")
             template.line2TextProvider = CLKSimpleTextProvider(text: "Small")
             let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
             handler(entry)
             */
            handler(nil)
        case .modularLarge:
            /*
             let template = CLKComplicationTemplateModularLargeStandardBody()
             template.headerTextProvider = CLKSimpleTextProvider(text: "Modular")
             template.body1TextProvider = CLKSimpleTextProvider.init(text: "Large")
             template.body2TextProvider = CLKSimpleTextProvider.init(text: "Quinn")
             let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
             handler(entry)
             */
            handler(nil)
        case .utilitarianSmall:
            /*
             let template = CLKComplicationTemplateUtilitarianSmallFlat()
             template.textProvider = CLKSimpleTextProvider(text: "Tod 😀")
             let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
             handler(entry)
             */
            handler(nil)
        case .utilitarianSmallFlat:
            /*
             let template = CLKComplicationTemplateUtilitarianSmallFlat()
             template.textProvider = CLKSimpleTextProvider.init(text: "Tom 😀")
             let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
             handler(entry)
             */
            handler(nil)
        case .utilitarianLarge:
            /*
             let template = CLKComplicationTemplateUtilitarianLargeFlat()
             template.textProvider = CLKSimpleTextProvider.init(text: "Tomorrow 😀")
             let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
             handler(entry)
             */
            handler(nil)
        case .circularSmall:
            /*
             let template = CLKComplicationTemplateCircularSmallSimpleImage()
             if(quinnsMood == "happy") {
             template.imageProvider = CLKImageProvider.init(onePieceImage: UIImage(named: "happyIcon")!)
             }
             if(quinnsMood == "sad") {
             template.imageProvider = CLKImageProvider.init(onePieceImage: UIImage(named: "sadIcon")!)
             }
             if(quinnsMood == "analytical") {
             template.imageProvider = CLKImageProvider.init(onePieceImage: UIImage(named: "analyticalIcon")!)
             }
             if(quinnsMood == "broken") {
             template.imageProvider = CLKImageProvider.init(onePieceImage: UIImage(named: "brokenIcon")!)
             }
             let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
             handler(entry)
             */
            handler(nil)
        case .extraLarge:
            /*
             let template = CLKComplicationTemplateExtraLargeSimpleImage()
             if(quinnsMood == "happy") {
             template.imageProvider = CLKImageProvider.init(onePieceImage: UIImage(named: "happyXL")!, twoPieceImageBackground: UIImage(named: "happyXL")!, twoPieceImageForeground: UIImage(named: "test")!)
             }
             if(quinnsMood == "sad") {
             template.imageProvider = CLKImageProvider.init(onePieceImage: UIImage(named: "sadXL")!)
             }
             if(quinnsMood == "analytical") {
             template.imageProvider = CLKImageProvider.init(onePieceImage: UIImage(named: "analyticalXL")!)
             }
             if(quinnsMood == "broken") {
             template.imageProvider = CLKImageProvider.init(onePieceImage: UIImage(named: "brokenXL")!)
             }
             let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
             handler(entry)
             */
            handler(nil)
        case .graphicCorner:
            /*
             let template = CLKComplicationTemplateGraphicCornerStackText()
             template.outerTextProvider = CLKSimpleTextProvider.init(text: "Today")
             template.innerTextProvider = CLKSimpleTextProvider.init(text: "😀")
             let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
             handler(entry)
             */
            handler(nil)
        case .graphicBezel:
            let graphicCircularTemplate = CLKComplicationTemplateGraphicCircularImage()
            if(complicationMood == "happy") {
            graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "happyQuinnComplication")!)
            }
            if(complicationMood == "sad") {
            graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "sadQuinnComplication")!)
            }
            if(complicationMood == "analytical") {
            graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "analyticalQuinnComplication")!)
            }
            if(complicationMood == "broken") {
            graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "brokenQuinnComplication")!)
            }
            let template = CLKComplicationTemplateGraphicBezelCircularText()
            template.circularTemplate = graphicCircularTemplate
            template.textProvider = CLKSimpleTextProvider.init(text: String(maxTemp))
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularImage()
            if(complicationMood == "happy") {
                template.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "happyQuinnComplication")!)
            }
            if(complicationMood == "sad") {
                template.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "sadQuinnComplication")!)
            }
            if(complicationMood == "analytical") {
                template.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "analyticalQuinnComplication")!)
            }
            if(complicationMood == "broken") {
                template.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "brokenQuinnComplication")!)
            }
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        case .graphicRectangular:
            /*
             let template = CLKComplicationTemplateGraphicRectangularStandardBody()
             template.headerTextProvider = CLKSimpleTextProvider.init(text: "Tomorrow:")
             template.body1TextProvider = CLKSimpleTextProvider.init(text: "Great Weather!")
             template.body2TextProvider = CLKSimpleTextProvider.init(text: "😀")
             let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
             handler(entry)
             */
            handler(nil)
        @unknown default:
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        print("getTimelineEntries()")
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        print("getTimelineEntries()")
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        var template: CLKComplicationTemplate?
        switch complication.family {
        case .modularSmall:
            print("Modular Small")
            template = nil
        case .modularLarge:
            print("Modular Large")
            template = nil
        case .utilitarianSmall:
            print("Utilitarian Small")
            template = nil
        case .utilitarianSmallFlat:
            print("Utilitarian Small Flat")
            template = nil
        case .utilitarianLarge:
            print("Utilitarian Large")
            template = nil
        case .circularSmall:
            print("Circular Small")
            template = nil
        case .extraLarge:
            print("Extra Large")
            template = nil
        case .graphicCorner:
            print("Graphic Corner")
            template = nil
        case .graphicBezel:
            print("Graphic Bezel")
            let graphicCircularTemplate = CLKComplicationTemplateGraphicCircularImage()
            graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "analyticalQuinnComplication")!)
            let graphicBezelTemplate = CLKComplicationTemplateGraphicBezelCircularText()
            graphicBezelTemplate.circularTemplate = graphicCircularTemplate
            graphicBezelTemplate.textProvider = CLKSimpleTextProvider.init(text: String(maxTemp))
            template = graphicBezelTemplate
        case .graphicCircular:
            print("Graphic Circular")
            let graphicCircularTemplate = CLKComplicationTemplateGraphicCircularImage()
            graphicCircularTemplate.imageProvider = CLKFullColorImageProvider.init(fullColorImage: UIImage(named: "analyticalQuinnComplication")!)
            template = graphicCircularTemplate
        case .graphicRectangular:
            print("Graphic Rectangular")
            template = nil
        @unknown default:
            template = nil
        }
        print("getPlaceholderTemplate()")
        handler(template)
    }
    
}
