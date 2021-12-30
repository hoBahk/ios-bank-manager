//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = BankManagerView()
        let timer = Timer(timeInterval: 1.0, repeats: true) {
            print("\($0) test")
//            bank.currentTime += 1.0
        }
        RunLoop.current.add(timer, forMode: .common)
        
        timer.invalidate()
        print("resume")
        let timer2 = Timer(timeInterval: 1.0, repeats: true) {
            print("\($0) test")
//            bank.currentTime += 1.0
        }
        RunLoop.current.add(timer2, forMode: .common)
    }
}
