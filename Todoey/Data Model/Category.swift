//
//  Category.swift
//  Todoey
//
//  Created by William Watkins on 22/10/2019.
//  Copyright © 2019 William Watkins. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
