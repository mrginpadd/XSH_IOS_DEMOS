//
//  WBTabbarController.swift
//  xsh_demos
//
//  Created by xushihao on 2023/8/15.
//

import Foundation
import UIKit


class WBTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = UIScreen.main.bounds
        //设置安全区
        view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        setupViews()
        
    }
    
}

extension WBTabbarController {
    func setupViews() {
        let messageVC = WBTableViewController()
        let contactsVC = WBTableViewController()
        let newsVC = WBTableViewController()
        let meVC = WBTableViewController()
        
        let messageImage = UIImage(named: "tabbar_message")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)
        let messageImageUnselected = UIImage(named: "tabbar_message_unselected")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)

        let contactsImage = UIImage(named: "tabbar_contacts")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)
        let contactsImageUnselected = UIImage(named: "tabbar_contacts_unselected")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)
        let newsImage = UIImage(named: "tabbar_faxian")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)
        let newsImageUnselected = UIImage(named: "tabbar_faxian_unselected")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)
        let meImage = UIImage(named: "tabbar_me")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)
        let meImageUnselected = UIImage(named: "tabbar_me_unselected")?.sd_resizedImage(with: CGSize(width: 20, height: 20), scaleMode: .aspectFit)
        
        messageVC.tabBarItem = UITabBarItem(title: "消息", image: messageImage, selectedImage: messageImageUnselected)
        contactsVC.tabBarItem = UITabBarItem(title: "通讯录", image: contactsImage, selectedImage:  contactsImageUnselected)
        newsVC.tabBarItem = UITabBarItem(title: "发现", image: newsImage, selectedImage: newsImageUnselected)
        meVC.tabBarItem = UITabBarItem(title: "我的", image: meImage, selectedImage: meImageUnselected)
        
        viewControllers = [messageVC, contactsVC, newsVC, meVC]
        
    }
}
