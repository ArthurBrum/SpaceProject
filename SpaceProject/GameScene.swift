//
//  GameScene.swift
//  SpaceProject
//
//  Created by Arthur Jacunas de Brum on 17/04/15.
//  Copyright (c) 2015 Arthur Brum. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var Player = SKSpriteNode(imageNamed: "PlayerGalaga.png")

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        Player.position = CGPointMake(self.size.width/2, self.size.height/6)
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
        
        var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("SpawEnemies"), userInfo: nil, repeats: true)
        
        self.addChild(Player)
    }
    
    
    func SpawnBullets(){
        
        var Bullet = SKSpriteNode(imageNamed: "BulletGalaga.png")
        Bullet.zPosition = -5
        Bullet.position = CGPointMake(Player.position.x, Player.position.y)
        
        
        let action = SKAction.moveToY(self.size.height + 30, duration: 1)
        Bullet.runAction(SKAction.repeatActionForever(action))
        
        
        self.addChild(Bullet)
    }
    
    func SpawnEnemies(){
        var Enemy = SKSpriteNode(imageNamed: "EnemyGalaga.png")
        var MinValue = self.size.width/8
        var MaxValue = self.size.width - 20
        var SpawnPoint = UInt32(MaxValue - MinValue)
        Enemy.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        
        let action = SKAction.moveToY(-70, duration: 3.0)
        Enemy.runAction(SKAction.repeatActionForever(action))
        
        
        self.addChild(Enemy)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x
            
            // Be careful, enables teletransporting super power xPPP
            //Player.position.y = location.y
            
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x

            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
