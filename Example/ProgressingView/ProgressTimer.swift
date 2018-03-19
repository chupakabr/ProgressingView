//
//  ProgressTimer.swift
//  ProgressingView_Example
//
//  Created by Alexander Kremer on 19/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

class ProgressTimer {
    private var timer: Timer? = nil
    private var timerRunning = false
    
    private(set) var timePassed = 0.0
    private var startTime = 0.0
    
    typealias CallbackType = (Double)->Void
    private var cb: CallbackType
    
    init(withCallback cb: @escaping CallbackType) {
        self.cb = cb
    }
    
    public func stop() {
        if timerRunning {
            timerRunning = false
        }
        
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    public func restart() {
        startTime = Date().timeIntervalSinceReferenceDate
        timePassed = 0
        
        if let timer = timer {
            timer.invalidate()
        }
        
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { t in
            if self.timerRunning {
                self.timePassed = Date().timeIntervalSinceReferenceDate - self.startTime
                
                self.cb(self.timePassed)
            }
        }
    }
}
