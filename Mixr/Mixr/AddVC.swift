//
//  AddVC.swift
//  Mixr
//
//  Created by Reece Jackson on 9/7/15.
//  Copyright (c) 2015 RJ. All rights reserved.
//

import UIKit

class AddVC: UIViewController {
   
    @IBOutlet var mainView: UIView!
    @IBOutlet var name: UITextField!
    @IBOutlet var imageName: UITextField!
    @IBOutlet var ingredientList: UITextView!
    @IBOutlet var directions: UITextView!
    @IBOutlet var saveButton: UIButton!

    @IBAction func save(sender: AnyObject) {
    }
    
    @IBAction func closeKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    func setUpUI() {
        mainView.layer.cornerRadius = 6
        saveButton.layer.cornerRadius = 6
    }
    
}
