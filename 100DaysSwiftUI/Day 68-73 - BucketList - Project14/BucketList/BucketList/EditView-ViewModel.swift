//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Leandro Motta Junior on 10/10/25.
//

import Foundation

extension EditView {
    @Observable
    class EditViewModel {
        
        private(set) var location: Location
        var pages = [Page]()
        var name: String
        var description: String

        enum LoadingState {
            case loading, loaded, failed
        }
        var loadingState = LoadingState.loading
        
        init(location: Location) {
            self.location = location
            _name = location.name
            _description = location.description
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
        
    }
}
