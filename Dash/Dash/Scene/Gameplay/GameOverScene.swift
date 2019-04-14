//
//  GameOverScene.swift
//  Dash
//
//  Created by Jolyn Tan on 15/4/19.
//  Copyright © 2019 nus.cs3217. All rights reserved.
//

import SpriteKit

// TODO: add menu bar
class GameOverScene: SKScene {
    var currentCharacterType: CharacterType = .arrow
    
    var score = 0
    var scoreLabel: SKLabelNode!
    var bestScoreLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        initCurrentScoreLabel()
        initBestScoreLabel(score: 12900)
        initReplayLabel()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presentGameScene(with: currentCharacterType)
    }

    private func initCurrentScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        scoreLabel.text = "\(score) pts"
        scoreLabel.fontSize = 120
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 80)
        self.addChild(scoreLabel)
    }

    private func initBestScoreLabel(score: Int) {
        bestScoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        bestScoreLabel.text = "Best: \(score) pts" // TODO: Set best score from storage
        bestScoreLabel.fontSize = 24
        bestScoreLabel.position = CGPoint(x: self.frame.midX, y: scoreLabel.position.y - 80)
        self.addChild(bestScoreLabel)
    }

    private func initReplayLabel() {
        let replayLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        replayLabel.text = "tap to play again"
        replayLabel.fontSize = 22
        replayLabel.position = CGPoint(x: self.frame.midX, y: bestScoreLabel.position.y - 120)
        self.addChild(replayLabel)
    }

    private func presentGameScene(with characterType: CharacterType) {
        let gameScene = GameScene(size: self.size)
        gameScene.characterType = characterType
        self.view?.presentScene(gameScene)
    }
}