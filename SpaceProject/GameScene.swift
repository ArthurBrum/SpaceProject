//
//  GameScene.swift
//  SpaceProject
//
//  Created by Arthur Jacunas de Brum on 17/04/15.
//  Copyright (c) 2015 Arthur Brum. All rights reserved.
//

import SpriteKit


struct PhysicsCatagory{
    static let Enemy : UInt32 = 1   //00000000000000000000000000000001
    static let Bullet : UInt32 = 2  //00000000000000000000000000000010
    static let Player : UInt32 = 3  //00000000000000000000000000000011
}


class GameScene: SKScene, SKPhysicsContactDelegate {

    //Declares attributes
    var Score = Int()
    var HighScore = Int()
    var Player = SKSpriteNode(imageNamed: "PlayerGalaga.png")
    var ScoreLbl = UILabel()

    override func didMoveToView(view: SKView) {
        
        
        var HighScoreDefault = NSUserDefaults.standardUserDefaults()
        
        //Sets zero if highscore is not declared (nil) and initializes otherwise.
        if(HighScoreDefault.valueForKey("HighScore") != nil){
            HighScore = HighScoreDefault.valueForKey("HighScore") as! NSInteger
        }
        else{
            HighScore = 0
        }
        
        physicsWorld.contactDelegate = self
        
        self.scene?.backgroundColor = UIColor.blackColor()
        self.scene?.size = CGSize(width: 640, height: 1136)
        self.addChild( SKEmitterNode(fileNamed: "MagicParticle"))
        
        //Sets physics for Player
        Player.position = CGPointMake(self.size.width/2, self.size.height/6)
        Player.physicsBody = SKPhysicsBody(rectangleOfSize: Player.size)
        Player.physicsBody?.affectedByGravity = false
        Player.physicsBody?.dynamic = false
        Player.physicsBody?.categoryBitMask = PhysicsCatagory.Player
        Player.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
        
        self.addChild(Player)
        
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("SpawnBullets"), userInfo: nil, repeats: true)
        
        var EnemyTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("SpawnEnemies"), userInfo: nil, repeats: true)
        
        ScoreLbl.text = " Score: \(Score)"
        ScoreLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        ScoreLbl.backgroundColor = UIColor(red: 0.1, green: 3, blue: 0.1, alpha: 0.3)
        ScoreLbl.textColor = UIColor.whiteColor()
        self.view?.addSubview(ScoreLbl)
    }
    
    
    // MARK: - Collisions treatment
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody = contact.bodyA
        var secondBody : SKPhysicsBody = contact.bodyB
        
        //Calls function CollisionWithBullet if the bullet kills the enemy
        if ((firstBody.categoryBitMask == PhysicsCatagory.Enemy) && (secondBody.categoryBitMask == PhysicsCatagory.Bullet)) ||
            ((firstBody.categoryBitMask == PhysicsCatagory.Bullet) && (secondBody.categoryBitMask == PhysicsCatagory.Enemy)){
            
                CollisionWithBullet(firstBody.node as! SKSpriteNode, Bullet: secondBody.node as! SKSpriteNode)
    
        //Calls function CollisionWithPerson if the player collides with the enemy.
        }else if ((firstBody.categoryBitMask == PhysicsCatagory.Enemy) && (secondBody.categoryBitMask == PhysicsCatagory.Player)) ||
            ((firstBody.categoryBitMask == PhysicsCatagory.Player) && (secondBody.categoryBitMask == PhysicsCatagory.Enemy)){
                
                CollisionWithPerson(firstBody.node as! SKSpriteNode, Person: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    
    /**
    Treats collisions between enemies and bullets
    
    :param: Enemy the enemy object that collided
    :param: Bullet the bullet object that collided
    :returns: void
    */
    func CollisionWithBullet (Enemy: SKSpriteNode, Bullet: SKSpriteNode){
        Enemy.removeFromParent()
        Bullet.removeFromParent()
        
        Score++
        
        ScoreLbl.text = " Score: \(Score)"
    }
    
    
    /**
    Treats collisions between enemies and player
    
    :param: Enemy the enemy object that collided
    :param: Person the player object that collided
    :returns: void
    */
    func CollisionWithPerson(Enemy: SKSpriteNode, Person: SKSpriteNode){
        var ScoreDefault = NSUserDefaults.standardUserDefaults()
        ScoreDefault.setValue(Score, forKey: "Score")
        ScoreDefault.synchronize()
        
        //Updates highscore if needed.
        if(Score > HighScore){
            var HighScoreDefault = NSUserDefaults.standardUserDefaults()
            HighScoreDefault.setValue(Score, forKey: "HighScore")
        }
        
        Enemy.removeFromParent()
        Person.removeFromParent()
        self.view?.presentScene(EndScene())
        ScoreLbl.removeFromSuperview()
        
    }
    
    
    // MARK: - Auto generated nodes
    
    /**
    Generates new bullets and makes them go down
    
    :returns: void
    */
    func SpawnBullets(){
        
        var Bullet = SKSpriteNode(imageNamed: "BulletGalaga.png")
        Bullet.zPosition = -5
        Bullet.position = CGPointMake(Player.position.x, Player.position.y)
        
        //Set physics for bullets
        Bullet.physicsBody = SKPhysicsBody(rectangleOfSize: Bullet.size)
        Bullet.physicsBody?.affectedByGravity = false
        Bullet.physicsBody?.dynamic = false
        Bullet.physicsBody?.categoryBitMask = PhysicsCatagory.Bullet
        Bullet.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemy
        
        let action = SKAction.moveToY(self.size.height + 30, duration: 1)
        let actionDone = SKAction.removeFromParent()
        Bullet.runAction(SKAction.sequence([action, actionDone]))
        
        self.addChild(Bullet)
    }
    
    
    /**
    Generates new enemies and makes them go down
    
    :returns: void
    */
    func SpawnEnemies(){
        var Enemy = SKSpriteNode(imageNamed: "EnemyGalaga.png")
        var MinValue = self.size.width/8
        var MaxValue = self.size.width - 20
        var SpawnPoint = UInt32(MaxValue - MinValue)
        Enemy.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        
        //Sets physics for enemies.
        Enemy.physicsBody = SKPhysicsBody(rectangleOfSize: Enemy.size)
        Enemy.physicsBody?.affectedByGravity = false
        Enemy.physicsBody?.dynamic = true
        Enemy.physicsBody?.categoryBitMask = PhysicsCatagory.Enemy
        Enemy.physicsBody?.contactTestBitMask = PhysicsCatagory.Bullet
        
        
        var action = SKAction.moveToY(-70, duration: 3.0)
        
        let actionDone = SKAction.removeFromParent()
        Enemy.runAction(SKAction.sequence([action, actionDone]))
        
        self.addChild(Enemy)
    }
    
    // MARK: - Movement rules

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            Player.position.x = location.x
            
            // Be careful, enables teletransporting super power xPPP - and 'probably' crashes the app!
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
