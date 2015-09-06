//
//  DataManager.swift
//  Mixr
//
//  Created by Reece Jackson on 9/5/15.
//  Copyright (c) 2015 RJ. All rights reserved.
//

import Foundation
import Parse

class DataManager {
    var ingredients:[Ingredient]!
    
    func getIngredientsFromParse() -> [Ingredient] {
        ingredients.removeAll(keepCapacity: false)

        var query = PFQuery(className: "ingredients")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if(error == nil) {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                        var name = object["name"] as! String
                        self.ingredients.append(Ingredient(name: name, image: UIImage(named: name)!))
                        
                    }
                }
            }
        }

        return ingredients
    }
}