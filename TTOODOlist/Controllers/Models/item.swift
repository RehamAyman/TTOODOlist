//
//  item.swift
//  TTOODOlist
//
//  Created by Reham Ayman on 6/23/20.
//  Copyright © 2020 Reham Ayman. All rights reserved.
//

import Foundation
import RealmSwift
class Item : Object  {
    @objc dynamic var itemTitle : String = ""
     @objc dynamic var done : Bool = false
    @objc dynamic var dateOfCreation : Date?
    
    
    
    // relationship with mainitem
    var mainitemrel  = LinkingObjects(fromType: MainItem.self, property: "itemsRel")
}
