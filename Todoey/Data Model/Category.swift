//
//  Category.swift
//  Todoey
//
//  Created by purnami indryaswari on 05/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object{
    @objc dynamic var name : String = ""
    let items = List<Item> ()
}
