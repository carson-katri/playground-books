//#-hidden-code
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
There are endless possibilities when it comes to function builders we could make. I decided a good way to start would be something simple and useful: `NSAttributedString`.

In Swift, creating an attributed string can be a real pain. Wouldn't it be nice if we could use SwiftUI style syntax?
*/
//#-hidden-code
let attributedString =
//#-end-hidden-code
NSAttributedString {
    "Hello "
        .foregroundColor(.red)
    "World"
        .foregroundColor(.blue)
        .underline(.blue)
}

//: We can create a function builder to do just that. Let's start with our builder: `NSAttributedStringBuilder`
@_functionBuilder
struct NSAttributedStringBuilder {
  static func buildBlock(_ segments: NSAttributedString...) -> NSAttributedString {
    let string = NSMutableAttributedString()
/*:
Try adding all of the segments to `string` using `string.append`

> You can treat `NSAttributedString...` as an array
*/
    //#-editable-code Tap to enter code
    
    //#-end-editable-code
    return string
  }
}

//: We want our function builder to work when initializing an `NSAttributedString` so we need to create a convenience initializer.
extension NSAttributedString {
  convenience init(@NSAttributedStringBuilder content: () -> NSAttributedString) {
    self.init(attributedString: content())
  }
}

//#-hidden-code
import PlaygroundSupport
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
label.attributedText = attributedString
view.addSubview(label)
PlaygroundPage.current.liveView = view
//#-end-hidden-code
