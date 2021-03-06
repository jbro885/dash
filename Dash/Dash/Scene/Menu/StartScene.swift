//
//  StartScene.swift
//  Dash
//
//  Created by Jolyn Tan on 14/4/19.
//  Copyright © 2019 nus.cs3217. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
    var titleLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        initBackground()
        initTitleLabel()
        initPlayLabel()
    }

    private func initBackground() {
        let backgroundNode = BackgroundNode(self.frame)
        self.addChild(backgroundNode)
    }

    private func initTitleLabel() {
        titleLabel = SKLabelNode(fontNamed: Constants.defaultFont)
        titleLabel.text = "D A S H"
        titleLabel.fontSize = 160
        titleLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(titleLabel)
    }

    private func initPlayLabel() {
        let playLabel = SKLabelNode(fontNamed: Constants.defaultFont)
        playLabel.text = "tap to play"
        playLabel.fontSize = 20
        playLabel.position = CGPoint(x: self.frame.midX, y: titleLabel.position.y - 100)
        self.addChild(playLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let mainMenuScene = MainMenuScene(size: self.size)
        self.view?.presentScene(mainMenuScene)
    }
}
