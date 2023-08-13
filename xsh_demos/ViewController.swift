//
//  ViewController.swift
//  xsh_demos
//
//  Created by xushihao on 2023/8/6.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showWBTableView()
    }
    
    func showWBTableView() {
        let wbTableViewController = WBTableViewController()
        addChild(wbTableViewController)
        wbTableViewController.view.frame = view.bounds
        view.addSubview(wbTableViewController.view)
        wbTableViewController.didMove(toParent: self)
//        wbTableViewController.didMove(toParentViewController: self)
    }

}

