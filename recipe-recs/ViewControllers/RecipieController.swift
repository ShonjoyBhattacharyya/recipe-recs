//
//  RecipieController.swift
//  recipe-recs
//
//  Created by Shonjoy Bhattacharyya on 1/29/24.
//

import UIKit
import EventKit
import EventKitUI

class RecipieController: UIViewController, EKEventEditViewDelegate{
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
       controller.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var ingredient_1: UITextField!
    @IBOutlet weak var ingredient_2: UITextField!
    @IBOutlet weak var recipie_print: UILabel!
    
    @IBAction func find_recipie(_ sender: Any) {
        let ing_1 : String = ingredient_1.text!
        let ing_2 : String = ingredient_2.text!
        let question = "Find me a recipie for a meal that uses " + ing_1 + " and " + ing_2
        print(question)
        recipie_print.text = question
        
        
        
    }
    @IBAction func add_to_calendar(_ sender: Any) {
        let store = EKEventStore()
        store.requestWriteOnlyAccessToEvents( completion: {(granted, error) in
            DispatchQueue.main.async {
                    let event = EKEvent(eventStore: store)
                event.title = "Cook dish with " + self.ingredient_1.text! + " and " + self.ingredient_2.text!
                    event.url = URL(string: "https://apple.com")
                event.notes = self.recipie_print.text!
                    event.isAllDay = true
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = store
                    eventController.editViewDelegate = self
                    self.present(eventController, animated: true, completion: nil)
                    
                
            }
        })
    }
    
    
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }

