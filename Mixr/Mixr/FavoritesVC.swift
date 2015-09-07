//
//  FavoritesVC.swift
//  Mixr
//
//  Created by Reece Jackson on 9/7/15.
//  Copyright (c) 2015 RJ. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var favoritesTable: UITableView!
    var dataManager:DataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        setUpTableView()
    }

    func setUpUI() {
        favoritesTable.layer.cornerRadius = 6
    }
    
    func setUpTableView() {
        favoritesTable.delegate = self
        favoritesTable.dataSource = self
        
        if(dataManager.favoriteDrinks.count == 0) {
            var tableFrame = favoritesTable.frame
            var emptyView = UIView(frame: CGRectMake(favoritesTable.frame.origin.x, favoritesTable.frame.origin.y, tableFrame.width + 50, tableFrame.height))
            
            var emptyLabel = UILabel(frame: CGRectMake(25, 50, 300, 300))
            emptyLabel.font = UIFont(name: "Avenir", size: 20)
            emptyLabel.textColor = colorWithHexString("#4B4B4B")
            emptyLabel.numberOfLines = 0
            emptyLabel.textAlignment = NSTextAlignment.Center
            emptyLabel.text = "You don't seem to have any favorites... Let's go find some new drinks"
            emptyView.addSubview(emptyLabel)
            
            favoritesTable.separatorStyle = .None
            favoritesTable.addSubview(emptyView)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.favoriteDrinks.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = favoritesTable.dequeueReusableCellWithIdentifier("favoriteCell") as! DrinkCell
        
        
        // Set all the properties here for each of the cell based on the user's favorite drinks
        
        return cell
        
    }
    
    // Support editing of the cells so the user can swipe to delete and change the order of the cells as they want


}
