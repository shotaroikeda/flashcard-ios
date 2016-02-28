//
//  flashcardSegueViewController.swift
//  flashcard-ios
//
//  Created by Shotaro Ikeda on 2/28/16.
//  Copyright © 2016 Shotaro Ikeda. All rights reserved.
//

import UIKit

class flashcardSegueViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var toggleView: toggleButton!
    var setMode : (() -> Void)!
    var modeName : String!
    var desc : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleView.handleToggle = { [unowned self] in
            self.setMode()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        toggleView.handleCancel = { [unowned self] in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        toggleView.modeName = self.modeName
        // Do any additional setup after loading the view.
        
        descLabel.text = desc
        titleLabel.text = modeName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
