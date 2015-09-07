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
    var userDrinks:[Drink] = []
    var favoriteDrinks:[Drink] = [] // Maybe store these into core data or figure out a place to put them
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
        var query = PFQuery(className: "Drinks")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if(error == nil) {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.drinks.append(Drink(object: object))
                    }
                    self.sortDrinksForUser()
                    self.listener.dataFinished()
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
    
    func sortDrinksForUser() {
        userDrinks.removeAll(keepCapacity: false)
        for drink in self.drinks {
            var haveDontHave:[Int] = numIngredientsInDrink(drink)
            
            // Implement a sorting algorithm here...
            
            var currentIndex = userDrinks.count
            userDrinks.append(drink)
            while(currentIndex != 0 && compareDrinks(userDrinks[currentIndex-1], drink2: userDrinks[currentIndex])) {
                userDrinks.removeAtIndex(currentIndex)
                userDrinks.insert(drink, atIndex: currentIndex-1)
                currentIndex--
            }
        }
        self.listener.dataFinished()
    }
    
    // Returns true if the second drink has fewer drinks than the first
    func compareDrinks(drink1: Drink, drink2: Drink) -> Bool {
        let drink1num:[Int] = numIngredientsInDrink(drink1)
        let drink2num:[Int] = numIngredientsInDrink(drink2)
        if(drink1num[0] > drink2num[0]) {
            return false
        } else if (drink1num[0] < drink2num[0]) {
            return true
        } else {
            if(drink1num[1] > drink2num[1]) {
                return true
            } else if(drink1num[1] < drink2num[1]) {
                return false
            }
        }
        return false
    }
    
    func userHasIngredient(ingredient: Ingredient) -> Bool {
        for selectedIngredient in selectedIngredients {
            if selectedIngredient.equals(ingredient) {
                return true
            }
        }
        return false
    }
    
    func userHasIngredient(ingredient: String) -> Bool {
        for selectedIngredient in selectedIngredients {
            if selectedIngredient.equals(ingredient) {
                return true
            }
        }
        return false
    }
    
    func getIngredients() -> [Ingredient]! {
        return ingredients
    }
    
    func getIngredientAtIndex(selectionIndex: Int) -> Ingredient {
        return ingredients[selectionIndex]
    }
    
    // Returns true if successful, else returns false
    func selectIngredient(selectionIndex: Int) -> Bool {
        if !contains(ingredients[selectionIndex], ingredientArray: selectedIngredients) {
            self.selectedIngredients.append(ingredients[selectionIndex])
            return true
        }
        return false
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
    
    func contains(ingredient: Ingredient, ingredientArray: [Ingredient]) -> Bool{
        for ingredientItem in ingredientArray {
            if ingredient.equals(ingredientItem) {
                return true
            }
        }
        return false
    }
    
}

protocol DataListener {
    func dataFinished()
}