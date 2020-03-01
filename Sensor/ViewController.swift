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
    
    @IBAction func button(_ sender: Any) {
        
    }
    //    //使用者の動揺を表すラベル
//    var gravityposition: UILabel!
//    //使用者の動揺を表すラベル大きさ
//    let gravitypositionSize: CGSize = CGSize(width: 20, height: 20)
    //CMMotionManagerのインスタンスを生成
    let motionManager = CMMotionManager()
    private weak var circleView: UIView?
    private weak var targetView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        addCircleView()
        //プロパティでdevice-motion serviceが使用可能かチェックしています。
        guard motionManager.isDeviceMotionAvailable else { return }
        //100Hzを指定しています(1秒間に100回)。
        motionManager.deviceMotionUpdateInterval = 1 / 100
        //データの取得を開始します。データを取得したらwithHnadlerに指定したhandlerが実行されます。
        motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: OperationQueue.current!,
                   withHandler: { [weak self] (motion, error) in
        guard let motion = motion, error == nil else { return }
        guard let strongSelf = self else { return }
        let xAngle = motion.attitude.roll * 180 / Double.pi
        let yAngle = motion.attitude.pitch * 180 / Double.pi
        
        // 係数を使って感度を調整する。
        let coefficient: CGFloat = 0.05
                   
       print("attitude pitch: \(motion.attitude.pitch * 180 / Double.pi)")
       print("attitude roll : \(motion.attitude.roll * 180 / Double.pi)")
       print("attitude yaw  : \(motion.attitude.yaw * 180 / Double.pi)")
       
        //タイマーを作成する
        //5秒で繰り返して、終わる
//               Timer.scheduledTimer(
//                timeInterval: 0.1,//繰り返す間隔(秒)
//                   target: self,
//                   selector: #selector(self.labelPositon),
//                   userInfo: nil,
//                   repeats: true
//
//               )
//
        //更新周期を設定する
                    self?.motionManager.accelerometerUpdateInterval = 0.1
                    
//        let handler:CMDeviceMotionHandler = {(motionData:CMDeviceMotion?, error:Error?) -> Void in
//            self.motionAnimation(motionData: motionData,error: error as NSError?)
//        }
        //更新で実行するキューを登録してモーションセンサーをスタートする
//            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler:handler)
        strongSelf.circleView?.addX(CGFloat(xAngle) * coefficient)
        strongSelf.circleView?.addY(CGFloat(yAngle) * coefficient)
        })
           }
       }

  
    
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
    
    //タイマーから定期的に呼び出されるメソッド
//    @objc func labelPositon() {
//        var frame:CGRect = self.frame
//        frame.origin.x += x
//        if let superViewFrame = superview?.frame {
//            if superViewFrame.minX > frame.origin.x {
//                frame.origin.x = superViewFrame.minX
//            } else if superViewFrame.maxX - frame.width < frame.origin.x {
//                frame.origin.x = superViewFrame.maxX - frame.width
//            }
//        }
//        self.frame = frame
//    }
//        var frame:CGRect = self.frame
//        frame.origin.y += y
//        if let superViewFrame = superview?.frame {
//            if superViewFrame.minY > frame.origin.y {
//            frame.origin.y = superViewFrame.minY
//        } else if superViewFrame.maxY - frame.height < frame.origin.y {
//            frame.origin.y = superViewFrame.maxY - frame.height
//        }
//    }
//    self.frame = frame


 extension ViewController  {
       // 動かすUIViewを追加する
          func addCircleView() {
            let myView = MyView(frame: CGRect(x:0,y:150,width: 500,height: 300))
            myView.backgroundColor = UIColor.white
            view.addSubview(myView)
            //動かすgravitypositionを追加する
//            gravityposition = UILabel.init(frame: CGRect(x: 185, y: 180, width: gravitypositionSize.width, height: gravitypositionSize.height))
//            gravityposition.text = "G"
//            gravityposition.backgroundColor = .red
//            gravityposition.textAlignment = .center
//            myView.addSubview(gravityposition)
            let size: CGFloat = 32.0
            let circleView = UIView()
            circleView.frame = CGRect(x:180, y:320 ,width: size, height:size)
            circleView.backgroundColor = UIColor.red
            circleView.layer.cornerRadius = size / 2
            
            self.view.addSubview(circleView)
            self.circleView = circleView
            
          }
       
   }
extension UIView {
    /// X方向にViewを動かす
    func addX(_ x: CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x += x
        if let superViewFrame = superview?.frame {
            if superViewFrame.minX > frame.origin.x {
                frame.origin.x = superViewFrame.minX
            } else if superViewFrame.maxX - frame.width < frame.origin.x {
                frame.origin.x = superViewFrame.maxX - frame.width
            }
        }
        self.frame = frame
    }
 
    /// Y方向にViewを動かす
    func addY(_ y: CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y += y
        if let superViewFrame = superview?.frame {
            if superViewFrame.minY > frame.origin.y {
                frame.origin.y = superViewFrame.minY
            } else if superViewFrame.maxY - frame.height < frame.origin.y {
                frame.origin.y = superViewFrame.maxY - frame.height
            }
        }
        self.frame = frame
    }
    
}

