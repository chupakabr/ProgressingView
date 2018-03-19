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

@IBDesignable
public class ProgressingView: UIControl {

    private var fgGradientLayer: CAGradientLayer? = nil
    private var bgGradientLayer: CAGradientLayer? = nil
    private var maskLayer: CAShapeLayer? = nil
    
    // MARK: - Inspectables

    @IBInspectable
    public var fgFromColor: UIColor! {
        didSet {
            createFgGradient()
        }
    }
    
    @IBInspectable
    public var fgToColor: UIColor! {
        didSet {
            createFgGradient()
        }
    }
    
    @IBInspectable
    public var bgFromColor: UIColor! {
        didSet {
            createBgGradient()
        }
    }
    
    @IBInspectable
    public var bgToColor: UIColor! {
        didSet {
            createBgGradient()
        }
    }
    
    @IBInspectable
    public var arc: CGFloat = 0.0 {
        didSet {
            if arc < 0.0 {
                arc = 0.0
            } 
        }
    }
    
    @IBInspectable
    public var progress: CGFloat = 0.5 {
        didSet {
            if progress > 1.0 {
                progress = 1.0
            } else if progress < 0.0 {
                progress = 0.0
            }
            
            setNeedsDisplay()
        }
    }

    // MARK: - Overrides

    public override func layoutSubviews() {
        super.layoutSubviews()

        createBgGradient()
        createFgGradient()
        setNeedsDisplay()
    }

    public override func draw(_ rect: CGRect) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let maskLayer = maskLayer {
            if arc != 0.0 && progress >= 1.0 {
                maskLayer.frame.origin.y = -arc
            } else {
                maskLayer.frame.origin.y = bounds.height * (1.0-progress)
            }
        }
        
        CATransaction.commit()
    }

    // MARK: - Private
    
    private func createMask() {
        let maskLayer = CAShapeLayer()
        
        var path: CGPath!
        
        if arc != 0.0 {
            var b = bounds
            b.size.width *= 2
            b.size.height *= 2
            b.origin.x -= b.size.width/4
            
            path = CGPath(roundedRect: b, cornerWidth: b.width/2, cornerHeight: arc, transform: nil)
        } else {
            path = CGPath(rect: bounds, transform: nil)
        }
        
        maskLayer.path = path
        maskLayer.frame = frame
        
        fgGradientLayer?.mask = maskLayer
        self.maskLayer = maskLayer
    }
    
    private func createBgGradient() {
        guard bgToColor != nil, bgFromColor != nil else {
            return
        }
        
        bgGradientLayer?.removeFromSuperlayer()
        
        let bg = CAGradientLayer()
        
        bg.frame = bounds
        bg.colors = [bgFromColor.cgColor, bgToColor.cgColor]
        
        bgGradientLayer = bg
        layer.insertSublayer(bg, at: 0) // bg
    }
    
    private func createFgGradient() {
        guard fgToColor != nil, fgFromColor != nil else {
            return
        }
        
        fgGradientLayer?.removeFromSuperlayer()
        
        let fg = CAGradientLayer()
        
        fg.frame = bounds
        fg.colors = [fgFromColor.cgColor, fgToColor.cgColor]
        
        fgGradientLayer = fg
        createMask()
        
        layer.addSublayer(fg)
    }
}
