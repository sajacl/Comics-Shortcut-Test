//
//  ComicDetail.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import SwiftUI
import Kingfisher
import RealmSwift

struct ComicDetail: ViewInterface, View {
    var presenter: ComicDetailPresenterViewInterface!
    
    @EnvironmentObject var environment: ComicDetailEnviroment
    @ObservedObject var viewModel: ComicDetailViewModel
    
    @State private var showShareSheet = false
    @State private var animationAmount = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading){
                ZStack {
                KFImage(viewModel.comic.imageURL())
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: 300)
                    .navigationBarTitle(viewModel.comic.title)
                    .clipped()
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                FullImageComicViewControllerWrapper(imageURL: viewModel.comic.imageURL(), comicName: viewModel.comic.title)
                            } label: {
                                Image(systemName: "magnifyingglass")
                                  .resizable()
                                  .frame(width: 20, height: 20)
                                  .foregroundColor(.white)
                                  .padding(20)
                                  .background(Color.gray)
                                  .clipShape(Circle())
                                  .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                  .padding(.trailing, 12)
                            }
                        }
                        
                        Spacer()
                    }
                }
                
                HStack {
                    Image("shortcut-icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                        .padding(.leading, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Article Written By")
                            .font(.avenirNext(size: 12))
                            .foregroundColor(.gray)
                        Text(String(.appTitle))
                            .font(.avenirNext(size: 17))
                    }
                    
                    Spacer()
                    
                    Button {
                        self.showShareSheet = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .frame(width: 35, height: 35)
                    .foregroundColor(.red)
                    
                    Star(corners: 5, smoothness: 0.45)
                        .fill(viewModel.favoritedColor)
                        .frame(width: 35, height: 35)
                        .background(Color.clear)
                        .padding(.trailing, 10)
                        .onTapGesture {
                            viewModel.faveClicked()
                        }
                        .animation((Animation.linear))
//                        .animation(.spring(response: 1.5), value: viewModel.comicIsFavorited())
//                        .animation(Animation.easeInOut(duration: 0.3), value: viewModel.comicIsFavorited())
                }
            }
        }
        
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.comic.getComicDateString())
                        .font(.avenirNextRegular(size: 12))
                        .foregroundColor(.gray)
                    
                    Text(viewModel.comic.alt)
                        .font(.avenirNext(size: 28))
                    
                    Text(viewModel.comic.transcript)
                        .lineLimit(nil)
                        .font(.avenirNextRegular(size: 17))
                }
                .padding(.horizontal)
                .padding(.top, 16.0)
            }
        }
        .padding(.top, 20)
        
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [viewModel.comic.transcript],
                       excludedActivityTypes: [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo])
        }
    }
}

#if DEBUG
struct ComicDetail_Previews: PreviewProvider {
    static var previews: some View {
        ComicDetail(viewModel: ComicDetailViewModel(comic: ComicModel()))
    }
}
#endif
