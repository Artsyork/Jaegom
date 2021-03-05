//
//  TabBarExtention.swift
//  proc
//
//  Created by 성다연 on 02/09/2019.
//  Copyright © 2019 swuad-19. All rights reserved.
//

import UIKit

class TabBarExtention: UITabBarController {
    let button = UIButton(type: .custom)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if let newButton = UIImage(named: "calendartabicon"){
            self.addCenterButton(withImage: newButton,highlightImage: newButton)
        }
    }
    
    func addCenterButton(withImage buttonImage: UIImage, highlightImage : UIImage){
        let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 80, height: 80))
        button.setBackgroundImage(buttonImage, for: .normal)
        button.setBackgroundImage(highlightImage, for: .highlighted)

        let rectBoundTabbar = tabBar.bounds
        let xx = rectBoundTabbar.midX
        let yy = rectBoundTabbar.midY - tabBar.safeAreaInsets.bottom - 10
        
        button.center = CGPoint(x: xx, y: yy)
    
        tabBar.addSubview(button)
        tabBar.bringSubviewToFront(button)

        button.addTarget(self, action: #selector(handleTouchTabbarCenter), for: .touchUpInside)

        if let count = tabBar.items?.count {
            let i = floor(Double(count / 2))
            let item = tabBar.items![Int(i)]
            item.title = ""
        }
    }
    
    @objc func handleTouchTabbarCenter(sender: UIButton){
        if let count = tabBar.items?.count {
            let i = floor(Double(count/2))
            selectedViewController = viewControllers?[Int(i)]
        }
    }
}
