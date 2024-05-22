//
//  SearchableView.swift
//  Breezy
//
//  Created by Kein Li on 5/19/24.
//

import SwiftUI
import MapKit

struct SearchableView: View {
    
    
    @Environment (\.dismiss) var dismiss
    @Environment (\.airQualityVM) var homeVM
    @Environment (\.historyVM) var historyVM
    
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
                            guard let coordinate = await searchVM.performSearch(for: searchContent) else {
                                print("error in search vm")
                                return
                            }
                            
                            async let aq: Void = homeVM.retrieveLocationAndUpdateData(coordinate: coordinate)
                            async let hist: Void = historyVM.retrieveLocationHistoryData(coordinate: coordinate)
                            
                            _ = await (aq,hist)
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
        .interactiveDismissDisabled()
        .presentationBackground(.ultraThinMaterial)
        .presentationCornerRadius(25)
        .onChange(of: searchVM.searchStr) {
            searchVM.updateContent()
        }
    }
}
//
//#Preview {
//    SearchableView()
//}
