//
//  ViewController.swift
//  PieChart
//
//  Created by Shengkun Wei on 1/8/17.
//  Copyright © 2017 amy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pieView: PieView!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieView.progress = slider.value
        
        
        
    }

    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        pieView.progress = sender.value
    }

}

