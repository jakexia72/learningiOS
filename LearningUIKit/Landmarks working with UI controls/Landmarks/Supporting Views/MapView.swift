/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that hosts an `MKMapView`.
*/

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var locationName: String
    

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.mapType = MKMapType.satellite
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = locationName
        uiView.addAnnotation(annotation)
        
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude - 0.005, longitude: coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: center, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: landmarkData[0].locationCoordinate, locationName: landmarkData[0].name)
    }
}
