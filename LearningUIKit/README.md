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
- `.frame(height: 300)` can but used to specify a frame and set size
- `.offset(y: -130)` shifts up by 130 pts. 

#### Summary
- Declare view's layout in body
- Use stacks to combine views

### Custom Views

#### Image View

```
struct CircleImage: View {
    var body: some View {
    Image("location")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(Circle())
    }
}
```
- `.resizable()` allows it to resize to fit space
    - This can cause it the aspect ratio to shift
- Use `.aspectRatio(contentMode: )` to specify aspect ratio
- Can use `.clipshape(shape:)` to clip the image


#### Map View
```
import MapKit

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}
```

