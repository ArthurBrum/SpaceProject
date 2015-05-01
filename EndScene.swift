//
//  EndScene.swift
//  SpaceProject
//
//  Created by Arthur Jacunas de Brum on 17/04/15.
//  Copyright (c) 2015 Arthur Brum. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene : SKScene {
    
    var RestartBtn : UIButton!
    var HighScore : Int!
    var profileName : String!
    var bestPlayer : String!
    var ScoreLbl: UILabel!
    var HighScoreLbl: UILabel!
    var BestPlayeLbl: UILabel!
    
    
    
    override func didMoveToView(view: SKView) {
        scene?.backgroundColor = UIColor.blackColor()
        
        RestartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 30))
        RestartBtn.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/4)
        RestartBtn.setTitle("Restart", forState: UIControlState.Normal)
        RestartBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        RestartBtn.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(RestartBtn)
        
        var ScoreDefault = NSUserDefaults.standardUserDefaults()
        var Score = ScoreDefault.valueForKey("Score") as! NSInteger
        
        var HighScoreDefault = NSUserDefaults.standardUserDefaults()
        HighScore = HighScoreDefault.valueForKey("HighScore") as! NSInteger
        profileName = HighScoreDefault.valueForKey("profileName") as! String
        bestPlayer = HighScoreDefault.valueForKey("BestPlayer") as! String
        
        ScoreLbl = UILabel(frame: CGRect(x:0, y:0, width: view.frame.size.width / 2, height: 30))
        ScoreLbl.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/3)
        ScoreLbl.text = "\(profileName) Score: \(Score)"
        ScoreLbl.textColor = UIColor.whiteColor()
        self.view?.addSubview(ScoreLbl)
        
        HighScoreLbl = UILabel(frame: CGRect(x:0, y:0, width: view.frame.size.width / 3, height: 30))
        HighScoreLbl.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        HighScoreLbl.text = "Highscore: \(HighScore)"
        HighScoreLbl.textColor = UIColor.whiteColor()
        self.view?.addSubview(HighScoreLbl)
        
        BestPlayeLbl = UILabel(frame: CGRect(x:0, y:0, width: view.frame.size.width / 3, height: 30))
        BestPlayeLbl.center = CGPoint(x: view.frame.size.width/2, y: (view.frame.size.height/2) + 20)
        BestPlayeLbl.text = "( \(bestPlayer) )"
        BestPlayeLbl.textColor = UIColor.whiteColor()
        self.view?.addSubview(BestPlayeLbl)
        
        
    }
    
    /**
    Starts a new game

    :returns: void
    */

    func Restart(){
        self.view?.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(0.5))
        RestartBtn.removeFromSuperview()
        ScoreLbl.removeFromSuperview()
        HighScoreLbl.removeFromSuperview()
    }
}
