//
//  DrinkTableVC.swift
//  Mixr
//
//  Created by Reece Jackson on 9/6/15.
//  Copyright (c) 2015 RJ. All rights reserved.
//

import UIKit

class DrinkTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DataListener {
   
    @IBOutlet var addMoreButton: UIButton!
    @IBOutlet var drinkTable: UITableView!
    var dataManager:DataManager!
    
    @IBAction func addMore(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(dataManager != nil) {
            dataManager.listener = self
        }
        setUpTableView()
        setUpUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        drinkTable.reloadData()
    }
    
    func dataFinished() {
        drinkTable.reloadData()
    }
    
    func setUpTableView() {
        drinkTable.delegate = self
        drinkTable.dataSource = self
    }
    
    func setUpUI() {
        addMoreButton.layer.cornerRadius = 6
        drinkTable.layer.cornerRadius = 6
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    // Data source stuff
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("Drink number: \(dataManager.drinks.count)")
        return dataManager.drinks.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = drinkTable.dequeueReusableCellWithIdentifier("drinkCell") as! DrinkCell
        
        var drink:Drink = dataManager.getDrink(indexPath.row)
        
        cell.drinkName.text = drink.name
        cell.drinkImage.image = drink.image

        var ingredientList:String = ""
        if(drink.ingredients.count < 4 && drink.ingredients.count > 0) {
            for ingredient in drink.ingredients {
                ingredientList = ingredientList + "\(ingredient.name)\n"
            }
        } else if(drink.ingredients.count == 0){
            ingredientList = "No ingredients found"
        }else {
            for(var i = 0; i < 3; i++) {
                ingredientList = "\(drink.ingredients[0])\n\(drink.ingredients[1])\nAnd more..."
            }
        }
        
        cell.ingredientList.text = ingredientList
        cell.ingredientList.sizeToFit()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("User selected: \(dataManager.drinks[indexPath.row].name)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*optional func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is 1 if not implemented
    
    optional func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    optional func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?
    
    // Editing
    
    // Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
    optional func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    
    // Moving/reordering
    
    // Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
    optional func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    
    // Index
    
    optional func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    optional func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int // tell table which section corresponds to section title/index (e.g. "B",1))
    
    // Data manipulation - insert and delete support
    
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    optional func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    
    // Data manipulation - reorder / moving support
    
    optional func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
*/
}
