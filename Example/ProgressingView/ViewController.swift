// The MIT License
//
// Copyright (c) 2018 7bit (Alex Kremer, Valera Chevtaev)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import ProgressingView

class ViewController: UIViewController {

    @IBOutlet var progressingOverlay: ProgressingView!
    @IBOutlet var stepper: UIStepper!
    
    private var timer: ProgressTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = ProgressTimer() { timePassed in
            let progress = 1.0 - CGFloat(10.0-timePassed)/CGFloat(10.0)
            self.progressingOverlay.progress = progress
            
            if progress >= 1.0 {
                self.timer.stop()
            }
        }
        
        self.progressingOverlay.progress = self.currentProgress
    }

    @IBAction func updateProgress(sender: UIStepper) {
        timer.stop()
        self.progressingOverlay.progress = self.currentProgress
    }

    @IBAction func onTimerTest(_ sender: Any) {
        progressingOverlay.progress = 0.0
        timer.restart()
    }
    
    private var currentProgress: CGFloat {
        return CGFloat(self.stepper.value / self.stepper.maximumValue)
    }
}
