//#-hidden-code
import SwiftUI
import UIKit

@_functionBuilder
public struct AttributedStringBuilder {
    public static func buildBlock(_ segments: NSAttributedString...) -> NSAttributedString {
        let string = NSMutableAttributedString()
        segments.forEach { string.append($0) }
        return string
    }
    public static func buildIf(_ segment: NSAttributedString?) -> NSAttributedString {
        segment ?? NSAttributedString()
    }
}

public extension NSAttributedString {
    convenience init(@AttributedStringBuilder _ content: () -> NSAttributedString) {
        self.init(attributedString: content())
    }
}

public extension String {
    /// Sets the color of this text
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.foregroundColor : color])
    }
    /// Sets the background color
    func background(_ color: UIColor) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.backgroundColor: color])
    }
    /// Applies an underline to the text
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.underlineColor: color, .underlineStyle: style.rawValue])
    }
    /// Sets the font for this text
    func font(_ font: UIFont) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.font: font])
    }
    /// Adds a shadow to this text
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [.shadow: shadow])
    }
    /// Returns this string as an `NSAttributedString`
    var attributed: NSAttributedString {
        NSAttributedString(string: self)
    }
}

public extension NSAttributedString {
    /// Sets the color of this text
    func foregroundColor(_ color: UIColor) -> NSAttributedString {
        self.apply([.foregroundColor : color])
    }
    /// Sets the background color
    func background(_ color: UIColor) -> NSAttributedString {
        self.apply([.backgroundColor: color])
    }
    /// Applies an underline to the text
    func underline(_ color: UIColor, style: NSUnderlineStyle = .single) -> NSAttributedString {
        self.apply([.underlineColor: color, .underlineStyle: style.rawValue])
    }
    /// Sets the font for this text
    func font(_ font: UIFont) -> NSAttributedString {
        self.apply([.font: font])
    }
    /// Adds a shadow to this text
    func shadow(_ shadow: NSShadow) -> NSAttributedString {
        self.apply([.shadow:shadow])
    }
}

public extension NSAttributedString {
    func apply(_ attributes: [NSAttributedString.Key:Any]) -> NSAttributedString {
        let mutable = NSMutableAttributedString(string: self.string, attributes: self.attributes(at: 0, effectiveRange: nil))
        mutable.addAttributes(attributes, range: NSMakeRange(0, (self.string as NSString).length))
        return mutable
    }
}
//#-end-hidden-code

/*:
 Now we're ready to use our builder. However, to make the process even more seamless, I've created extensions for `String` and `NSAttributedString` to add modifiers. You can get the code for those [here](https://gist.github.com/carson-katri/d398764a76a9b525e4a34e360cb70187). I've included them in the book for you

 Ok, let's try out our function builder:
 */
//#-hidden-code
let attributedString =
//#-end-hidden-code
NSAttributedString {
//#-editable-code
    "Hello"
        .foregroundColor(.red)
        .font(UIFont.systemFont(ofSize: 10.0))
    "World"
        .foregroundColor(.green)
        .underline(.orange, style: .thick)
//#-end-editable-code
}

//#-hidden-code
import PlaygroundSupport
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
label.attributedText = attributedString
view.addSubview(label)
PlaygroundPage.current.liveView = view
//#-end-hidden-code
