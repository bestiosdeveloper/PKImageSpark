//
//  ViewController.swift
//  PKImageSparkDemo
//
//  Created by Pramod Kumar on 07/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clickButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickMeTapped(_ sender: UIButton) {
        let confg = PKSparkConfiguration()
        confg.sparkOnView = self.view
        confg.sparkGenerationView = self.clickButton
        confg.totalNumberOfSparkImages = 15
        confg.sparkAnimation = .bubbleToUpSide
        
        let sparkAnimation = PKImageSpark(withImage: #imageLiteral(resourceName: "ic_love"), configuration: confg)
        sparkAnimation.startSparking()
    }
    
}

