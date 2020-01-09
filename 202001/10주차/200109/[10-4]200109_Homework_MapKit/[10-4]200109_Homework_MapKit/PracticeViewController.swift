//
//  PracticeViewController.swift
//  [10-4]200109_Homework_MapKit
//
//  Created by cskim on 2020/01/09.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import MapKit

class PracticeViewController: UIViewController {

    private let mapView = MKMapView()
    private let myAddress = "대한민국 서울특별시 관악구 봉천동 1679-20"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        mapView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        self.mapView.delegate = self
        self.view.addSubview(mapView)
        
        geocodeAddressString(myAddress)
    }
    
    private func geocodeAddressString(_ addressString: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placeMark, error) in
            if error != nil {
                return print(error!.localizedDescription)
            }
            
            guard let place = placeMark?.first else { return }
            guard let location = place.location else { return }
            
            self.setRegion(location: location)
        }
    }
    
    private func setRegion(location: CLLocation) {
        // Location 이동
        let span = MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        self.mapView.setRegion(region, animated: false)
        
        // Add Annotation for Location
        let annotationPin = MKPointAnnotation()
        annotationPin.title = "My Home"
        annotationPin.coordinate = location.coordinate
        self.mapView.addAnnotation(annotationPin)
        
        // Render Triangle
        self.setPolyline(center: location.coordinate)
    }
    
    private func setPolyline(center: CLLocationCoordinate2D) {
        var point1 = center; point1.latitude += 0.0002
        var point2 = center; point2.longitude += 0.0002;   point2.latitude -= 0.0001
        var point3 = center; point3.longitude -= 0.0002;  point3.latitude -= 0.0001
        let points: [CLLocationCoordinate2D] = [point1, point2, point3, point1]
        let polyline = MKPolyline(coordinates: points, count: points.count)
        mapView.addOverlay(polyline)
    }
}

// MARK:- MKMapViewDelegate

extension PracticeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 2
        return renderer
    }
}
