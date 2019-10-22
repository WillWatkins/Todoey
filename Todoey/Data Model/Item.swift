//
//  Item.swift
//  Todoey
//
//  Created by William Watkins on 22/10/2019.
//  Copyright © 2019 William Watkins. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date? 
    var parentCatgeory = LinkingObjects(fromType: Category.self, property: "items")
    
}
