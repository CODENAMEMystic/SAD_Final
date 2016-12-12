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
    
    let ScoreLbl = SKLabelNode()
    let HighScoreLbl = SKLabelNode()
    let homeTexture = SKTexture(imageNamed: "House")
    var homeBtn: SKSpriteNode!
    var retryBtn: SKSpriteNode!
    var gameOverBtn: SKSpriteNode!
    var scoreBLK: SKSpriteNode!
    var highscoreBLK: SKSpriteNode!
    var coinBLK: SKSpriteNode!
    let coinLbl = SKLabelNode()
    var coinIcon: SKSpriteNode!
    var cuppitLbl = SKLabelNode(fontNamed: "Thin")
    var statsBtn: SKSpriteNode!
    
    let URL_SAVE_TEAM = "http://theawkwardsquad.co/Service.php" //change to our url
    
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
        
        let scoreBLKTexture = SKTexture(imageNamed: "BlankBtn")
        scoreBLK = SKSpriteNode(texture: scoreBLKTexture)
        scoreBLK.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scoreBLK.setScale(0.5)
        scoreBLK.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.height / 2)
        scoreBLK.zPosition = 5
        self.addChild(scoreBLK)
        
        ScoreLbl.fontName = "Thin"
        ScoreLbl.fontSize = 60
        ScoreLbl.position = CGPoint(x: self.frame.size.width / 2, y: scoreBLK.position.y)
        ScoreLbl.fontColor = SKColor(red: 0, green: 0.7098, blue: 0.6, alpha: 1.0)
        ScoreLbl.text = "Current: \(score)"
        ScoreLbl.horizontalAlignmentMode = .center
        ScoreLbl.verticalAlignmentMode = .center
        ScoreLbl.zPosition = 5
        self.addChild(ScoreLbl)
        
        let highscoreBLKTexture = SKTexture(imageNamed: "BlankBtn")
        highscoreBLK = SKSpriteNode(texture: highscoreBLKTexture)
        highscoreBLK.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        highscoreBLK.setScale(0.5)
        highscoreBLK.position = CGPoint(x: self.frame.size.width / 2, y: scoreBLK.position.y + 100)
        highscoreBLK.zPosition = 5
        self.addChild(highscoreBLK)
        
        HighScoreLbl.fontName = "Thin"
        HighScoreLbl.position = CGPoint(x: self.frame.size.width / 2, y: highscoreBLK.position.y)
        HighScoreLbl.fontColor = SKColor(red: 0, green: 0.6941, blue: 0.8471, alpha: 1.0)
        HighScoreLbl.fontSize = 60
        HighScoreLbl.text = "Best: \(highScore)"
        HighScoreLbl.horizontalAlignmentMode = .center
        HighScoreLbl.verticalAlignmentMode = .center
        HighScoreLbl.zPosition = 5
        self.addChild(HighScoreLbl)
    
        let coinBLKTexture = SKTexture(imageNamed: "BlankBtn")
        coinBLK = SKSpriteNode(texture: coinBLKTexture)
        coinBLK.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        coinBLK.setScale(0.5)
        coinBLK.position = CGPoint(x: self.frame.size.width / 2, y: scoreBLK.position.y - 100)
        coinBLK.zPosition = 5
        self.addChild(coinBLK)
    
