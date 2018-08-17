//
//  Category.swift
//  Todoey
//
//  Created by Allen Hou on 8/12/18.
//  Copyright © 2018 nEmmY. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
