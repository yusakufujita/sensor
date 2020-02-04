//
//  TestUIViewController.swift
//  Sensor
//
//  Created by 藤田優作 on 2020/01/25.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import CoreLocation

class TestUIViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var label: UILabel!
    //ロケーションマネージャ
    var locationManager:CLLocationManager!
    //北を指すラベル
    var northLabel: UILabel!
    //円の半径
    let circleRadius: CGFloat = 150
    //北ラベルのサイズ
    let northSize: CGSize = CGSize(width: 20, height: 20)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ロケーションマネージャ生成
        locationManager = CLLocationManager()
        //ロケーションマネージャのデリゲート設定
        locationManager.startUpdatingHeading()
        //角度の取得開始
        locationManager.startUpdatingHeading()
        
        //北を指すラベルの生成
        northLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: northSize.width, height: northSize.height))
        northLabel.text = "N"
        northLabel.backgroundColor = .red
        northLabel.textAlignment = .center
        view.addSubview(northLabel)
        //円の描画
        let circleRadius: CGFloat = 150
        let circleLayer = CAShapeLayer.init()
        let circleFrame = CGRect.init(x: view.center.x - circleRadius / 2,
                                      y: view.center.y - circleRadius / 2,
                                      width: circleRadius,
                                      height: circleRadius)
        circleLayer.frame = circleFrame
        
        //輪郭の色
        circleLayer.strokeColor = UIColor.black.cgColor
        //円の中の色
        circleLayer.fillColor = UIColor.white.cgColor
        //輪郭の太さ
        circleLayer.lineWidth = 2.5
        //円形を描画
        circleLayer.path = UIBezierPath.init(ovalIn: CGRect.init(x: 0,y: 0,
                                                                      width: circleRadius,
                                                                      height: circleRadius)).cgPath
        view.layer.addSublayer(circleLayer)        // Do any additional setup after loading the view.
    }
    

    //角度の更新で呼び出されるデリゲートメソッド
     func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
          //方位出力デバッグ用
        label.text = String(Int(newHeading.magneticHeading)) + "度"
        
        //方位から円状の位置の算出
        let point = labelPosition(CGFloat(newHeading.magneticHeading))
        //北ラベルの移動
        northLabel.frame = CGRect(x: point.x, y: point.y, width: northSize.width, height: northSize.height)
       }
    func labelPosition(_ magneticHeading: CGFloat) -> CGPoint {
        
        //北角度(ラジアン)
        let northAngle = 360.0 - magneticHeading
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var isPlusX = false
        var isPlusY = false
        if northAngle < 90 {
            //0~89度
            x = sin(toRadian(northAngle)) * circleRadius / 2
            y = cos(toRadian(northAngle)) * circleRadius / 2
            isPlusX = true
            isPlusY = false
        } else if northAngle < 180 {
            //90~179度
            x = cos(toRadian(northAngle - 90.0)) * circleRadius / 2
            y = sin(toRadian(northAngle - 90.0)) * circleRadius / 2
            isPlusX = true
            isPlusY = true
        } else if northAngle < 270 {
            //180~269度
            x = sin(toRadian(northAngle - 180.0)) * circleRadius / 2
            y = cos(toRadian(northAngle - 180.0)) * circleRadius / 2
            isPlusX = false
            isPlusY = true
        } else {
            //270~359度
            x = cos(toRadian(northAngle - 270.0)) * circleRadius / 2
            y = sin(toRadian(northAngle - 270.0)) * circleRadius / 2
        }
        
        let point: CGPoint = CGPoint.init(x: view.center.x + (isPlusX ? 1 : -1) * x - northSize.width / 2,
                                          y: view.center.y + (isPlusY ? 1 : -1) * y)
        return point
    }
    
    //角度からラジアンに変換
    func toRadian(_ angle: CGFloat) -> CGFloat {
        return angle * CGFloat.pi / 180
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
