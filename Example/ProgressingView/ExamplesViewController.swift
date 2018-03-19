//
//  ExamplesViewController.swift
//  ProgressingView_Example
//
//  Created by Alexander Kremer on 19/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ProgressingView

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

class ExamplesViewController: UIViewController {

    @IBOutlet weak var progressingView1: ProgressingView!
    @IBOutlet weak var progressingView2: ProgressingView!
    @IBOutlet weak var progressingView3: ProgressingView!
    @IBOutlet weak var progressingView4: ProgressingView!

    private var timer: ProgressTimer!
    private lazy var arr = { return [progressingView1, progressingView2, progressingView3, progressingView4] }()
    
    private func randomize() {
        self.arr.forEach {
            $0?.progress = CGFloat(arc4random_uniform(100))/100.0
            $0?.bgFromColor = UIColor.random()
            $0?.fgFromColor = UIColor.random()
            $0?.bgToColor = UIColor.random()
            $0?.fgToColor = UIColor.random()
            $0?.arc = CGFloat(arc4random_uniform(150))
            $0?.borderWidth = CGFloat(arc4random_uniform(20))
            $0?.borderColor = UIColor.random()
            $0?.cornerRadius = CGFloat(arc4random_uniform(10))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = ProgressTimer() { timePassed in
            self.arr.forEach {
                $0?.progress = 1.0 - CGFloat(10.0-timePassed)/CGFloat(10.0)
            }
        }
    }

    @IBAction func onRunTimer(_ sender: UIButton) {
        timer.restart()
    }
    
    @IBAction func onRandomize(_ sender: UIButton) {
        timer.stop()
        randomize()
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
