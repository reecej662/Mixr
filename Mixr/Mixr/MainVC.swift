//
//  MainVC.swift
//  Mixr
//
//  Created by Reece Jackson on 9/5/15.
//  Copyright (c) 2015 RJ. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, DataListener {

    @IBOutlet var iHaveLabel: UILabel!
    @IBOutlet var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet var ingredientScrollView: UIScrollView!
    @IBOutlet var ingredientCollectionView: UICollectionView!
    var dataManager:DataManager!
    
    @IBAction func Go(sender: AnyObject) {
        dataManager.sortDrinksForUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpFontAndColors()
        setUpCollectionView()
        
        dataManager = DataManager(listener: self)
        println(self.parentViewController)
        
    }
    
    func dataFinished() {
        self.ingredientCollectionView.reloadData()
        println("Ingredient count \(dataManager.ingredients.count)")
        print("Reloaded data")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpFontAndColors() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        self.navigationController?.navigationBar.barTintColor = colorWithHexString("#D54903")
    
        if let font = UIFont(name: "Pacifico", size: 20) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Pacifico", size: 34)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        } else if let font = UIFont(name: "Avenir", size: 34) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir", size: 24)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
            
        }
    }
    
    func setUpCollectionView() {
        ingredientCollectionView.dataSource = self
        ingredientCollectionView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func setUpScrollView() {
        self.scrollViewHeight.constant = 80
        ingredientScrollView.pagingEnabled = true
    }
    
    
    ////// Data Source Stuff
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.ingredients.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = ingredientCollectionView.dequeueReusableCellWithReuseIdentifier("IngredientCell", forIndexPath: indexPath) as! IngredientCell
        cell.name.text = dataManager.ingredients[indexPath.row].name
        cell.ingredientImage.image = dataManager.ingredients[indexPath.row].image
        cell.layer.cornerRadius = 6
        return cell
        
    }
    
    ////// Delegate Stuff
    
    /*
    
    optional func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool
    optional func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    optional func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath)
    optional func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    optional func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool // called when the user taps on an already-selected item in multi-select mode
    */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if(dataManager.selectedIngredients.count == 0) {
            setUpScrollView()
            iHaveLabel.text = "And..."
        }
    
        if(dataManager.selectIngredient(indexPath.row)) {
            addIngredient(dataManager.ingredients[indexPath.row], number: dataManager.selectedIngredients.count)
        }
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })

        // Add the view to the scroll view
        println(indexPath.row)
        println("Selected ingredients count: \(dataManager.selectedIngredients.count)")
    }
    /*
    
    optional func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
    
    @availability(iOS, introduced=8.0)
    optional func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath)
    @availability(iOS, introduced=8.0)
    optional func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath)
    optional func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath)
    optional func collectionView(collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, atIndexPath indexPath: NSIndexPath)
    
    // These methods provide support for copy/paste actions on cells.
    // All three should be implemented if any are.
    optional func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool
    optional func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) -> Bool
    optional func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!)
    
    // support for custom transition layout
    optional func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout!
    */
    
    func addIngredient(ingredient: Ingredient, number: Int) {
        var numSelected:CGFloat = CGFloat(number)
        var dimensions:CGFloat = 75
        var offset:CGFloat = (20 * numSelected) + (dimensions * (numSelected - 1))
        var ingredientView = UIView(frame: CGRectMake(offset, 0, dimensions, dimensions))
        ingredientView.layer.cornerRadius = 6
        ingredientView.backgroundColor = UIColor.whiteColor()
        
        var drinkImageView = UIImageView(frame: CGRectMake(27.5, 10, 20, 40))
        drinkImageView.image = ingredient.image
        
        var drinkLabel = UILabel(frame: CGRectMake(0, 55, dimensions, 15))
        drinkLabel.text = ingredient.name
        drinkLabel.font = UIFont(name: "Avenir", size: 15)
        drinkLabel.textAlignment = .Center
        
        ingredientView.addSubview(drinkImageView)
        ingredientView.addSubview(drinkLabel)
        
        var contentSize = CGSizeMake(offset + dimensions + 10, ingredientScrollView.frame.height)
        ingredientScrollView.contentSize = contentSize
        ingredientScrollView.addSubview(ingredientView)
        
        if(contentSize.width > self.view.frame.width) {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.ingredientScrollView.contentOffset = CGPointMake(self.ingredientScrollView.contentSize.width - self.view.frame.width,0)
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "mix") {
            let drinkTableVC = segue.destinationViewController as! DrinkTableVC
            drinkTableVC.dataManager = self.dataManager
        } else if(segue.identifier == "favorite") {
            let favoriteTableVC = segue.destinationViewController as! FavoritesVC
            favoriteTableVC.dataManager = self.dataManager
        }
    }
}
