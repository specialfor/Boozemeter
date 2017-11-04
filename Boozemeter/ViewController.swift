//
//  ViewController.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/4/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

import TwitterKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showComposer()
    }
    
    func showComposer() {
        let composer = TWTRComposer()
        
        composer.setText("just setting up my Twitter Kit")
        //        composer.setImage(UIImage(named: "twitterkit"))
        
        // Called from a UIViewController
        composer.show(from: self) { (result) in
            if (result == .done) {
                print("Successfully composed Tweet")
            } else {
                print("Cancelled composing")
            }
        }
    }
    
}

