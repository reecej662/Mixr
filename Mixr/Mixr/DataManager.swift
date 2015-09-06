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
    var ingredients:[Ingredient] = []
    var selectedIngredients:[Ingredient] = []
    var drinks:[Drink] = []
    var listener:DataListener
    
    init(listener: DataListener) {
        self.listener = listener
        getIngredientsFromParse()
        getDrinksFromParse()
    }
    
    func getIngredientsFromParse() {
        var query = PFQuery(className:"Ingredients")
        query.orderByAscending("name")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if(error == nil) {
                println("Object count \(objects!.count)")
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.ingredients.append(Ingredient(object: object))
                    }
                    self.listener.dataFinished()
                }
            }
        }
    }
    
    func getDrinksFromParse() {
        var query = PFQuery(className: "drinks")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if(error == nil) {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.drinks.append(Drink(object: object))
                    }
                }
            }
        }
    }
    
    func numIngredientsInDrink(drink: Drink) -> [Int] {
        var total = drink.ingredients.count
        var have = 0
        var dontHave = total
        
        for drinkIngredient in drink.ingredients {
            for selectedIngredient in selectedIngredients {
                if selectedIngredient.equals(drinkIngredient) {
                    have++
                    dontHave--
                }
            }
        }
        
        return [have, dontHave]
    }
    
    func getIngredients() -> [Ingredient]! {
        return ingredients
    }
    
    func getIngredientAtIndex(selectionIndex: Int) -> Ingredient {
        return ingredients[selectionIndex]
    }
    
    func selectIngredient(selectionIdex: Int) {
        self.selectedIngredients.append(ingredients[selectionIdex])
    }
    
    func getSelectedIngredients() -> [Ingredient]! {
        return selectedIngredients
    }
    
    func getDrink(selectionIndex: Int) -> Drink {
        return drinks[selectionIndex]
    }
    
    func setDataListener(listener: DataListener) {
        self.listener = listener
    }
    
}

protocol DataListener {
    func dataFinished()
}