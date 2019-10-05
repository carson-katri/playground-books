//#-hidden-code
import SwiftUI
//#-end-hidden-code

//: Let's take a look at using the ViewBuilder that powers SwiftUI's DSL:
//#-hidden-code
struct ContentView: View {
//#-end-hidden-code
@ViewBuilder
func combineWords() -> TupleView<(Text, Text)> {
    //#-editable-code
    Text("Hello")
    Text("World")
    //#-end-editable-code
}

//#-hidden-code
    var body: some View {
//#-end-hidden-code
combineWords()
//#-hidden-code
    }
}
//#-end-hidden-code

/*:
 Let's break it down:

 The `@ViewBuilder` function builder is applied to a function that converts two `Text` views into a `TupleView` that contains both `Text` views.

 > We don't need a return statement because of SE-0255, which allows for implicit returns.

 What the compiler does is convert our function into this:
 */
func combineWords() -> TupleView<(Text, Text)> {
    let _a = Text("Hello")
    let _b = Text("World")
    return ViewBuilder.buildBlock(_a, _b)
}

/*:
 As you can see, `ViewBuilder` does all the heavy lifting. It takes in our views and creates the `TupleView`. You can use your own function builders in the same way. Let's look at an implementation of a function builder.
 */
@_functionBuilder
struct GreetingBuilder {
    static func buildBlock(_ items: String...) -> [String] {
        items.map { "Hello \($0)" }
    }
}

/*:
 > As of Swift 5.1 in Xcode 11 beta 4, we need to use `@_functionBuilder` instead of `@functionBuilder`. This will be changing once the full proposal is implemented and accepted.
 
 What our function builder does is take in strings, and return those strings with "Hello" inserted at the beginning.

 When we use our function builder, the `buildBlock` function is called, and it takes in any `Strings` we pass. This is due to the variadic parameter `String...`

 > You can learn more about variadic parameters in the Swift docs

 Inside the `buildBlock` function we can perform any logic we need to create our `String` array. In this case, we add "Hello" to the beginning.
 */

//#-hidden-code
import PlaygroundSupport
PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView())
//#-end-hidden-code
