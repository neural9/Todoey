//
//  Category.swift
//  Todoey
//
//  Created by Robert Ellis on 24/01/2019.
//  Copyright © 2019 Robert Ellis. All rights reserved.
//

import Foundation

import RealmSwift

class Category: Object{
    @objc dynamic var name : String = ""
    @objc dynamic var cellColour : String = ""
    
    let items = List<Item>()
}
