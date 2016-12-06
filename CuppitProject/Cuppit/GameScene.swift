//
//  GameScene.swift
//  Cuppit
//
//  Created by Austin Sands on 11/5/16.
//  Copyright © 2016 Austin Sands. All rights reserved.
//

import SpriteKit

struct PhysicsCatagory {
    
    static let enemyCatagory : UInt32 = 0x1 << 0
    static let cupCategory : UInt32 = 0x1 << 1
    static let scoreCategory: UInt32 = 0x1 << 2
    
}

    var score = 0
    var highScore = 0


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
   
    var rotatorValue: Float = 0
    var EnemyTimer = Timer()
    var gameStarted = false
    var cup: SKSpriteNode!
    var scoreNode = SKSpriteNode()
    var ScoreLbl = SKLabelNode(fontNamed: "Gameplay")
    var HighScoreLbl = SKLabelNode(fontNamed: "Gameplay")
    var slider: UISlider!
    var lastTouch: CGPoint? = nil
    var ableToPlay = true
    var pausePlayBTN: SKSpriteNode!
    var nodeSpeed = 12.0
    var timeDuration = 0.8
    
    let pauseTexture = SKTexture(imageNamed: "Pause Filled-50")
    let playTexture = SKTexture(imageNamed: "Play Filled-50")
    
    let homeTexture = SKTexture(imageNamed: "Home-48")
    var homeBtn: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
     
        
        SceneSetup()
        Cup()
        Scores()
        ScoreNode()
        PausePlayButton()
        HomeBtn()
    }
    
    
    func SceneSetup(){
        
        score = 0
        self.physicsWorld.contactDelegate = self
        self.anchorPoint = CGPoint(x: 0, y: 0)
        //self.backgroundColor = UIColor(red: 0.1373, green: 0.1373, blue: 0.1373, alpha: 1.0)
        self.backgroundColor = UIColor.black
        self.isPaused = false
        
        let starBackground = SKEmitterNode(fileNamed: "StarBackground")!
        starBackground.particlePositionRange.dx = self.frame.size.width
        starBackground.particlePositionRange.dy = self.frame.size.height
        starBackground.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        starBackground.zPosition = 0.5
        self.addChild(starBackground)

        
        
    }
    
   
    func Cup(){
        
        let cupTexture = SKTexture(imageNamed: "CuppitC")
        cup = SKSpriteNode(texture: cupTexture)
        cup.size = CGSize(width: 180, height: 180)
        cup.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        cup.physicsBody = SKPhysicsBody(texture: cupTexture, size: CGSize(width: cup.size.width, height: cup.size.height))
        cup.physicsBody?.affectedByGravity = false
        cup.physicsBody?.isDynamic = false
        cup.physicsBody?.allowsRotation = true
        cup.physicsBody?.categoryBitMask = PhysicsCatagory.cupCategory
        cup.physicsBody?.contactTestBitMask = PhysicsCatagory.enemyCatagory
        cup.physicsBody?.collisionBitMask = PhysicsCatagory.enemyCatagory
        cup.zRotation = CGFloat(rotatorValue)
        cup.name = "cup"
        cup.zPosition = 5
        cup.setScale(1.0)
        self.addChild(cup)
        cup.run(pulseAnimation())
        cup.physicsBody?.usesPreciseCollisionDetection = true
        cup.physicsBody?.restitution = 1.0

        
    }
    
    func Scores(){
        
        let HighscoreDefault = UserDefaults.standard
        if HighscoreDefault.value(forKey: "Highscore") != nil {
            
            
            highScore = HighscoreDefault.value(forKey: "Highscore") as! Int
            HighScoreLbl.text = "\(highScore)"
            
        }
        
        HighScoreLbl.fontSize = 60
        HighScoreLbl.position = CGPoint(x: self.frame.size.width - 15, y: self.frame.height - 15)
        HighScoreLbl.fontColor = SKColor(red: 1, green: 0.9804, blue: 0, alpha: 1.0)
        HighScoreLbl.text = "\(highScore)"
        HighScoreLbl.zPosition = 5
        HighScoreLbl.horizontalAlignmentMode = .right
        HighScoreLbl.verticalAlignmentMode = .top
        self.addChild(HighScoreLbl)
 
        ScoreLbl.fontSize = 110
        ScoreLbl.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.height - ((self.frame.height - cup.position.y) / 2))
        ScoreLbl.fontColor = SKColor(red: 0, green: 0.4784, blue: 0.9294, alpha: 1.0)
        ScoreLbl.text = "\(score)"
        ScoreLbl.horizontalAlignmentMode = .center
        ScoreLbl.verticalAlignmentMode = .center
        ScoreLbl.zPosition = 5
        self.addChild(ScoreLbl)

    }
    
    func ScoreNode(){
        scoreNode.size = CGSize(width: 10, height: 10)
        scoreNode.color = SKColor.clear
        scoreNode.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        scoreNode.name = "scoreNode"
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.allowsRotation = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.scoreCategory
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.enemyCatagory
        scoreNode.physicsBody?.collisionBitMask = PhysicsCatagory.enemyCatagory
        scoreNode.zPosition = 1
        self.addChild(scoreNode)
    }
    
    func PausePlayButton(){
        
        pausePlayBTN = SKSpriteNode(texture: pauseTexture)
        pausePlayBTN.size = CGSize(width: 60, height: 60)
        pausePlayBTN.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        pausePlayBTN.position = CGPoint(x: 10, y: self.frame.height - 10)
        pausePlayBTN.name = "Pause"
        pausePlayBTN.zPosition = 5
        self.addChild(pausePlayBTN)
        
    }
    
    func HomeBtn() {
        
        homeBtn = SKSpriteNode(texture: homeTexture)
        homeBtn.size = CGSize(width: 60, height: 60)
        homeBtn.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        homeBtn.position = CGPoint(x: pausePlayBTN.position.x + 60, y: self.frame.height - 10)
        homeBtn.name = "Home"
        homeBtn.zPosition = 5
        self.addChild(homeBtn)
    }
    
    func GameOver(){
        
        scoreNode.removeFromParent()
        self.removeAllActions()
        EnemyTimer.invalidate()
        gameStarted = false
        cup.removeAllActions()
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run {
            let GameOverScene = GameScene(fileNamed: "GameOverScene")
            GameOverScene?.scaleMode = .aspectFill
            GameOverScene?.size = (self.view?.bounds.size)!
            self.view?.presentScene(GameOverScene!, transition: SKTransition.push(with: .up, duration: 0.5))

            }]))
        
            }
    
    
    func pulseAnimation() -> SKAction {
        
        let duration = 1.0
        let pulseOut = SKAction.scale(to: 1.2, duration: duration)
        let pulseIn = SKAction.scale(to: 1.0, duration: duration)
        let pulse = SKAction.sequence([pulseOut, pulseIn])
        return SKAction.repeatForever(pulse)
        
    }
    
    func Enemies(){
        let Enemy = SKSpriteNode(imageNamed: "EnemyCool")
        Enemy.size = CGSize(width: 30, height: 30)
        
        
        //Physics
        Enemy.physicsBody = SKPhysicsBody(circleOfRadius: Enemy.size.width / 2)
        Enemy.physicsBody?.categoryBitMask = PhysicsCatagory.enemyCatagory
        Enemy.physicsBody?.contactTestBitMask = PhysicsCatagory.cupCategory | PhysicsCatagory.scoreCategory
        Enemy.physicsBody?.collisionBitMask =  PhysicsCatagory.cupCategory | PhysicsCatagory.scoreCategory
        Enemy.physicsBody?.affectedByGravity = false
        Enemy.physicsBody?.isDynamic = true
        Enemy.zPosition = 1
        Enemy.name = "Enemy"
        Enemy.physicsBody?.friction = 0
        Enemy.physicsBody?.angularDamping = 0
        Enemy.physicsBody?.linearDamping = 0
        Enemy.physicsBody?.usesPreciseCollisionDetection = true
        Enemy.physicsBody?.restitution = 1.0
        
        
        let trailNode = SKNode()
        trailNode.zPosition = 3
        addChild(trailNode)
        let trail = SKEmitterNode(fileNamed: "TrailForEnemy")!
        trail.targetNode = trailNode
        Enemy.addChild(trail)
        
        
        let RandomPosNmbr = arc4random() % 4 //8
        
        switch RandomPosNmbr{
        case 0:
            
            Enemy.position.x = -100
            
            let PositionY = arc4random_uniform(UInt32(frame.size.height))
            
            Enemy.position.y = CGFloat(PositionY)
          
            
                var dx = CGFloat(cup.position.x - Enemy.position.x)
                var dy = CGFloat(cup.position.y - Enemy.position.y)
        
        
                let magnitude = sqrt(dx * dx + dy * dy)
        
                dx /= magnitude
                dy /= magnitude
        
                self.addChild(Enemy)
        
                let vector = CGVector(dx: CGFloat(nodeSpeed) * dx, dy:  CGFloat(nodeSpeed) * dy)
                
                Enemy.physicsBody?.applyImpulse(vector)
            
            
            
            break
        case 1:
            
            Enemy.position.y = -100
            
            let PositionX = arc4random_uniform(UInt32(frame.size.width))
            
            Enemy.position.x = CGFloat(PositionX)
        
                var dx = CGFloat(cup.position.x - Enemy.position.x)
                var dy = CGFloat(cup.position.y - Enemy.position.y)
        
        
                let magnitude = sqrt(dx * dx + dy * dy)
        
                dx /= magnitude
                dy /= magnitude
        
                self.addChild(Enemy)
        
                let vector = CGVector(dx: CGFloat(nodeSpeed) * dx, dy:  CGFloat(nodeSpeed) * dy)
                
                Enemy.physicsBody?.applyImpulse(vector)
            
            
            break
        case 2:
            
            Enemy.position.y = frame.size.height + 100
            
            let PositionX = arc4random_uniform(UInt32(frame.size.width))
            
            Enemy.position.x = CGFloat(PositionX)
           
                var dx = CGFloat(cup.position.x - Enemy.position.x)
                var dy = CGFloat(cup.position.y - Enemy.position.y)
        
        
                let magnitude = sqrt(dx * dx + dy * dy)
        
                dx /= magnitude
                dy /= magnitude
        
                self.addChild(Enemy)
        
                let vector = CGVector(dx: CGFloat(nodeSpeed) * dx, dy:  CGFloat(nodeSpeed) * dy)
                
                Enemy.physicsBody?.applyImpulse(vector)
            

            
            break
        case 3:
            
            Enemy.position.x = frame.size.width + 100
            
            let PositionY = arc4random_uniform(UInt32(frame.size.height))
            
            Enemy.position.y = CGFloat(PositionY)
         
            
                var dx = CGFloat(cup.position.x - Enemy.position.x)
                var dy = CGFloat(cup.position.y - Enemy.position.y)
        
        
                let magnitude = sqrt(dx * dx + dy * dy)
        
                dx /= magnitude
                dy /= magnitude
        
                self.addChild(Enemy)
        
                let vector = CGVector(dx: CGFloat(nodeSpeed) * dx, dy: CGFloat(nodeSpeed) * dy)
                
                Enemy.physicsBody?.applyImpulse(vector)
            
            
            break
        default:
            
            break
            
        }
  
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node != nil && contact.bodyB.node != nil{
            let firstBody = contact.bodyA.node as! SKSpriteNode
            let secondBody = contact.bodyB.node as! SKSpriteNode
            
            if ((firstBody.name == "cup") && (secondBody.name == "Enemy")){
                
                collisionMain(secondBody)
                
            }
            else if ((firstBody.name == "Enemy") && (secondBody.name == "cup")){
                
                collisionMain(firstBody)
                
            }
            else if ((firstBody.name == "scoreNode") && (secondBody.name == "Enemy")){
                
                collisionScore(secondBody)
                
            }
            else if ((firstBody.name == "Enemy") && (secondBody.name == "scoreNode")){
                
                collisionScore(firstBody)
                
            }

            
        }
        
    }
    
    func collisionMain(_ Enemy : SKSpriteNode){
        
        
        
        func explodeBall(_ node: SKNode) {
        
        let emitter = SKEmitterNode(fileNamed: "ExplodeParticle")!
        emitter.position = node.position
        emitter.zPosition = 10
        addChild(emitter)
        emitter.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.removeFromParent()]))
        node.removeFromParent()
        }
        
        func explodeCup(_ node: SKNode) {
        let emitter = SKEmitterNode(fileNamed: "CupExplodeParticle")!
        emitter.position = node.position
        emitter.zPosition = 10
        addChild(emitter)
        emitter.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.removeFromParent()]))
        node.removeFromParent()
        }

        explodeCup(cup)
        explodeBall(Enemy)
        ableToPlay = false
        Enemy.removeAllActions()
        GameOver()
    
        
    }


    func collisionScore(_ Enemy : SKSpriteNode){
        
        Enemy.removeAllActions()
        Enemy.removeFromParent()
        
        if gameStarted {

            if score <= 8 {
                timeDuration = 1.2
            } else {
                timeDuration = 0.8
            }
            
            
            nodeSpeed += 0.5
            
        score += 1
        ScoreLbl.text = "\(score)"
        
        
        if score > highScore {
            let HighscoreDefault = UserDefaults.standard
            highScore = score
            HighscoreDefault.set(highScore, forKey: "Highscore")
            HighScoreLbl.text = "\(highScore)"
            
        }
    }
}

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false && ableToPlay {
            
            cup.removeAllActions()
            cup.run(SKAction.scale(to: 1.0, duration: 0.5))
            
            EnemyTimer = Timer.scheduledTimer(timeInterval: timeDuration, target: self, selector: #selector(GameScene.Enemies), userInfo: nil, repeats: true)
            gameStarted = true
            
            
    }
        
        handleTouches(touches)
        
        for touch in touches {
            
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes
            {
                if node.name == "Pause"
                {
                    self.isPaused = true
                    pausePlayBTN.name = "Play"
                    pausePlayBTN.texture = playTexture
                    EnemyTimer.invalidate()
                    
                } else if node.name == "Play" {
                    
                    self.isPaused = false
                    pausePlayBTN.name = "Pause"
                    pausePlayBTN.texture = pauseTexture
                    EnemyTimer = Timer.scheduledTimer(timeInterval: timeDuration, target: self, selector: #selector(GameScene.Enemies), userInfo: nil, repeats: true)
                    
                } else if node.name == "Home" {
                    
                    score = 0
                    self.removeAllActions()
                    let MenuScene = GameScene(fileNamed: "MenuScene")
                    MenuScene?.scaleMode = .aspectFill
                    MenuScene?.size = (self.view?.bounds.size)!
                    self.view?.presentScene(MenuScene!, transition: SKTransition.push(with: .up, duration: 0.5))

                    
                }
            }
        }
        
   
}
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }

    
    fileprivate func handleTouches(_ touches: Set<UITouch>) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            lastTouch = touchLocation
        }
    }
    
    override func didSimulatePhysics() {
        if let _ = cup {
            updateCup()
        }
        
        
        
    }

    fileprivate func shouldMove(currentPosition: CGPoint, touchPosition: CGPoint) -> Bool {
        return abs(currentPosition.x - touchPosition.x) > cup!.frame.width / 2 ||
            abs(currentPosition.y - touchPosition.y) > cup!.frame.height / 2
    }

    
    func updateCup(){
        if let touch = lastTouch {
            let currentPosition = cup!.position
            if shouldMove(currentPosition: currentPosition, touchPosition: touch) {
                
                let angle = atan2(currentPosition.y - touch.y, currentPosition.x - touch.x) + CGFloat(M_PI)
                let rotateAction = SKAction.rotate(toAngle: angle - CGFloat(M_PI*0.5), duration: 0)
                
                cup.run(rotateAction)
                
                }
            }
        }
    
    


}

    

