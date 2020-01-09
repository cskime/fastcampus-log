//
//  HomeworkViewController.swift
//  [10-4]200109_Homework_MapKit
//
//  Created by cskim on 2020/01/09.
//  Copyright © 2020 cskim. All rights reserved.
//

import UIKit
import MapKit

class HomeworkViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.textField)
        self.view.addSubview(self.mapView)
        
        self.textField.borderStyle = .roundedRect
        self.textField.delegate = self
        self.mapView.delegate = self
        
        let guide = self.view.safeAreaLayoutGuide
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8),
            self.textField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            self.textField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
        ])
        
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mapView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 8),
            self.mapView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if self.textField.isFirstResponder {
            self.textField.resignFirstResponder()
        }
    }
    
    private var coordinateQueue = [CLLocationCoordinate2D]()
    private func geocodeAddressString(_ address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placeMark, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let place = placeMark?.first else { return }
            guard let location = place.location else { return }
            
            if self.coordinateQueue.isEmpty {
                self.coordinateQueue.append(location.coordinate)
            } else {
                self.strokeLine(source: self.coordinateQueue.removeFirst(),
                                destination: location.coordinate)
                self.coordinateQueue.append(location.coordinate)
            }
            self.setRegion(location.coordinate, address: address)
            self.setOverlay(location.coordinate)
        }
    }
    
    private var annotationTag = 0
    private func setRegion(_ coordinate: CLLocationCoordinate2D, address: String) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        annotationTag += 1
        annotation.title = "\(annotationTag)번째 행선지"
        annotation.subtitle = address
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
    }
    
    private func setOverlay(_ coordinate: CLLocationCoordinate2D) {
        let center = coordinate
        var point1 = center;    point1.latitude += 0.002;    point1.longitude -= 0.002
        var point2 = center;    point2.latitude -= 0.002;    point2.longitude -= 0.002
        var point3 = center;    point3.latitude -= 0.002;    point3.longitude += 0.002
        var point4 = center;    point4.latitude += 0.002;    point4.longitude += 0.002
        let points = [point1, point2, point3, point4, point1]
        let polyline = MKPolyline(coordinates: points, count: points.count)
        self.mapView.addOverlay(polyline)
    }
    
    private func strokeLine(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let polyline = MKPolyline(coordinates: [source, destination], count: 2)
        self.mapView.addOverlay(polyline)
    }
}

// MARK:- MKMapViewDelegate

extension HomeworkViewController: MKMapViewDelegate {
    // mapView.addOverlay() 호출 시 호출됨
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .red
        renderer.lineWidth = 1
        return renderer
    }
    
    // 화면에 annotation이 나타날 때 마다 순서 상관없이 annotation들이 들어오고 호출되는데 어떻게쓰지..
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.annotations.forEach {
            print($0.coordinate)
        }
    }
}

// MARK:- UITextFieldDelegate

extension HomeworkViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        print("End")
        self.geocodeAddressString(text)
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
