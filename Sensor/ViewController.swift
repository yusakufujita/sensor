//
//  ViewController.swift
//  Sensor
//
//  Created by 藤田優作 on 2020/01/12.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var sensorLabel: UILabel!
    
    @IBAction func button(_ sender: Any) {
        sensorLabel.text = "計測中"
    }
   
    //CMMotionManagerのインスタンスを生成
    let motionManager = CMMotionManager()
    var circleView: UIView?
    var targetView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
            addCircleView()
        //プロパティでdevice-motion serviceが使用可能かチェックしています。
        guard motionManager.isDeviceMotionAvailable else { return }
        //100Hzを指定しています(1秒間に100回)。
        motionManager.deviceMotionUpdateInterval = 1 / 100
        //データの取得を開始します。データを取得したらwithHnadlerに指定したhandlerが実行されます。
        motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: OperationQueue.current!,withHandler: { [weak self] (motion, error) in
        guard let motion = motion, error == nil else { return }
        guard let strongSelf = self else { return }
        //外で定義する(class直下で宣言)
        var xAngle = motion.attitude.roll * 180 / Double.pi
        var yAngle = motion.attitude.pitch * 180 / Double.pi
                    //メソッドの外で宣言する
        var x = pow(xAngle, 2)
        var y = pow(xAngle, 2)
        //self?.judgment(x1: x, y1: y)
        // 係数を使って感度を調整する。
        let coefficient: CGFloat = 0.01
                    
       print("attitude pitch: \(motion.attitude.pitch * 180 / Double.pi)")
       print("attitude roll : \(motion.attitude.roll * 180 / Double.pi)")
       print("attitude yaw  : \(motion.attitude.yaw * 180 / Double.pi)")
        //更新周期を設定する
        self?.motionManager.accelerometerUpdateInterval = 0.1
        strongSelf.circleView?.addX(CGFloat(xAngle) * coefficient)
        strongSelf.circleView?.addY(CGFloat(yAngle) * coefficient)
            }
        )
        //5秒後に遷移する
      var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 5.0,
                                    target: self,
                                    selector: #selector(ViewController.judgment),
                                    userInfo: nil,
                                    repeats: false)
    }//viewDidLoad
    @objc func judgment(x1:Double, y1:Double) -> Void {
             //if文にする
             if x1+y1 < 1 {
              self.performSegue(withIdentifier: "Scene1", sender: nil)
             }else if x1+y1 < 2 {
              self.performSegue(withIdentifier: "Scene2", sender: nil)
             }else {
              self.performSegue(withIdentifier: "Scene3", sender: nil)
             }
    }

}//ViewController
       


       
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
    
  


 private extension ViewController  {
       // 動かすUIViewを追加する
          func addCircleView() {
            let myView = MyView(frame: CGRect(x:0,y:150,width: 500,height: 300))
            myView.backgroundColor = UIColor.white
            view.addSubview(myView)
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


