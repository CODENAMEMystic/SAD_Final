//
//  MenuScene.swift
//  Cuppit
//
//  Created by Austin Sands on 12/5/16.
//  Copyright © 2016 Austin Sands. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class MenuScene: SKScene, GKGameCenterControllerDelegate {
    
    var logo: SKSpriteNode!
    var cuppitLbl = SKLabelNode(fontNamed: "Georgina Demo")
    var leaderBoardLbl = SKLabelNode(fontNamed: "Georgina Demo")
    var playLbl = SKLabelNode(fontNamed: "Georgina Demo")
    var playBtn: SKSpriteNode!
    var leaderBoardBtn: SKSpriteNode!

    
    override func didMove(to view: SKView) {
        
        setupBackground()
        CreateBtns()
        
    
    }
    //setup background
    func setupBackground(){
        backgroundColor = UIColor.black
        self.anchorPoint = CGPoint(x: 0, y: 0)
        createStars()
        
        
    }
    

    //create stars
    func createStars() {
        let starBackground = SKEmitterNode(fileNamed: "StarBackground")!
        starBackground.particlePositionRange.dx = self.frame.size.width
        starBackground.particlePositionRange.dy = self.frame.size.height
        starBackground.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        starBackground.zPosition = 0.5
        self.addChild(starBackground)
    }
    
    //create buttons
    func CreateBtns() {
        
        let logoTexture = SKTexture(imageNamed: "CuppitC")
        logo = SKSpriteNode(texture: logoTexture)
        logo.size = CGSize(width: 250, height: 250)
        logo.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 200)
        logo.name = "Logo"
        logo.zPosition = 5
        self.addChild(logo)
        
        cuppitLbl.fontSize = 150
        cuppitLbl.position = CGPoint(x: self.frame.size.width / 2, y: logo.position.y - 250)
        cuppitLbl.fontColor = SKColor(red: 0, green: 0.4784, blue: 0.9294, alpha: 1.0)
        cuppitLbl.text = "CUPPIT"
        cuppitLbl.name = "Cuppit Label"
        cuppitLbl.horizontalAlignmentMode = .center
        cuppitLbl.verticalAlignmentMode = .center
        cuppitLbl.zPosition = 5
        self.addChild(cuppitLbl)
        
        playLbl.fontSize = 70
        playLbl.position = CGPoint(x: self.frame.size.width / 2, y: cuppitLbl.position.y - 200)
        playLbl.fontColor = SKColor(red: 0, green: 0.898, blue: 0.749, alpha: 1.0)
        playLbl.text = "Play"
        playLbl.name = "Play Button"
        playLbl.horizontalAlignmentMode = .center
        playLbl.verticalAlignmentMode = .center
        playLbl.zPosition = 5
        self.addChild(playLbl)
        
        leaderBoardLbl.fontSize = 70
        leaderBoardLbl.position = CGPoint(x: self.frame.size.width / 2, y: playLbl.position.y - 150)
        leaderBoardLbl.fontColor = SKColor(red: 0.949, green: 1, blue: 0, alpha: 1.0)
        leaderBoardLbl.text = "Leaderboards"
        leaderBoardLbl.name = "Leaderboard Button"
        leaderBoardLbl.horizontalAlignmentMode = .center
        leaderBoardLbl.verticalAlignmentMode = .center
        leaderBoardLbl.zPosition = 5
        self.addChild(leaderBoardLbl)

     
//        let playBtnTexture = SKTexture(imageNamed: "Play Filled-50")
//        playBtn = SKSpriteNode(texture: playBtnTexture)
//        playBtn.size = CGSize(width: 100, height: 100)
//        playBtn.position = CGPoint(x: self.frame.size.width / 2, y: logo.position.y - 200)
//        playBtn.name = "Play Button"
//        playBtn.zPosition = 5
//        self.addChild(playBtn)
        
//        let LBBtnTexture = SKTexture(imageNamed: "Leaderboard-52")
//        leaderBoardBtn = SKSpriteNode(texture: LBBtnTexture)
//        leaderBoardBtn.size = CGSize(width: 100, height: 100)
//        leaderBoardBtn.position = CGPoint(x: self.frame.size.width / 2, y: playBtn.position.y - 200)
//        leaderBoardBtn.name = "Leaderboard Button"
//        leaderBoardBtn.zPosition = 5
//        self.addChild(leaderBoardBtn)

        
    }
    //saves highscore
    func saveHighscore(_ number : Int){
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "Cuppit_Leaderboard")
            
            scoreReporter.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReporter]
            
            GKScore.report(scoreArray, withCompletionHandler: nil)
            
        }
        
        
    }
    //shows leaderboard
    func showLeaderBoard(){
        let viewController = self.view?.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        
        gcvc.gameCenterDelegate = self
        
        viewController?.present(gcvc, animated: true, completion: nil)
    }
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
    }


    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches {
            
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes
            {
                if node.name == "Play Button"
                {
                    self.removeAllActions()
                    self.isPaused = true
                    let GameplayScene = GameScene(fileNamed: "GameScene")
                    GameplayScene?.scaleMode = .aspectFill
                    GameplayScene?.size = (self.view?.bounds.size)!
                    self.view?.presentScene(GameplayScene!,transition: SKTransition.push(with: .up, duration: 0.8))
                    
                } else if node.name == "Leaderboard Button" {
                    
                
                    print("\(highScore)")
                    saveHighscore(highScore)
                    showLeaderBoard()
                    
                    
                }
            }
        }
       
    }
}
