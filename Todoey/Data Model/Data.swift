//
//  Data.swift
//  Todoey
//
//  Created by ogi on 2019/09/20.
//  Copyright © 2019 Taichi. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
