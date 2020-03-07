# Swift UI

### Objective
* Build Simple UIs
* Get used to using the swiftUI inspector

### Basics

- Views are created in structs
- Easily modify properties by chaining them
```
struct ContentView: View {
    var body: some View {
        Text("Tutle Rock")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.green)
    }
}
```
- The code always offer the source of truth


### Layout
- VStack: vertical stack 
- HStack: horizontal stack (row)
    - Can be nested
- Spacer: Place between elements to dynamcially space them apart
- padding: Adds some space around the element (like in css)