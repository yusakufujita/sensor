//
//  LineViewController.swift
//  Sensor
//
//  Created by 藤田優作 on 2020/01/29.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit

class LineViewController: UIViewController {
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
               let myView = MyView(frame: view.bounds)
               myView.backgroundColor = UIColor.white
               view.addSubview(myView)
       
        // Do any additional setup after loading the view.
    }
    class MyView: UIView {
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 90, y: 350))
            path.addLine(to:CGPoint(x: 300, y: 350))
           
            path.move(to: CGPoint(x: 195, y: 250))
            path.addLine(to:CGPoint(x: 195, y: 460))
            path.lineWidth = 5.0 // 線の太さ
            UIColor.black.setStroke() // 色をセット
            path.stroke()
        }
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


