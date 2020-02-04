//
//  ViewController.swift
//  Sensor
//
//  Created by 藤田優作 on 2020/01/12.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var sensorLabel: UILabel!
    //使用者の動揺を表すラベル
    var gravityposition: UILabel!
    //使用者の動揺を表すラベル大きさ
    let gravitypositionSize: CGSize = CGSize(width: 20, height: 20)
    
    //CMMotionManagerのインスタンスを生成
    let motionManager = CMMotionManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myView = MyView(frame: CGRect(x:0,y:90,width: 500,height: 300))
           myView.backgroundColor = UIColor.white
           view.addSubview(myView)
        
        
        gravityposition = UILabel.init(frame: CGRect(x: 185, y: 180, width: gravitypositionSize.width, height: gravitypositionSize.height))
        gravityposition.text = "G"
        gravityposition.backgroundColor = .red
        gravityposition.textAlignment = .center
        myView.addSubview(gravityposition)
        
        //更新周期を設定する
        motionManager.accelerometerUpdateInterval = 0.1
                    
        
        // Do any additional setup after loading the view.
    }

    @IBAction func button(_ sender: Any) {
        
        
        
    }
    class MyView: UIView {
           override func draw(_ rect: CGRect) {
               let path = UIBezierPath()
               
               path.move(to: CGPoint(x: 90, y: 190))
               path.addLine(to:CGPoint(x: 300, y: 190))
              
               path.move(to: CGPoint(x: 195, y: 85))
               path.addLine(to:CGPoint(x: 195, y: 295))
               path.lineWidth = 5.0 // 線の太さ
               UIColor.black.setStroke() // 色をセット
               //線を点線にする
               path.setLineDash([4.0,2.0], count: 2, phase: 0.0)
               path.stroke()
           }
       }
    //モーションデータの取得を開始
  /* func startSensorUpdates(intervalSeconds:Double) {
       if motionManager.isDeviceMotionAvailable{
           motionManager.deviceMotionUpdateInterval = intervalSeconds

           motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
               self.getMotionData(deviceMotion: motion!)

           })
       }
   }*/

   //モーションデータの取得(例としてコンソールへ出力)
   /* func getMotionData(deviceMotion:CMDeviveMotion) {
        print("attitudeX:", deviceMotion.attitude.pitch)
        print("attitudeY:", deviceMotion.attitude.roll)
        print("attitudeZ:", deviceMotion.attitude.yaw)
        print("gyroX:", deviceMotion.rotationRate.x)
        print("gyroY:", deviceMotion.rotationRate.y)
        print("gyroZ:", deviceMotion.rotationRate.z)
        print("gravityX:", deviceMotion.gravity.x)
        print("gravityY:", deviceMotion.gravity.y)
        print("gravityZ:", deviceMotion.gravity.z)
        print("accX:", deviceMotion.userAcceleration.x)
        print("accY:", deviceMotion.userAcceleration.y)
        print("accZ:", deviceMotion.userAccelaration.z)
    }*/
    
 
 
}
