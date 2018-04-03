//
//  ViewController.swift
//  PKFloatingButtonDemo
//
//  Created by Appinventiv on 06/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //        PKFloatingButton.shared.enableFloating(onView: nil, viewToExpand: nil, withImage: UIImage(named: "help_white"), onTapHandler: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        PKFloatingButton.shared.enableFloating(onView: self.view, viewToExpand: nil, withImage: #imageLiteral(resourceName: "help_white"), onTapHandler: nil)
    }
}

