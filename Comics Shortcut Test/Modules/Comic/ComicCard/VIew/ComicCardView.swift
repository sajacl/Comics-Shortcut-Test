//
//  ComicCardView.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import SwiftUI
import Kingfisher
import CardStack

struct ComicIdHolderModel: CardData {
    var id: String
}

struct ComicCardView: CardView {
    var data: ComicIdHolderModel?
        
    @StateObject private var viewModel = ViewModel()
    @State private var showShareSheet = false
    
    init<Data>(data: Data) where Data: CardData {
        if let infoData = data as? ComicIdHolderModel {
            self.data = infoData
        }
    }
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(8)
                .frame(width: 300, height: 400)
                .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 0)
            
            VStack {
                HStack {
                    if let safeTitle = viewModel.comic?.safeTitle {
                        Text(safeTitle)
                        
                        NavigationLink {
                            if let comic = viewModel.comic {
                                ComicDetailBuilder().build(comic: comic)
                            }
                        } label: {
                            Text(String(.seeDetail))
                        }
                    } else {
                        Text("404")
                    }
                }
                
                KFImage(viewModel.comic?.imageURL())
                    .cacheOriginalImage()
                    .placeholder({
                        Text(String(.loading))
                    })
                    .cropping(size: CGSize(width: 300, height: 400))
                    .loadDiskFileSynchronously()
                    .fade(duration: 0.1)
                    .frame(width: 300, height: 400)
                    .cornerRadius(8)
            }
        }
        .contextMenu {
            Button {
                self.showShareSheet = true
            } label: {
                Label(String(.share), systemImage: "square.and.arrow.up")
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [viewModel.comic?.transcript ?? ""],
                       excludedActivityTypes: [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo])
        }
        
        .onAppear(perform: fetch)
    }
    
    func fetch() {
        viewModel.id = data?.id ?? ""

        viewModel.fetch()
    }
}

#if DEBUG
struct ComicCardView_Previews: PreviewProvider {
    static var previews: some View {
        ComicCardView(data: ComicIdHolderModel(id: UUID().uuidString))
    }
}
#endif
