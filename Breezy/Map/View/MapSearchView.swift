//
//  SearchView.swift
//  Breezy
//
//  Created by Kein Li on 5/20/24.
//

import SwiftUI
import MapKit

struct MapSearchView<T: MapViewProtocol>: View {
        
    @Environment (\.dismiss) var dismiss
    @Bindable var mapVM: T
    
    @State private var searchVM : any SearchService = SearchManager()
    
    var body: some View {
        
        VStack {
            
            HStack {
                Image(systemName: "magnifyingglass.circle")
                TextField("Search a city or location", text: $searchVM.searchStr)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.gray, lineWidth: 1)
            }
            .padding()
            
            Spacer()
            
            List {
                ForEach(searchVM.searches) { searchContent in
                    Button {
                        Task {
                            guard let coord = await searchVM.performSearch(for: searchContent) else {
                                print("error in content")
                                return
                            }
                            print("dismiss!!!")
                            print(coord)
                            await mapVM.configureLocationContent(coord: coord)
                            print("its over!!!")
                            dismiss()
                        }
                    } label: {
                        Text("\(searchContent.title) , \(searchContent.subTitle)")
                            .customTextStyle()
                    }
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .presentationBackground(.ultraThinMaterial)
        .presentationCornerRadius(25)
        .onChange(of: searchVM.searchStr) {
            searchVM.updateContent()
        }
    }
}
//
//#Preview {
//    MapSearchView()
//}
