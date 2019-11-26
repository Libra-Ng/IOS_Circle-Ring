//
//  ViewController.swift
//  ios-exam-6
//
//  Created by liushangwei on 2019/11/18.
//  Copyright © 2019 zhouhaijian. All rights reserved.
//

import UIKit



class Circle: UIView {

    var h = 0
    func setup(){
        //pinch--缩放
        let pinchGesturer = UITapGestureRecognizer(target: self, action: #selector(pinch(recognizer:)))
        self.addGestureRecognizer(pinchGesturer);
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    //缩放
    @objc func pinch(recognizer: UIPinchGestureRecognizer){
       
       
        if h >= 280 {
            h = 0
        }
        else{
             h += 20
        }
        
        setNeedsDisplay()
    
    }
    
    override func draw(_ rect: CGRect) {
        
        
        
        let cil = UIBezierPath(rect: CGRect(x: 0, y:  h , width: 280, height: 280-h))
            
        UIColor.clear.setFill()
            
        cil.fill()
        
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 280, height: 280))
        
        path.lineWidth = 5.0
        
        UIColor.red.setFill()
        
        cil.addClip()
        
        path.fill()
        
    }

}



class Circle_ring: UIView {
    var flag = false
    var a:CGFloat = 0
    func setup(){
        //pan--移动
        let panGesturer = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        self.addGestureRecognizer(panGesturer);
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    //移动
    @objc func pan(recognizer: UIPanGestureRecognizer){
        
        switch recognizer.state {
        case .began,.changed,.ended:
            let translation = recognizer.translation(in: self)
            
            self.center.x += translation.x
            self.center.y += translation.y
            
            recognizer.setTranslation(CGPoint.zero, in: self)
        default:
            break
        }
        flag = true
        a += 0.05
        setNeedsDisplay()
    }
    
    // 缩放比例
    var scale: CGFloat = 0.9
    
    override func draw(_ rect: CGRect) {
        if flag {
            
            let path = UIBezierPath()
            var endAngle: CGFloat = 2 * CGFloat.pi - a
            if endAngle <= 0 {
                endAngle = 0
            }
            path.addArc(withCenter: CGPoint(x: self.bounds.midX, y: self.bounds.midY), radius: min(bounds.width / 2, bounds.height / 2)*scale, startAngle: 0, endAngle: endAngle, clockwise: true)
            
            path.lineWidth = 5.0
            
            UIColor.red.set()
            
            path.stroke()
            
        } else {
            let path = UIBezierPath()
            path.addArc(withCenter: CGPoint(x: self.bounds.midX, y: self.bounds.midY), radius: min(bounds.width / 2, bounds.height / 2)*scale, startAngle: 0, endAngle: CGFloat(2 * CGFloat.pi), clockwise: true)
            path.lineWidth = 5.0
            
            UIColor.red.set()
            
            path.stroke()
        }
    }
    
    
}




class ViewController: UIViewController{

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        super.didReceiveMemoryWarning()
               // Dispose of any resources that can be recreated.
               let r1 = Circle(frame: CGRect(x: 20, y: 380, width: 300, height: 300))
        r1.backgroundColor = UIColor.clear
               view.addSubview(r1)
               
               let r2 = Circle_ring(frame: CGRect(x: 20, y: 30, width: 300, height: 300))
        r2.backgroundColor = UIColor.clear
               view.addSubview(r2)
        
    }
    override func didReceiveMemoryWarning() {
       
    }
    


}