//        let coinTexture = SKTexture(imageNamed: "Coin")
//        coinIcon = SKSpriteNode(texture: coinTexture)
//        coinIcon.anchorPoint = CGPoint(x: 1, y: 0.5)
//        coinIcon.size = CGSize(width: 40, height: 40)
//        coinIcon.position = CGPoint(x: coinBLK.position.x + (coinBLK.size.width / 2) - 30, y: coinBLK.position.y)
//        coinIcon.zPosition = 5
//        self.addChild(coinIcon)
        
        coinLbl.fontName = "Thin"
        coinLbl.position = CGPoint(x: coinBLK.position.x, y: coinBLK.position.y)
        coinLbl.fontColor = SKColor(red: 0, green: 0.9765, blue: 0.8157, alpha: 1.0)
        coinLbl.fontSize = 60
        coinLbl.text = "\(coins) Coins"
        coinLbl.horizontalAlignmentMode = .center
        coinLbl.verticalAlignmentMode = .center
        coinLbl.zPosition = 5
        self.addChild(coinLbl)
        
        let gameOverBtnTexture = SKTexture(imageNamed: "GameOverBtn")
        gameOverBtn = SKSpriteNode(texture: gameOverBtnTexture)
        gameOverBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gameOverBtn.setScale(0.5)
        gameOverBtn.position = CGPoint(x: self.frame.size.width / 2, y: highscoreBLK.position.y + 100)
        gameOverBtn.name = "Game Over Button"
        gameOverBtn.zPosition = 5
        self.addChild(gameOverBtn)
        
        
        let retryBtnTexture = SKTexture(imageNamed: "RetryBtn")
        retryBtn = SKSpriteNode(texture: retryBtnTexture)
        retryBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        retryBtn.setScale(0.5)
        retryBtn.position = CGPoint(x: self.frame.size.width / 2, y: coinBLK.position.y - 100)
        retryBtn.name = "Retry Button"
        retryBtn.zPosition = 5
        self.addChild(retryBtn)
        
        cuppitLbl.fontSize = 150
        cuppitLbl.position = CGPoint(x: self.frame.size.width / 2, y: gameOverBtn.position.y + ((self.frame.height - gameOverBtn.position.y) / 2))
        cuppitLbl.fontColor = SKColor(red: 0, green: 0.7098, blue: 0.6, alpha: 1.0)
        cuppitLbl.text = "CUPPIT"
        cuppitLbl.name = "Cuppit Label"
        cuppitLbl.horizontalAlignmentMode = .center
        cuppitLbl.verticalAlignmentMode = .center
        cuppitLbl.zPosition = 5
        self.addChild(cuppitLbl)
        
        let StatsBtnTexture = SKTexture(imageNamed: "StatsBtn")
        statsBtn = SKSpriteNode(texture: StatsBtnTexture)
        statsBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        statsBtn.setScale(0.5)
        statsBtn.position = CGPoint(x: self.frame.size.width / 2, y: retryBtn.position.y - 100)
        statsBtn.name = "Stats Button"
        statsBtn.zPosition = 5
        self.addChild(statsBtn)
        
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
                   
                } else if node.name == "Retry Button" {
                    
                    let GameplayScene = GameScene(fileNamed: "GameScene")
                    GameplayScene?.scaleMode = .aspectFill
                    GameplayScene?.size = (self.view?.bounds.size)!
                    self.view?.presentScene(GameplayScene!, transition: SKTransition.push(with: .up, duration: 0.5))

                } else if node.name == "Stats Button" {
                    
                    //Database Stuff
                    print("stats")
                    //created NSURL
                    let requestURL = NSURL(string: URL_SAVE_TEAM) //change to our url
                    
                    //creating NSMutableURLRequest
                    let request = NSMutableURLRequest(url: requestURL! as URL)
                    
                    //setting the method to post
                    request.httpMethod = "POST"
                    
                    //getting values from text fields
                    let scoreStat = score
                    let highscoreStat = highScore
                    
                    //creating the post parameter by concatenating the keys and values from text field
                    let postParameters = "score="+String(scoreStat)+"&highscore="+String(highscoreStat);
                    
                    //adding the parameters to request body
                    request.httpBody = postParameters.data(using: String.Encoding.utf8)
                    
                    
                    //creating a task to send the post request
                    let task = URLSession.shared.dataTask(with: request as URLRequest){
                        data, response, error in
                        
                        if error != nil{
                            print("error is \(error)")
                            return;
                        }
                        
                        //parsing the response
                        do {
                            //converting resonse to NSDictionary
                            let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            //parsing the json
                            if let parseJSON = myJSON {
                                
                                //creating a string
                                var msg : String!
                                
                                //getting the json response
                                msg = parseJSON["message"] as! String?
                                
                                //printing the response
                                print(msg)
                                
                            }
                        } catch {
                            print(error)
                        }
                        
                    }
                    //executing the task
                    task.resume()

                }
            }
        }
        
    }
    
    
    
}
