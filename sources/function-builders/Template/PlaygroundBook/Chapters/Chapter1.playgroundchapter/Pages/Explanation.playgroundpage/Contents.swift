//#-hidden-code
import SwiftUI
struct Todo {
    let id: String
    let completed: Bool
    let title: String
}
let todos = [
    Todo(id: "0", completed: true, title: "Hello, World!"),
    Todo(id: "1", completed: false, title: "Make a functionBuilder"),
    Todo(id: "2", completed: false, title: "Use it"),
]
struct ContentView: View {
    var body: some View {
//#-end-hidden-code

/*:
 When I first saw SwiftUI, I instantly wondered how it was possible. It didn't look like Swift. This foreign syntax was extremely expressive compared to UIKit. What used to take a ridiculous amount of UIKit code and possibly a storyboard, now takes 6 lines of code:
 */
//#-editable-code
List(todos, id: \.id) { todo in
    HStack {
        Image(systemName: "checkmark.circle\(todo.completed ? ".fill" : "")")
        Text(todo.title)
    }
}
//#-end-editable-code
//#-hidden-code
    }
}
//#-end-hidden-code

/*:
 SwiftUI's declarative syntax is made possible by function builders ([here's the proposal](https://forums.swift.org/t/function-builders/25167)). This is what allows you to combine and compose views together (e.g., HStack taking two Views and forming a TupleView). Function builders are a huge step forward in Swift supporting declarative programming, and provide the basis for tons of powerful new DSLs.

 I've been messing around with them lately, and I recently released a [DSL for making HTTP requests](https://github.com/carson-katri/swift-request). I learned a lot about function builders along the way. I hope the information I've included here can help you create your own DSLs.
 */
//#-hidden-code
import PlaygroundSupport
PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView())
//#-end-hidden-code
