//
//  ViewController.swift
//  PetFinderTimeline
//
//  Created by alvarezblue on 6/7/16.
//  Copyright © 2016 Sarah Worthing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // UX Constants
    let kEstimatedRowHeight: CGFloat = 88.0
    
    // Cell identifiers
    let kHeaderCellIdentifier = "headerCell"
    let kTimelineCellIdentifier = "timelineEntryCell"
    
    // Timeline Manager
    let timelineManager = TimelineManager()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
         super.viewDidLoad()
        
        nameLabel.text = kPetName
        
        // UX Magic - let cells choose their own height, set status bar
        self.tableView.estimatedRowHeight = kEstimatedRowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - UIStatusBarStyles
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return timelineManager.numberOfDaysInTimeline()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineManager.numberOfEntriesForDay(section: section)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerCell = tableView.dequeueReusableCellWithIdentifier(kHeaderCellIdentifier) as? TimelineHeaderTableViewCell else {
            return UIView()
        }
        
        headerCell.headerLabel.text = timelineManager.timelineHeaderForSection(section: section)
        
        return headerCell.contentView
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kTimelineCellIdentifier)
        
        guard let reusableCell = cell as? TimelineTableViewCell else {
            return UITableViewCell()
        }
        
        guard let entry = timelineManager.timelineEntry(forIndex: indexPath) else {
            return reusableCell
        }
        
        reusableCell.configure(entry)
        
        return reusableCell
    }
}

// Table View Cells
class TimelineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timelineActionButton: UIButton!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    func configure(entry: TimelineEntry) {
        
        // set image background based on type
        switch entry.status {
            case .Failure:
                timelineActionButton.setBackgroundImage(UIImage(named: "Failure"), forState: .Normal)
                break
            default:
                timelineActionButton.setBackgroundImage(UIImage(named: "Success"), forState: .Normal)
        }
        
        eventTypeLabel.text = entry.event.rawValue
        
        // Use attributed strings to maintain the line height
        let stringForAttributes = eventDescriptionLabel.attributedText
        let mutableAttributedText = NSMutableAttributedString(attributedString: stringForAttributes!)
        mutableAttributedText.replaceCharactersInRange(NSMakeRange(0, mutableAttributedText.string.utf16.count), withString: entry.description)
        eventDescriptionLabel.attributedText = mutableAttributedText
    }
}

class TimelineHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
}


