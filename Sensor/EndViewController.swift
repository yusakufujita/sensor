//
//  EndViewController.swift
//  Sensor
//
//  Created by 藤田優作 on 2020/04/11.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBAction func startBack(_ sender: Any) {
        
        self.performSegue(withIdentifier: "startBack", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
