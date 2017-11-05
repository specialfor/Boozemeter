//
//  FacebookSharer.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit
import FBSDKShareKit

class FacebookSharer: NSObject, Sharer {
    
    var title: String?
    var image: UIImage?
    
    required init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
    func share() {
        let content = FBSDKShareLinkContent()
        content.contentURL = URL(string: "https://www.facebook.com")
        
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            FBSDKShareDialog.show(from: vc, with: content, delegate: nil)
        }
    }
    
}
