//
//  MainViewController.swift
//  SpaceProject
//
//  Created by Plinio Massaki Nishiye Umezaki on 4/30/15.
//  Copyright (c) 2015 Arthur Brum. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var levelModeButton: UIButton!
    @IBOutlet weak var endlessModeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTitle.alpha = 0
        levelModeButton.alpha = 0
        endlessModeButton.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(3.0, animations: {()->Void in
            self.nameTitle.alpha = 1
            self.levelModeButton.alpha = 1
            self.endlessModeButton.alpha = 1
        })
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
