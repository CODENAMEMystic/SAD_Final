//
//  GameOverScene.swift
//  Cuppit
//
//  Created by Austin Sands on 11/8/16.
//  Copyright © 2016 Austin Sands. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    let ScoreLbl = SKLabelNode(fontNamed: "Gameplay")
    let HighScoreLbl = SKLabelNode(fontNamed: "Gameplay")
    let retryLbl = SKLabelNode(fontNamed: "Georgina Demo")
    let GameOverLbl = SKLabelNode(fontNamed: "Georgina Demo")
    let homeTexture = SKTexture(imageNamed: "Home-48")
    var homeBtn: SKSpriteNode!

    
    
    override func didMove(to view: SKView) {
        
        setupBackground()
        setupLabels()
        HomeBtn()
        
        
    }
    
    func setupBackground(){
        backgroundColor = UIColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0)
        //createStars()
        
        
    }
    
    func createStars() {
        let starBackground = SKEmitterNode(fileNamed: "StarBackground")!
        starBackground.particlePositionRange.dx = self.frame.size.width
        starBackground.particlePositionRange.dy = self.frame.size.height
        starBackground.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        starBackground.zPosition = 0.5
        self.addChild(starBackground)
    }
    func HomeBtn() {
        
        homeBtn = SKSpriteNode(texture: homeTexture)
        homeBtn.size = CGSize(width: 60, height: 60)
        homeBtn.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        homeBtn.position = CGPoint(x: 10, y: self.frame.height - 10)
        homeBtn.name = "Home"
        homeBtn.zPosition = 5
        self.addChild(homeBtn)
    }


    
    func setupLabels(){
    
        
        if highScore >= 10000000 {
            HighScoreLbl.fontSize = 50
        } else {
            HighScoreLbl.fontSize = 110
        }
        
        HighScoreLbl.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.height / 2 + 100)
        HighScoreLbl.fontColor = SKColor(red: 1, green: 0.9804, blue: 0, alpha: 1.0)
        HighScoreLbl.text = "\(highScore)"
        HighScoreLbl.horizontalAlignmentMode = .center
        HighScoreLbl.verticalAlignmentMode = .center
        HighScoreLbl.zPosition = 5
        self.addChild(HighScoreLbl)
        
        ScoreLbl.fontSize = 110
        ScoreLbl.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.height / 2 - 100)
        ScoreLbl.fontColor = SKColor(red: 0, green: 0.4784, blue: 0.9294, alpha: 1.0)
        ScoreLbl.text = "\(score)"
        ScoreLbl.horizontalAlignmentMode = .center
        ScoreLbl.verticalAlignmentMode = .center
        ScoreLbl.zPosition = 5
        self.addChild(ScoreLbl)
        
        retryLbl.fontSize = 80
        retryLbl.position = CGPoint(x: self.frame.size.width / 2, y: ScoreLbl.position.y - 200)
        retryLbl.fontColor = SKColor.blue
        retryLbl.text = "Retry"
        retryLbl.name = "Retry Label"
        retryLbl.horizontalAlignmentMode = .center
        retryLbl.verticalAlignmentMode = .center
        retryLbl.zPosition = 5
        self.addChild(retryLbl)
        
        GameOverLbl.fontSize = 80
        GameOverLbl.position = CGPoint(x: self.frame.size.width / 2, y: HighScoreLbl.position.y + 200)
        GameOverLbl.fontColor = SKColor.red
        GameOverLbl.text = "Game Over"
        GameOverLbl.horizontalAlignmentMode = .center
        GameOverLbl.verticalAlignmentMode = .center
        GameOverLbl.zPosition = 5
        self.addChild(GameOverLbl)
     
    
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        score = 0
        self.removeAllActions()
        
        for touch in touches {
            
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes
            {
                if node.name == "Home"
                {
                    
                    score = 0
                    self.removeAllActions()
                    let MenuScene = GameScene(fileNamed: "MenuScene")
                    MenuScene?.scaleMode = .aspectFill
                    MenuScene?.size = (self.view?.bounds.size)!
                    self.view?.presentScene(MenuScene!, transition: SKTransition.push(with: .up, duration: 0.5))
                   
                } else if node.name == "Retry Label" {
                    
                
                    let GameplayScene = GameScene(fileNamed: "GameScene")
                    GameplayScene?.scaleMode = .aspectFill
                    GameplayScene?.size = (self.view?.bounds.size)!
                    self.view?.presentScene(GameplayScene!, transition: SKTransition.push(with: .up, duration: 0.5))

                }
            }
        }
        
    }
    
    
    
}
