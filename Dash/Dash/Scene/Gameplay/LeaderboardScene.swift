//
//  LeaderboardScene.swift
//  Dash
//
//  Created by Jolyn Tan on 15/4/19.
//  Copyright © 2019 nus.cs3217. All rights reserved.
//

import SpriteKit

class LeaderboardScene: SKScene {
    let highScoreProvider = FirebaseHighScoreProvider(limit: 10)

    var incomingScore = 0
    var incomingName = ""

    override func didMove(to view: SKView) {
        prepareScoreBoard(with: incomingScore, and: incomingName)
    }

    func prepareScoreBoard(with score: Int, and name: String) {
        let highScoreRecord = HighScoreRecord(name: name, score: Double(score))
        highScoreProvider.setHighScore(highScoreRecord, category: .arrow, onDone: {
            self.renderScoreBoard()
        })
    }

    private func renderScoreBoard() {
        highScoreProvider.getHighScore(category: .arrow, onDone: { records in
            for (rank, record) in records.enumerated() {
                let name = record.name
                let score = Int(record.score)
                self.createRow(rank: rank, name: name, score: score)
            }
        })
    }

    private func createRow(rank: Int, name: String, score: Int) {
        let yPos = self.frame.height * 0.8 - CGFloat(rank) * 46
        let fontWeight = (name == incomingName && score == incomingScore) ? "Bold" : "Light"

        let rankLabel = SKLabelNode(fontNamed: "HelveticaNeue-\(fontWeight)")
        rankLabel.text = "0\(rank + 1)"
        rankLabel.fontSize = 32
        rankLabel.position = CGPoint(x: self.frame.width * 0.2, y: yPos)
        self.addChild(rankLabel)

        let nameLabel = SKLabelNode(fontNamed: "HelveticaNeue-\(fontWeight)")
        nameLabel.text = "\(name)"
        nameLabel.fontSize = 32
        nameLabel.position = CGPoint(x: self.frame.midX, y: yPos)
        self.addChild(nameLabel)

        let scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-\(fontWeight)")
        scoreLabel.text = "\(score)"
        scoreLabel.fontSize = 32
        scoreLabel.position = CGPoint(x: self.frame.width * 0.8, y: yPos)
        self.addChild(scoreLabel)
    }
}
