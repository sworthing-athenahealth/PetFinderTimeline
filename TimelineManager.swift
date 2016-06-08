//
//  TimelineManager.swift
//  PetFinderTimeline
//
//  Created by alvarezblue on 6/7/16.
//  Copyright © 2016 Sarah Worthing. All rights reserved.
//

import UIKit

// HARDCODED CONSTANTS
// these would likely be read from a manager that
// knew your pet names (in case of multiple), feed amounts, etc
let kPetName = "Little Smalls"
let kFeedCalories = 229.5
let kNumberOfDays = 3


class TimelineManager: NSObject {
    
    var timeline: [TimelineEntry?] = []
    
    
    override init() {
        super.init()
        
        timeline = TimelineManager.generateTimeline()
    }
    
    func numberOfDaysInTimeline() -> Int {
        return kNumberOfDays
    }
    
    func timelineHeaderForSection(section day:Int) -> String {
        switch day {
        case 0:
            return "TODAY"
        case 1:
            return "YESTERDAY"
        case 2:
            return "MONDAY"
        default:
            return ""
        }
    }

    
    func numberOfEntriesForDay(section day:Int) -> Int {
        
        switch day {
            case 1:
                return 3
            default:
                return 2
        }
    }
    
    func timelineEntry(forIndex index: NSIndexPath) -> TimelineEntry? {
     
        var modifer = 0
        
        switch index.section {
        case 1:
            modifer = 2
        case 2:
            modifer = 5
        default:
            break
        }
        
        guard let timelineEntry = timeline[index.row + modifer] else {
            print("No entry for \(index.section + modifer)")
            return nil
        }
        
        return timelineEntry
    }
    
    // HARDCODED DATA GENERATORS
    class func generateTimeline() -> [TimelineEntry?] {
        
        var timeline: [TimelineEntry?] = []
        
        // HARDCODED DATA
        let firstEntry = TimelineEntry(status: .Success, event: .Breakfast, description: generateRandomDescription("2/3", time: "6:30 am", day: "today"))
        let secondEntry = TimelineEntry(status: .Success, event: .Lunch, description: generateRandomDescription("2/3", time: "1:47 pm", day: "today"))
        let thirdEntry = TimelineEntry(status: .Failure, event: .Leftovers, description: generateRandomLeavings("2/3", time: "8:20 pm", day: "today"))
        let fourthEntry = TimelineEntry(status: .Success, event: .Lunch, description: generateRandomDescription("1/8", time: "1:47 pm", day: "yesterday"))
        let fifthEntry = TimelineEntry(status: .Success, event: .Dinner, description: generateRandomDescription("3/4", time: "6:00 pm", day: "yesterday"))
        let sixthEntry = TimelineEntry(status: .Failure, event: .Leftovers, description: generateRandomLeavings("2/3", time: "9:00 am", day: "on Monday"))
        let seventhEntry = TimelineEntry(status: .Success, event: .Lunch, description: generateRandomDescription("1/3", time: "12:00 pm", day: "on Monday"))
        let eigthEntry = TimelineEntry(status: .Success, event: .Dinner, description: generateRandomDescription("2/3", time: "7:20 pm", day: "on Monday"))

        // ADD NEW ENTRIES HERE
        
        timeline = [firstEntry, secondEntry, thirdEntry, fourthEntry, fifthEntry, sixthEntry, seventhEntry, eigthEntry]
        
        return timeline
    }
    
    // Random description generator
    class func generateRandomDescription(fraction: String, time: String, day: String) -> String {
        
        let randomFeedValue = (0.0...1.0).random()
        let calorieConversion = Int(randomFeedValue * kFeedCalories)
        
        return "\(kPetName) was fed \(fraction) cups (\(calorieConversion) calories) \(day) at \(time)"
    }
    
    class func generateRandomLeavings(fraction: String,time: String, day: String) -> String {
        
        let randomFeedValue = (0.0...1.0).random()
        let calorieConversion = Int(randomFeedValue * kFeedCalories)
        
        return "It looks like \(kPetName) left \(fraction) cups (\(calorieConversion) calories) in the bowl \(day) at \(time)"
    }
    
}

struct TimelineEntry {
 
    var status: EntryStatus = .Success
    var event: TimelineEvent = .None
    var description = ""
    
}

enum EntryStatus {
    case Success
    case Failure
}

enum TimelineEvent: String {
    case Breakfast = "Breakfast Served"
    case Lunch = "Lunch Served"
    case Dinner = "Dinner Served"
    case Leftovers = "Leftover Food"
    case None = ""
}
