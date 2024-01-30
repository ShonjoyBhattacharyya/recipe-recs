//
//  ViewController.swift
//  recipe-recs
//
//  Created by Shonjoy Bhattacharyya on 1/29/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
        // Do any additional setup after loading the view.
    @IBOutlet weak var start_btn: UIButton!
    @IBAction func letsgo(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let RecipeView = storyboard.instantiateViewController(withIdentifier: "RecipeController") as! RecipeController
            
            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
        self.present(RecipeView, animated: true, completion: nil)
    }

}

