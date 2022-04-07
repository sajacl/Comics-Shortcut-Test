//
//  Search.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State var searchedString: String = ""
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            SearchField(searchedString: $searchedString, placeholder: String(.searchComics), onUpdateSearchText: { searchedString in
                self.viewModel.search(for: searchedString)
            })
            
            if searchedString.isEmpty || searchedString == "" {
                Spacer()
                Text(String(.searchWithIdAndName))
                Spacer()
            }
            else if viewModel.comics.isEmpty {
                Spacer()
                Text(String(.somethingWentWrong))
                Button(action: {
                    self.viewModel.search(for: searchedString)
                }) {
                    Text(String(.reload))
                }
                Spacer()
                Spacer()
            } else {
                List {
                    ForEach(viewModel.comics) { comic in
                        NavigationLink {
                            ComicDetailBuilder().build(comic: comic)
                        } label: {
                            Text("\(comic.safeTitle)")
                        }
                    }
                }
            }
        }
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
#endif
