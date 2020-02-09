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
        let myView = MyView(frame: CGRect(x:0,y:150,width: 500,height: 300))
           myView.backgroundColor = UIColor.white
           view.addSubview(myView)
        
        
        gravityposition = UILabel.init(frame: CGRect(x: 185, y: 180, width: gravitypositionSize.width, height: gravitypositionSize.height))
        gravityposition.text = "G"
        gravityposition.backgroundColor = .red
        gravityposition.textAlignment = .center
        myView.addSubview(gravityposition)
        
        //更新周期を設定する
        motionManager.accelerometerUpdateInterval = 0.1
                    
        let handler:CMDeviceMotionHandler = {(motionData:CMDeviceMotion?, error:Error?) -> Void in
            self.motionAnimation(motionData: motionData,error: error as NSError?)
        }
        
        //更新で実行するキューを登録してモーションセンサーをスタートする
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler:handler)
        }
        // Do any additional setup after loading the view.
    

    
    
    //デバイスモーションセンサーで定期的に実行するメソッド
    func motionAnimation(motionData:CMDeviceMotion?, error:NSError?){
        if let motion = motionData{
            //姿勢センサー(回転角度 ラジアン)
            //ピッチ(X軸回り回転角度)
            var pitch = motion.attitude.pitch
            pitch = round(pitch*100)/100
         //   pitchLabel.text = String(pitch)
            //ロール(Y軸回り回転角度)
            var roll = motion.attitude.roll
            roll = round(roll*100)/100
           // rollLabel.text = String(roll)
            //ヨー(Z軸回り回転角度)
            var yaw = motion.attitude.yaw
            yaw = round(yaw*100)/100
           // yawLabel.text = String(yaw)
            
            
        }
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
    func location
    
    func labelPositon(_ magneticHeading: CGFloat) -> CGPoint {
        if 0 < pitch < 0.2{
            gravityposition.frame =
            
        }
    }
    
   
}
