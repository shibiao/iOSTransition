//
//  ViewController.swift
//  Demo
//
//  Created by sycf_ios on 2017/5/18.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerTransitioningDelegate {
    let customPresentionController = CustomPresentationController(direction: .top)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let toVC = segue.destination as UIViewController
            toVC.transitioningDelegate = self
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentionController
    }
}

