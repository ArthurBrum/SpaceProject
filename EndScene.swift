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
    
    override func didMoveToView(view: SKView) {
        scene?.backgroundColor = UIColor.whiteColor()
        
        RestartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 30))
        RestartBtn.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/4)
        RestartBtn.setTitle("Restart", forState: UIControlState.Normal)
        RestartBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        
        RestartBtn.addTarget(self, action: Selector("Restart"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(RestartBtn)
        
        
    }
    
    func Restart(){
        self.view?.presentScene(GameScene(), transition: SKTransition.crossFadeWithDuration(0.3))
        RestartBtn.removeFromSuperview()
    }
}
