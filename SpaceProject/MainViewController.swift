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
    @IBOutlet weak var endlessModeButton: UIButton!
    @IBOutlet weak var playerNameLabel: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTitle.alpha = 0
        endlessModeButton.alpha = 0
        self.playerNameLabel.alpha = 0
        
        let tap = UITapGestureRecognizer(target: self, action: "clickedBackground")
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        var viewBackground: UIView = UIView(frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height))
        var gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = viewBackground.bounds
        let color1 = UIColor(red: (127/255.0), green: (127/255.0), blue: (127/255.0), alpha: 1.0)
        let color2 = UIColor(red: (0/255.0), green: (0/255.0), blue: (25/255.0), alpha: 1.0)
        
        gradient.colors = [color1.CGColor, color2.CGColor]
        viewBackground.layer.insertSublayer(gradient, atIndex: 0)
        self.view.addSubview(viewBackground)
        self.view.sendSubviewToBack(viewBackground)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(3.0, animations: {()->Void in
            self.nameTitle.alpha = 1
            self.endlessModeButton.alpha = 1
            self.playerNameLabel.alpha = 1
        })
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueToGame") {
            var svc = segue.destinationViewController as! GameViewController
            if playerNameLabel.text == "" {
                svc.profileName = "Player1"
            }else {
                svc.profileName = playerNameLabel.text;
            }
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    
    }
    
    @IBAction func clickedBackground() {
        self.view.endEditing(true)
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
