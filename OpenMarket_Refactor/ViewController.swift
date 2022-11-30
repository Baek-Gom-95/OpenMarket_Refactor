//
//  ViewController.swift
//  OpenMarket_Refactor
//
//  Created by Baek on 2022/11/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkNetWork()
    }

    
    func checkNetWork() {
        let networkManager = NetworkManager()
        
        networkManager.checkHealth(by: URLCollection.hostURL + URLCollection.healthChecker.string, completion: { (response) in
            switch response {
            case .success(let data):
                print(data)
            case .failure(let data):
                print(data)
            }
        })
    }

}

