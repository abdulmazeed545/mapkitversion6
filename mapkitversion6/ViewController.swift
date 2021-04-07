//
//  ViewController.swift
//  mapkitversion6
//
//  Created by Shaik abdul mazeed on 07/04/21.
//

import UIKit
import MapKit

class ViewController: UIViewController , UISearchBarDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var search = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.searchController = search
        search.searchBar.delegate = self
        search.searchBar.barStyle = .black
        search.searchBar.showsBookmarkButton = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //Search request
        var searchReq = MKLocalSearch.Request()
        searchReq.naturalLanguageQuery = searchBar.text
        
        //search start
        var startSearch = MKLocalSearch(request: searchReq)
        
        startSearch.start { [self] (resp, err) in
            
            //remove annotations
            var remove = mapView.annotations
            mapView.removeAnnotations(remove)
            
            //getting data from lng and lat
            var lat = resp?.boundingRegion.center.latitude
            var lng = resp?.boundingRegion.center.longitude
            
            //adding annotations
            var annota = MKPointAnnotation()
            annota.title = searchBar.text
            annota.coordinate = CLLocationCoordinate2DMake(lat!, lng!)
            mapView.addAnnotation(annota)
            
            //zooming
            var coordinates = CLLocationCoordinate2DMake(lat!, lng!)
            var span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            var region = MKCoordinateRegion(center: coordinates, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("bookmarked cliked")
    }


}

