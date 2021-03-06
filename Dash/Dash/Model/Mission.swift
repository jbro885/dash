//
//  Mission.swift
//  Dash
//
//  Created by Jolyn Tan on 11/4/19.
//  Copyright © 2019 nus.cs3217. All rights reserved.
//

import Foundation

class Mission: Observable {
    var observers = [ObjectIdentifier: Observation]()
    var message = "" {
        didSet {
            notifyObservers(name: Constants.notificationMissionMessage, object: message)
        }
    }
}
