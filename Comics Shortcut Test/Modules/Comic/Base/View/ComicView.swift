//
//  ComicView.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import SwiftUI
import CardStack

struct ComicView: View {
    @EnvironmentObject var environment: ComicEnvironment
    
    @StateObject private var viewModel = ViewModel()
    
    let configuration = StackConfiguration()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                NavigationLink {
                    SearchView()
                } label: {
                    Text(String(.searchComics))
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16)
                            })
                }
                .foregroundColor(.gray)
                
                CardStackView<ComicCardView, ComicIdHolderModel>(configuration: configuration, items: viewModel.items)
            }
            .navigationBarTitle(environment.title)
        }
    }
}

#if DEBUG
struct ComicView_Previews: PreviewProvider {
    static var previews: some View {
        return ComicView()
        .environmentObject(ComicEnvironment())
    }
}
#endif
