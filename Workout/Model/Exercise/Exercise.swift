//
//  Exercise.swift
//  Workout
//
//  Created by Allen Johnson on 3/12/18.
//  Copyright © 2018 Allen Johnson. All rights reserved.
//

import Foundation
import RealmSwift

class Exercise: Object {
    @objc dynamic var name = ""
    @objc dynamic var movement: Movement?
    let styles = List<Style>()
}
