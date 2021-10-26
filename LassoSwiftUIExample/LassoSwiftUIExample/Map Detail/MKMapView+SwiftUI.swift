//
//  MKMapView+SwiftUI.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/9/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let latitude: Double
    let longitude: Double

	init(coordinates: Weather.Coordinates) {
		self.latitude = coordinates.latitude
		self.longitude = coordinates.longitude
	}

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()

        // Set Map Center
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        // Set Map Bounds
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)

        // Add Pin to City
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        mapView.addAnnotation(annotation)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {}
}
