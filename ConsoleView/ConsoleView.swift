//
//  ConsoleView.swift
//  ConsoleView
//
//  Created by Subhadeep Pal on 21/12/18.
//  Copyright © 2018 Subhadeep. All rights reserved.
//

import UIKit

enum LogType: Int {
    case verbose
    case debug
    case warning
    case error

    func colour() -> UIColor {
        switch self{
        case .verbose: return UIColor.lightGray
        case .debug: return UIColor.cyan
        case .warning: return  UIColor.orange
        case .error: return UIColor.red
        }
    }

    func prefix() -> String {
        switch self {
        case .verbose: return "[V]"
        case .debug: return "[D]"
        case .warning: return "[W]"
        case .error: return "[E]"
        }
    }
}

@IBDesignable class ConsoleView: UIView {

    @IBOutlet weak var consoleTextView: UITextView!

    var view:UIView!

    private var logs = [NSAttributedString]() {
        didSet {
            consoleTextView.attributedText = logs.reversed().joinWithSeparator(separator: "\n")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        xibSetup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        xibSetup()
    }

    func loadViewFromNib() -> UIView {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ConsoleView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }

    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]

        addSubview(view)
    }

    open func log(message: String, type: LogType) {
        let logMessage = "\(type.prefix()) : \(message)"
        let attributesString = attributedString(text: logMessage, colour: type.colour())
        logs.append(attributesString)
    }

    private func attributedString(text: String, colour: UIColor) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: colour])
    }
}

extension Array where Element: NSAttributedString {
    func joinWithSeparator(separator: NSAttributedString) -> NSAttributedString {
        var isFirst = true
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if isFirst {
                isFirst = false
            } else {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }

    func joinWithSeparator(separator: String) -> NSAttributedString {
        return joinWithSeparator(separator: NSAttributedString(string: separator))
    }
}
