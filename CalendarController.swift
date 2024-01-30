//
//  CalendarController.swift
//  recipe-recs
//
//  Created by Shonjoy Bhattacharyya on 1/29/24.
//

import UIKit
import EventKit
import EventKitUI

class CalendarController: UIViewController, EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    let eventStore = EKEventStore()
    var time = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        eventStore.requestWriteOnlyAccessToEvents( completion:{(granted, error) in
            DispatchQueue.main.async {
                    let event = EKEvent(eventStore: self.eventStore)
                    event.title = "Outfit for the Day - eKlozet"
                    event.url = URL(string: "https://apple.com")
                    event.isAllDay = true
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = self.eventStore
                    eventController.editViewDelegate = self
                    self.present(eventController, animated: true, completion: nil)
                    
                
            }
        })
    }
}
       
