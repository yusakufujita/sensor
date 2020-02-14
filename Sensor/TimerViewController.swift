//
//  TimerViewController.swift
//  Sensor
//
//  Created by 藤田優作 on 2020/02/13.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    //値
    @IBOutlet weak var car: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //タイマーを作成する
        Timer.scheduledTimer(
            timeInterval: 0.1,//繰り返す間隔(秒)
            target: self,
            selector: #selector(self.stop),
            userInfo: nil,
            repeats: true
            
        )
    }
        //タイマーから定期的に呼び出されるメソッド
       @objc func stop() {
            //水平方向へ移動
            car.center.x += 10
            //右辺から外へ出たら
            let carwidth = car.bounds.width
            if car.center.x>(view.bounds.width + carwidth/2) {
                //左辺の手前に戻す
                car.center.x = -carwidth
                //y座標軸はランダムな高さに変更
                let viewH = view.bounds.height
                car.center.y = CGFloat(arc4random_uniform(UInt32(viewH)))
                
            }
        }
        
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


