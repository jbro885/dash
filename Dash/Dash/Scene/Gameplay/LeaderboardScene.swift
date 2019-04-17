//
//  LeaderboardScene.swift
//  Dash
//
//  Created by Jolyn Tan on 15/4/19.
//  Copyright © 2019 nus.cs3217. All rights reserved.
//

import SpriteKit

class LeaderboardScene: SKScene {
    private var loadingView: UIView!
    let highScoreProvider = FirebaseHighScoreProvider(limit: 10)

    var returnToMenuScene: SKScene?

    var incomingScore = 0
    var incomingName: String?
    var incomingCategory = HighScoreCategory.arrow
    var currentPlayerActions: [Action] = []
    var currentSeed = 0

    override func didMove(to view: SKView) {
        initHighScoreLabel()
        if let name = incomingName {
            prepareScoreBoard(with: incomingScore, and: name)
        } else {
            renderScoreBoard()
        }
        initContinueLabel()
        initLoadingWindow()
    }

    func prepareScoreBoard(with score: Int, and name: String) {
        let highScoreRecord = HighScoreRecord(name: name, score: Double(score))
        highScoreProvider.setHighScore(highScoreRecord, category: incomingCategory) {
            self.renderScoreBoard()
        }
    }

    private func renderScoreBoard() {
        highScoreProvider.getHighScore(category: incomingCategory) { [weak self] records in
            self?.hideLoadingWindow()
            for (rank, record) in records.enumerated() {
                let name = record.name
                let score = Int(record.score)
                self?.createRow(rank: rank, name: name, score: score)
            }
        }
    }

    private func createRow(rank: Int, name: String, score: Int) {
        let yPos = self.frame.height * 0.85 - 80 - CGFloat(rank) * 46
        let fontWeight = (name == incomingName && score == incomingScore) ? "Bold" : "Light"
        let fontSize = CGFloat(24)

        let rankLabel = SKLabelNode(fontNamed: "HelveticaNeue-\(fontWeight)")
        rankLabel.text = (rank < 9) ? "0\(rank + 1)" : "\(rank + 1)"
        rankLabel.fontSize = fontSize
        rankLabel.position = CGPoint(x: self.frame.width * 0.2, y: yPos)
        self.addChild(rankLabel)

        let nameLabel = SKLabelNode(fontNamed: "HelveticaNeue-\(fontWeight)")
        nameLabel.text = "\(name)"
        nameLabel.fontSize = fontSize
        nameLabel.position = CGPoint(x: self.frame.midX, y: yPos)
        self.addChild(nameLabel)

        let scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-\(fontWeight)")
        scoreLabel.text = "\(score)"
        scoreLabel.fontSize = fontSize
        scoreLabel.position = CGPoint(x: self.frame.width * 0.8, y: yPos)
        self.addChild(scoreLabel)
    }

    private func initHighScoreLabel() {
        let highScoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        highScoreLabel.text = "H I G H S C O R E S"
        highScoreLabel.fontSize = 46
        highScoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height * 0.85)
        self.addChild(highScoreLabel)
    }

    private func initContinueLabel() {
        let highScoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        highScoreLabel.text = "tap to continue"
        highScoreLabel.fontSize = 20
        highScoreLabel.position = CGPoint(x: self.frame.midX, y: 70)
        self.addChild(highScoreLabel)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard incomingName != nil, returnToMenuScene != nil else {
            cleanSubviews()
            self.view?.presentScene(returnToMenuScene)
            return
        }

        let gameOverScene = GameOverScene(size: self.size)
        gameOverScene.score = incomingScore
        gameOverScene.currentPlayerActions = currentPlayerActions
        gameOverScene.currentSeed = currentSeed

        switch incomingCategory {
        case .arrow:
            gameOverScene.currentCharacterType = .arrow
        case .flappy:
            gameOverScene.currentCharacterType = .flappy
        case .glide:
            gameOverScene.currentCharacterType = .glide
        }

        cleanSubviews()
        self.view?.presentScene(gameOverScene)
    }

    private func initLoadingWindow() {
        let midPoint = CGPoint(x: frame.midX, y: frame.midY)
        loadingView = LoadingView(origin: frame.origin, mid: midPoint, size: frame.size)
        loadingView.alpha = 1
        view?.addSubview(loadingView)
    }

    private func hideLoadingWindow() {
        loadingView.alpha = 0
    }

    private func cleanSubviews() {
        guard let subviews = view?.subviews else {
            return
        }
        subviews.forEach { $0.removeFromSuperview() }
    }
}
