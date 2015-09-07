//
//  Structs.swift
//  Mixr
//
//  Created by Reece Jackson on 9/5/15.
//  Copyright (c) 2015 RJ. All rights reserved.
//

import Foundation
import UIKit
import Parse

struct Ingredient {
    var name:String
    var image:UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    init(object: PFObject) {
        self.name = object["name"] as! String
        self.image = UIImage(named: object["image"] as! String)!
    }
    
    func equals(ingredient: Ingredient) -> Bool {
        return ingredient.name == self.name ? true : false
    }
}

struct Drink {
    var name:String
    var ingredients:[Ingredient]
    var image:UIImage
    var instructions:String
    
    init(name: String, ingredients: [Ingredient], image: UIImage, instructions: String) {
        self.name = name
        self.ingredients = ingredients
        self.image = image
        self.instructions = instructions
    }
    
    init(object: PFObject) {
        self.name = object["name"] as! String
        self.image = UIImage(named: object["image"] as! String)!
        self.instructions = "Blank for now" //object["instructions"] as! String
        self.ingredients = []
    
        let ingredientRelation = object["ingredients"] as! PFRelation
        let ingredientQuery = ingredientRelation.query()
        ingredientQuery?.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects as? [PFObject] {
                for object in objects {
                    self.ingredients.append(Ingredient(object: object))
                }
            }
        })
    }
        
}