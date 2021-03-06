# Swift UI

## Objective

* Build Simple UIs
* Get used to using the swiftUI inspector

[Tutorial from Apple](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation)

--- 

## Basics

Swift UI is <i> declarative </i> which means means that you describe the logic of the program without any control flow. Styling things is a lot more like CSS (and thus easier) than before.

* Views are created in structs
* Easily modify properties by chaining them

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

* The code always offer the source of truth

### Layout

* VStack: vertical stack 
* HStack: horizontal stack (row)
    - Can be nested
* Spacer: Place between elements to dynamcially space them apart
* padding: Adds some space around the element (like in css)
* `.frame(height: 300)` can but used to specify a frame and set size
* `.offset(y: -130)` shifts up by 130 pts.

---

## Custom Views

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

* `.resizable()` allows it to resize to fit space
    - This can cause it the aspect ratio to shift
* Use `.aspectRatio(contentMode: )` to specify aspect ratio
* Can use `.clipshape(shape:)` to clip the image

---

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

---

#### List View

* Creates a list that uses a view

> Instead of specifying a list’s elements individually, you can generate rows directly from a collection.

* Lists requires <i> identifiable </i> data
    - Either pass along a property that uniquely identifies each element
    - or conform to the `Identifiable` protocal

##### Subview

``` 
struct LandmarkRow: View {
    var landmark: Landmark 
    // ^ conforms to identifiable protocol
    
    var body: some View {
        HStack{
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
            Spacer()
        }
    }
}
``` 

* This is the subview that the list uses
* Takes in a Landmark object and creates a row in the list

##### List View

```

struct LandmarkList: View {

    var body: some View {
        List(landmarkData){ landmark in
            LandmarkRow(landmark: landmark)
        }

    }

}

``` 

* Pass in the landmarkData array
* for each landmark in landmarkData, show a new row
* the list has the ability to scroll without the need to embed in something like a scroll view

The previous example shows the the use of passing an identifiable array of data into the list directly but that is not the correct way to do it for dynamically shown data or for data shown with mixed views. It instead should be done with a `forEach` like such:

```

List{
     ForEach(landmarkData){ landmark in
        if !self.showFavoritesOnly || landmark.isFavorite {
            NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }
            

``` 

---

#### Navigation from list View

* This works in the format `list` -> `detail` 
* Can embed list into a `NavigationView` , and each row of the list to `NavigationLink` 

```

struct LandmarkList: View {

    var body: some View {
        NavigationView {
            List(landmarkData){ landmark in
                NavigationLink(destination: LandmarkDetail()){ 
                // adds `>` and opens LandmarkDetail view
                    LandmarkRow(landmark: landmark)
                }
            }
            .navigationBarTitle(Text("Landmarks")) // Sets title
        }

    }

}

``` 

--- 

#### Previewing On Other Devices

```

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max", "iPad Pro (12.9-inch) (3rd generation)"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }

    }

}

``` 

---

## Dynamic Views

### If-Statements can be used within views
```

 HStack {

            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
            Spacer()
            if landmark.isFavorite { //will only show if truthy
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }

```

### Using States
1.  Define a state within the view struct
``` 
@State var showFavoritesOnly = true;
```
2. Use this state variable to generate the view dynamically
```
    if self.showFavoritesOnly {
        // child view code only shows if self.showFavoritesOnly 
    }
```
3. See `Toggles` in the Interactive UI Elements section below

### Using the `ObservableObject` Protocol
- Allows for swift to watch for changes to that object and refresh elements that depend on that object!
- Variables you want to watch for need to be marked with `@Published` within that object
- Use this to act as the datastore to easily refresh views

```
import SwiftUI
import Combine

final class UserData: ObservableObject {    
    @Published var showFavouritesOnly = false
    @Published var landmarks = landmarkData    
}

```
---

## Interactive UI Elements

### Toggles
- to switch states, toggling boolean information
```
Toggle(isOn: $showFavoritesOnly){
    Text("Favorites Only")
}
```
- the `$` will bind `showFavoritesOnly` to that toggle
- subsequently, if the toggle is `on` then `showFavoritesOnly` is `true`

---

## Drawing

### Paths
- Vector lines 
- Usually draw by defining points 
- Usually start at a point and then add lines but there are many ways to draw a path 

### Bézier Paths
- Curvy paths that are defined by three points, two points plus a control point.

![image](https://lh3.googleusercontent.com/proxy/-u4h7Pmbm3mfddYE3EY5YPCcN3Et4Rr3cyfDJoLBnlypUv-OZPAb6al3tqmdJMudJE03aZd7mfNTSvawOcGUOM9AY3pT3jdpZvhYH8wzRXIoRyKiidHC9jKMlodaQfi2uvQwSfVhZn699ziAqnouOUMPhVCn)

---



### Next Steps

* Look into how the json was decoded (potentially very useful) 

### Useful Links

* [tips and tricks](https://www.hackingwithswift.com/quick-start/swiftui/swiftui-tips-and-tricks)

