//
//  PHCProgressBar.swift
//  FBSnapshotTestCase
//
//  Created by Scott Chou on 2018/6/28.
//

import UIKit

@IBDesignable
public class PHCProgressBar: UIControl {

    public enum Direction {
        case left
        case right
    }

    public var direction: Direction = .left {
        didSet {
            switch direction {
            case .left:
                topLabel.textAlignment = .left
                bottomLabel.textAlignment = .left
                topLabel.lineBreakMode = .byClipping
                bottomLabel.lineBreakMode = .byClipping
            case .right:
                topLabel.textAlignment = .right
                bottomLabel.textAlignment = .right
                topLabel.lineBreakMode = .byTruncatingHead
                bottomLabel.lineBreakMode = .byTruncatingHead
            }
            setNeedsLayout()
        }
    }

    @IBInspectable
    public var circleBackgroundColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    public var circleBorderColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    public var circleBorderWidth: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var barBackgroundColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    public var barBorderColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    public var barBorderWidth: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable
    public var barCornerRadius: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    public var barHeightRatio: Float? {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var circleText: String? {
        didSet {
            circleLabel.text = circleText
            setNeedsLayout()
        }
    }

    @IBInspectable
    public var topText: String? {
        didSet {
            topLabel.text = topText
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    @IBInspectable
    public var bottomText: String? {
        didSet {
            bottomLabel.text = bottomText
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable
    public var circleFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            circleLabel.font = circleFont
            setNeedsLayout()
            setNeedsLayout()
        }
    }

    @IBInspectable
    public var topFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            topLabel.font = topFont
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable
    public var bottomFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            bottomLabel.font = bottomFont
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable
    public var circleTextColor: UIColor = UIColor.black {
        didSet {
            circleLabel.textColor = circleTextColor
        }
    }

    @IBInspectable
    public var topTextColor: UIColor = UIColor.black {
        didSet {
            topLabel.textColor = topTextColor
        }
    }

    @IBInspectable
    public var bottomTextColor: UIColor = UIColor.gray {
        didSet {
            bottomLabel.textColor = bottomTextColor
        }
    }

    @IBInspectable
    public var progressTintColor: UIColor = UIColor.blue {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable
    public var progress: Float = 0 {
        didSet {
            if progress > 1 {
                progress = 1
            } else if progress < 0 {
                progress = 0
            }
            setNeedsDisplay()
        }
    }

    private let barTailPadding: CGFloat = 6

    private let circleLabel = UILabel()
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()

    public override var intrinsicContentSize: CGSize {
        let topSize = topLabel.intrinsicContentSize
        let bottomSize = bottomLabel.intrinsicContentSize

        return CGSize(width: frame.height + max(topSize.width, bottomSize.width) + barTailPadding, height: UIViewNoIntrinsicMetric)
    }

    public override var isHighlighted: Bool {
        didSet {
            alpha = self.isHighlighted ? 0.8 : 1
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        addSubview(circleLabel)
        addSubview(topLabel)
        addSubview(bottomLabel)

        circleLabel.textAlignment = .center
        circleLabel.lineBreakMode = .byClipping
        circleLabel.font = circleFont
        circleLabel.textColor = circleTextColor

        direction = .left
        topLabel.font = topFont
        topLabel.textColor = topTextColor
        bottomLabel.font = bottomFont
        bottomLabel.textColor = bottomTextColor
    }

    public override func draw(_ rect: CGRect) {
        print("redraw")
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let circleDiameter = rect.height - 2

        let topSize = topLabel.intrinsicContentSize
        let bottomSize = bottomLabel.intrinsicContentSize
        let barHeight: CGFloat = (barHeightRatio != nil) ? rect.height * CGFloat(barHeightRatio ?? 0) : topSize.height + bottomSize.height

        switch direction {
        case .left:
            let circleRect = CGRect(x: 1, y: 1, width: circleDiameter, height: circleDiameter)
            drawRightBar(onContext: context, circleRect: circleRect, barHeight: barHeight, rect: rect)
            drawCircle(onContext: context, rect: circleRect)
        case .right:
            let circleRect = CGRect(x: rect.width - 1 - circleDiameter, y: 1, width: circleDiameter, height: circleDiameter)
            drawLeftBar(onContext: context, circleRect: circleRect, barHeight: barHeight, rect: rect)
            drawCircle(onContext: context, rect: circleRect)
        }
    }

    public override func layoutSubviews() {
        let circleDiameter = bounds.height - 2
        let circleLabelWidth = circleLabel.intrinsicContentSize.width < circleDiameter ? circleLabel.intrinsicContentSize.width : circleDiameter
        let circleLabelAddedX = (circleDiameter - circleLabelWidth) / 2

        let topSize = topLabel.intrinsicContentSize
        let bottomSize = bottomLabel.intrinsicContentSize

        let labelWidth = bounds.width - bounds.height - barTailPadding

        switch direction {
        case .left:
            circleLabel.frame = CGRect(x: 1 + circleLabelAddedX, y: (bounds.height - circleLabel.intrinsicContentSize.height) / 2, width: circleLabelWidth, height: circleLabel.intrinsicContentSize.height)
            if bottomSize.height == 0 {
                topLabel.frame = CGRect(x: bounds.height, y: (bounds.height - topSize.height) / 2, width: labelWidth, height: topSize.height)
            } else {
                let barMinY = (bounds.height - (topSize.height + bottomSize.height)) / 2
                topLabel.frame = CGRect(x: bounds.height, y: barMinY, width: labelWidth, height: topSize.height)
                bottomLabel.frame = CGRect(x: bounds.height, y: barMinY + topSize.height, width: labelWidth, height: bottomSize.height)
            }
        case .right:
            circleLabel.frame = CGRect(x: bounds.width - 1 - circleDiameter + circleLabelAddedX, y: (bounds.height - circleLabel.intrinsicContentSize.height) / 2, width: circleLabelWidth, height: circleLabel.intrinsicContentSize.height)
            if bottomSize.height == 0 {
                topLabel.frame = CGRect(x: barTailPadding, y: (bounds.height - topSize.height) / 2, width: labelWidth, height: topSize.height)
            } else {
                let barMinY = (bounds.height - (topSize.height + bottomSize.height)) / 2
                topLabel.frame = CGRect(x: barTailPadding, y: barMinY, width: labelWidth, height: topSize.height)
                bottomLabel.frame = CGRect(x: barTailPadding, y: barMinY + topSize.height, width: labelWidth, height: bottomSize.height)
            }
        }
    }

    private func drawCircle(onContext context: CGContext, rect: CGRect) {
        context.setFillColor(circleBackgroundColor.cgColor)
        context.setStrokeColor(circleBorderColor.cgColor)
        context.setLineWidth(circleBorderWidth)

        context.addEllipse(in: rect)
        context.drawPath(using: .fillStroke)
    }

    private func drawLeftBar(onContext context: CGContext, circleRect: CGRect, barHeight: CGFloat, rect: CGRect) {
        let circleRadius = circleRect.width / 2
        let barHalfHeight = barHeight / 2
        let sideWidth = sqrt(pow(circleRadius, 2) - pow(barHalfHeight, 2))
        let angle = asin(barHalfHeight / circleRadius)

        let minX = CGFloat(0)
        let minY = rect.height / 2 - barHalfHeight
        let maxX = rect.maxX - 1 - circleRadius - sideWidth + circleBorderWidth
        let maxY = rect.height / 2 + barHalfHeight

        let path = UIBezierPath()
        path.move(to: CGPoint(x: maxX, y: minY))
        path.addLine(to: CGPoint(x: minX + barCornerRadius, y: minY))
        path.addQuadCurve(to: CGPoint(x: minX + barBorderWidth, y: minY + barCornerRadius), controlPoint: CGPoint(x: minX + barBorderWidth, y: minY))
        path.addLine(to: CGPoint(x: minX + barBorderWidth, y: maxY - barCornerRadius))
        path.addQuadCurve(to: CGPoint(x: minX + barBorderWidth + barCornerRadius, y: maxY), controlPoint: CGPoint(x: minX + barBorderWidth, y: maxY))
        path.addLine(to: CGPoint(x: maxX, y: maxY))
        let borderPath = UIBezierPath(cgPath: path.cgPath)
        path.addArc(withCenter: CGPoint(x: circleRect.midX, y: circleRect.midY), radius: circleRadius, startAngle: angle, endAngle: -angle, clockwise: false)

        drawBarBackground(onContext: context, cgPath: path.cgPath)
        drawBarProgress(onContext: context, cgPath: path.cgPath, startX: maxX, endX: maxX - CGFloat(progress) * (maxX - minX))
        drawBarBorder(onContext: context, cgPath: borderPath.cgPath)
    }

    private func drawRightBar(onContext context: CGContext, circleRect: CGRect, barHeight: CGFloat, rect: CGRect) {
        let circleRadius = circleRect.width / 2
        let barHalfHeight = barHeight / 2
        let sideWidth = sqrt(pow(circleRadius, 2) - pow(barHalfHeight, 2))
        let angle = asin(barHalfHeight / circleRadius)

        let minX = 1 + circleRadius + sideWidth - circleBorderWidth
        let minY = rect.height / 2 - barHalfHeight
        let maxX = rect.maxX
        let maxY = rect.height / 2 + barHalfHeight

        let path = UIBezierPath()
        path.move(to: CGPoint(x: minX, y: minY))
        path.addLine(to: CGPoint(x: maxX - barCornerRadius, y: minY))
        path.addQuadCurve(to: CGPoint(x: maxX - barBorderWidth, y: minY + barCornerRadius), controlPoint: CGPoint(x: maxX - barBorderWidth, y: minY))
        path.addLine(to: CGPoint(x: maxX - barBorderWidth, y: maxY - barCornerRadius))
        path.addQuadCurve(to: CGPoint(x: maxX - barBorderWidth - barCornerRadius, y: maxY), controlPoint: CGPoint(x: maxX - barBorderWidth, y: maxY))
        path.addLine(to: CGPoint(x: minX, y: maxY))
        let borderPath = UIBezierPath(cgPath: path.cgPath)
        path.addArc(withCenter: CGPoint(x: circleRect.midX, y: circleRect.midY), radius: circleRadius, startAngle: angle, endAngle: -angle, clockwise: false)

        drawBarBackground(onContext: context, cgPath: path.cgPath)
        drawBarProgress(onContext: context, cgPath: path.cgPath, startX: minX, endX: minX + CGFloat(progress) * (maxX - minX))
        drawBarBorder(onContext: context, cgPath: borderPath.cgPath)
    }

    private func drawBarBackground(onContext context: CGContext, cgPath: CGPath) {
        context.saveGState()
        context.addPath(cgPath)
        context.setFillColor(barBackgroundColor.cgColor)
        context.fillPath()
        context.restoreGState()
    }

    private func drawBarProgress(onContext context: CGContext, cgPath: CGPath, startX: CGFloat, endX: CGFloat) {
        context.saveGState()
        context.addPath(cgPath)
        context.clip()
        let colors = [progressTintColor.darker.cgColor, progressTintColor.cgColor]

        let delta = 1.0 / Float(colors.count)
        let semiDelta = delta / Float(colors.count)
        var locations: [CGFloat] = []
        for index in 0..<colors.count {
            locations.append(CGFloat(delta * Float(index)) + CGFloat(semiDelta))
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) {
            context.drawLinearGradient(gradient, start: CGPoint(x: startX, y: 0), end: CGPoint(x: endX, y: 0), options: [])
        }
        context.restoreGState()
    }

    private func drawBarBorder(onContext context: CGContext, cgPath: CGPath) {
        context.saveGState()
        context.setStrokeColor(barBorderColor.cgColor)
        context.setLineWidth(barBorderWidth)
        context.addPath(cgPath)
        context.strokePath()
        context.restoreGState()
    }
}
