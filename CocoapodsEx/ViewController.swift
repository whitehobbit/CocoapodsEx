//
//  ViewController.swift
//  CocoapodsEx
//
//  Created by White Hobbit on 2017. 1. 11..
//  Copyright © 2017년 WhiteHobbit. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url: URL = URL(string: "http://ec2-52-78-237-16.ap-northeast-2.compute.amazonaws.com:8080/simple")!
        getJSON(url)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getJSON(_ url: URL) {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

