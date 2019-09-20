//
//  Category.swift
//  Todoey
//
//  Created by ogi on 2019/09/20.
//  Copyright © 2019 Taichi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    var items = List<Item>()
}
