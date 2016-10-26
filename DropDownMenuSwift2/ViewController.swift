//
//  ViewController.swift
//  DropDownMenuSwift2
//
//  Created by Marcos Paulo Rodrigues Castro on 26/10/16.
//  Copyright © 2016 HackTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var drop: DropMenuButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        drop.initMenu(["Item menu - A", "Item menu - B", "Item menu - C"], actions: [({ () -> (Void) in
            print("I'm doing the A action")
            }), ({ () -> (Void) in
            print("I'm doing the B action")
            }), ({ () -> (Void) in
            print("I'm doing the C action")
            })])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

