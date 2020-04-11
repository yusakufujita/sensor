//
//  Scene1ViewController.swift
//  Sensor
//
//  Created by 藤田優作 on 2020/03/03.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import CoreMotion

class Scene1ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    
    var a = ViewController.judgment
     let motionManager = CMMotionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        stopAccelerometer()
        // Do any additional setup after loading the view.
    }

    // センサー取得を止める場合
    func stopAccelerometer(){
        if (motionManager.isAccelerometerActive) {
            motionManager.stopAccelerometerUpdates()
        }
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
