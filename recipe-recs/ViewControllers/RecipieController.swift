//
//  RecipieController.swift
//  recipe-recs
//
//  Created by Shonjoy Bhattacharyya on 1/29/24.
//

import UIKit
import EventKit
import EventKitUI

class RecipeController: UIViewController, EKEventEditViewDelegate{
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
       controller.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var ingredient_1: UITextField!
    @IBOutlet weak var ingredient_2: UITextField!
    @IBOutlet weak var recipe_print: UILabel!
    var curr_recipe = ""
    var url_string = ""
    
    
    @IBAction func add_to_calendar(_ sender: Any) {
        let store = EKEventStore()
        store.requestWriteOnlyAccessToEvents( completion: {(granted, error) in
            DispatchQueue.main.async {
                    let event = EKEvent(eventStore: store)
                event.title = "Cook dish with " + self.ingredient_1.text! + " and " + self.ingredient_2.text!
                event.notes = self.curr_recipe
                event.url = URL(string: self.url_string)
                    event.isAllDay = true
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = store
                    eventController.editViewDelegate = self
                    self.present(eventController, animated: true, completion: nil)
                    
                
            }
        })
    }
    @IBAction func find_recipe() {
        let ing_1_arr = ingredient_1.text!.components(separatedBy: " ")
        let ing_2_arr = ingredient_2.text!.components(separatedBy: " ")
        var ing_1 = ""
        var ing_2 = ""
        for i in ing_1_arr{
            ing_1 += i.capitalized
        }
        for j in ing_2_arr{
            ing_2 += j.capitalized
        }
        
        url_string = "https://chat-cb5srbnobq-uc.a.run.app/?prompt=" + "CreateACocktailWithTheseIngredients" + ing_1 + "And" + ing_2
        print(url_string)
        guard let url = URL(string: url_string) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
    
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
            DispatchQueue.main.async {
                self.curr_recipe = decodedResponse.reply
                self.recipe_print.text = self.curr_recipe
            }
        }
            }
        }.resume()
    }

    struct Response: Codable {
        var reply: String
    }
    }

    
    
    
    
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    

