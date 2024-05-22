//
//  SearchService.swift
//  Breezy
//
//  Created by Kein Li on 5/21/24.
//

import Foundation
import MapKit

struct SearchContent: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    let completion : MKLocalSearchCompletion
}

protocol SearchService {
    var searchStr : String { get set }
    var completer: MKLocalSearchCompleter { get }
    var searches : [SearchContent] { get set }
    func updateContent()
    func performSearch(for searchContent : SearchContent) async -> CLLocationCoordinate2D?
}


// Uses MKLocalSearchCompleterAPI to create local searches

@Observable
class SearchManager: NSObject, SearchService {
    
    var searchStr : String = ""
    var completer: MKLocalSearchCompleter
    
    var searches = [SearchContent]()
    
    override init() {
        self.completer = MKLocalSearchCompleter()
        super.init()
        self.completer.delegate = self
    }
    
    
    /// Updates the completer with the new search str, which the user types into the TextField
    /// SwiftUI then detects the change and programatically updates the view with the new list of searches
    /// Also automatically fires off the delegate method since completer changed
    func updateContent() {
        completer.queryFragment = searchStr
        completer.resultTypes = .address
    }
    
    
    
    /// Initiates a MKLocaalSearch
    /// - Parameter searchContent: the search content struct we provide
    /// - Returns: an optional CLLOcationCoordinate
    func performSearch(for searchContent : SearchContent) async -> CLLocationCoordinate2D? {
        let requestObject = MKLocalSearch.Request(completion: searchContent.completion)
        
        guard let result = try? await MKLocalSearch(request: requestObject).start() else {
            print("error in local search ")
            return nil
        }
        print(result.boundingRegion)
        print(result.mapItems)
        return result.boundingRegion.center
       
    }
    
}

extension SearchManager : MKLocalSearchCompleterDelegate {
    
    
    /// Delegate method for the completer
    /// - Parameter completer: the completer we pass in.
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let result = completer.results
        self.searches = result.map {SearchContent(title: $0.title, subTitle: $0.subtitle, completion: $0) }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Search failed", error)
    }
    
}
