//
//  StartScene.swift
//  Cuppit
//
//  Created by Austin Sands on 11/6/16.
//  Copyright © 2016 Austin Sands. All rights reserved.
//

import UIKit
import SpriteKit

class StartScene: SKScene {

    var logo: SKSpriteNode!
    let logoLbl = SKLabelNode(fontNamed: "Georgina Demo")
    
    
    override func didMove(to view: SKView) {
        
        sceneSetup()
        Logo()
        
    }
    
    func sceneSetup(){
        
        self.backgroundColor = UIColor.black
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        createStars()
        
    }
    
    func createStars() {
        let starBackground = SKEmitterNode(fileNamed: "StarBackground")!
        starBackground.particlePositionRange.dx = self.frame.size.width
        starBackground.particlePositionRange.dy = self.frame.size.height
        starBackground.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        starBackground.zPosition = 0.5
        self.addChild(starBackground)
    }
    
    func Logo(){
        
        let waitTime: Double = 0.4
        let waitTime2: Double = 2.0
        
        
        logo = SKSpriteNode(imageNamed: "CuppitC")
        logo.size = CGSize(width: 180, height: 180)
        logo.zRotation = 4.71239
        logo.position = CGPoint(x: -200, y: self.frame.height / 2 + 100)
        logo.zPosition = 2
        self.addChild(logo)
        logo.run(SKAction.sequence([SKAction.wait(forDuration: waitTime), SKAction.move(to: CGPoint(x: self.frame.width / 2, y: logo.position.y), duration: 0.5)]))
        logo.run(SKAction.sequence([SKAction.wait(forDuration: waitTime2), SKAction.rotate(byAngle: 1.5708, duration: 0.5)]))
        
        
        logoLbl.fontColor = SKColor(red: 0, green: 0.4784, blue: 0.9294, alpha: 1.0)
        logoLbl.fontSize = 100
        logoLbl.horizontalAlignmentMode = .center
        logoLbl.verticalAlignmentMode = .center
        logoLbl.text = "CUPPIT"
        logoLbl.zPosition = 1
        logoLbl.position = CGPoint(x: self.frame.width + 500, y: logo.position.y - 200)
        self.addChild(logoLbl)
        logoLbl.run(SKAction.sequence([SKAction.wait(forDuration: waitTime), SKAction.move(to: CGPoint(x: self.frame.width / 2, y: logoLbl.position.y), duration: 0.5)]))
        
        
        self.run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run {
            
        
            self.logo.removeAllActions()
            self.logoLbl.removeAllActions()
            self.removeAllActions()

            let MenuScene = GameScene(fileNamed: "MenuScene")
            MenuScene?.scaleMode = .aspectFill
            MenuScene?.size = (self.view?.bounds.size)!
            self.view?.presentScene(MenuScene!,transition: SKTransition.push(with: .up, duration: 0.8))
            
            }]))

    
    }
    
  
}
