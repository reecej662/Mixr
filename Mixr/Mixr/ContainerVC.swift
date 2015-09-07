//
//  ContainerVC.swift
//  Mixr
//
//  Created by Reece Jackson on 9/6/15.
//  Copyright (c) 2015 RJ. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    
    @IBOutlet var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFontAndColors()
        
        var background = UIImageView(frame: self.view.frame)
        background.image = UIImage(named: "background")
        container.addSubview(background)
        container.sendSubviewToBack(background)
    }

    func setUpFontAndColors() {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        self.navigationController?.navigationBar.barTintColor = colorWithHexString("#D54903")
        
        if let font = UIFont(name: "Pacifico", size: 20) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Pacifico", size: 34)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        } else if let font = UIFont(name: "Avenir", size: 34) {
            self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir", size: 24)!,  NSForegroundColorAttributeName: UIColor.whiteColor()]
            
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.destinationViewController.identifier)
    }
}
