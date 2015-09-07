//
//  DrinkDetailVC.swift
//  Mixr
//
//  Created by Reece Jackson on 9/7/15.
//  Copyright (c) 2015 RJ. All rights reserved.
//

import UIKit

class DrinkInfoVC: UIViewController {
    //var drink:Drink!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var addMoreButton: UIButton!
    
    @IBAction func addMore(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func heart(sender: AnyObject) {
        println("Hearted")
        var heartButton = sender as! UIButton
        heartButton.tintColor = colorWithHexString("#4A4A4A")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        /*if let drink = drink as Drink? {
            println(drink.name)
        }*/
    }
    
    func setUpUI() {
        mainView.layer.cornerRadius = 6
        addMoreButton.layer.cornerRadius = 6
    }
}
