//
//  TwitterSharer.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterSharer: Sharer {
    
    var title: String?
    var image: UIImage?
    
    required init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    func share() {
        let composer = TWTRComposer()
        
        composer.setText(title)
        composer.setImage(image)
        
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            composer.show(from: vc) { (result) in
                if (result == .done) {
                    print("Successfully composed Tweet")
                } else {
                    print("Cancelled composing")
                }
            }
        }
    }
}
