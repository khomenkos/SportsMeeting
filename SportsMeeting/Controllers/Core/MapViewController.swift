//
//  MapViewController.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 23.03.2023.
//

import UIKit
import MapKit
import CoreLocation

enum MapType {
    case AllEvenstMap
    case AddEventMap
}

protocol MapViewControllerDelegate {
    func getAddress(_ address: String?)
}

class MapViewController: UIViewController {
    
    let mapManager = MapManager()
    var mapViewControllerDelegate: MapViewControllerDelegate?
    private var events: [Event] = []
    private var mapAnnotations: [MKPointAnnotation] = []

    var mapType: MapType
    
    // MARK: View
    private var views = MapView()
    
    // MARK: Lifecycle
    override func loadView() {
        view = views
    }
    
    init(mapType: MapType) {
        self.mapType = mapType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEventHandlers()
        mapConfig()
    }
    
    // MARK: Actions
    private func setupEventHandlers() {
        views.closeButton.addTarget(self, action: #selector(closeButtonPresed), for: .touchUpInside)
        views.userLocationButton.addTarget(self, action: #selector(centerViewInUserLocation), for: .touchUpInside)
        views.doneButton.addTarget(self, action: #selector(doneButtonPresed), for: .touchUpInside)
    }
    
    @objc func doneButtonPresed() {
        mapViewControllerDelegate?.getAddress(views.addressLabel.text)
        dismiss(animated: true)
    }
    
    @objc func centerViewInUserLocation() {
        mapManager.showUserLocation(mapView: views.mapView)
    }
    
    @objc func closeButtonPresed() {
        dismiss(animated: true)
    }
    
    private func setupMapView() {
        mapManager.checkLocationServices(mapView: views.mapView) {
            self.mapManager.locationManager.delegate = self
        }
        self.mapManager.showUserLocation(mapView: views.mapView)

    }
    private func fetchEvents() {
        DatabaseManager.shared.fetchEvents { events in
            self.events = events
            self.addAnnotations()
        }
    }
    

    private func addAnnotations() {
        for event in events {
            let annotation = MKPointAnnotation()
            let geocoder = CLGeocoder()

            geocoder.geocodeAddressString(event.location) { (placemarks, error) in
                guard let placemark = placemarks?.first,
                      let location = placemark.location?.coordinate else {
                    return
                }
                annotation.coordinate = location
                annotation.title = event.nameEvent
                self.views.mapView.addAnnotation(annotation)
                self.mapAnnotations.append(annotation)
            }
        }
    }
    
    func mapConfig() {
        views.mapView.delegate = self
        switch mapType {
        case .AllEvenstMap:
            views.doneButton.isHidden = true
            views.closeButton.isHidden = true
            views.mapPinImage.isHidden = true
            views.addressLabel.isHidden = true
            fetchEvents()
            mapManager.checkLocationServices(mapView: views.mapView) {
                self.mapManager.locationManager.delegate = self
            }
        case .AddEventMap:
            views.addressLabel.text = ""
            setupMapView()
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let center = mapManager.getCenterLocation(for: mapView)
        let geocoder = CLGeocoder()

        geocoder.cancelGeocode()
        geocoder.reverseGeocodeLocation(center) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            let streetName = placemark?.thoroughfare
            let buildNumber = placemark?.subThoroughfare
            let city = placemark?.locality
            
            DispatchQueue.main.async {
                if streetName != nil && buildNumber != nil && city != nil {
                    self.views.addressLabel.text = "\(city!), \(streetName!), \(buildNumber!)"
                } else if streetName != nil && city != nil {
                    self.views.addressLabel.text = "\(city!), \(streetName!)"
                } else {
                    self.views.addressLabel.text = ""
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }

        let identifier = "event"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let annotation = view.annotation as? MKPointAnnotation {
                // Find the selected annotation in the mapAnnotations array
                if let selectedAnnotation = mapAnnotations.first(where: { $0.title == annotation.title }) {
                    // Get the corresponding event based on the annotation
                    let selectedEvent = events.first(where: { $0.nameEvent == selectedAnnotation.title })
                    
                    // Create an instance of DetailViewController and configure it with the selected event
                    let detailViewController = DetailsEventViewController()
                    detailViewController.event = selectedEvent
                    present(detailViewController, animated: true)

                }
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        mapManager.checkLocationAuthorization(mapView: views.mapView)
    }
}
