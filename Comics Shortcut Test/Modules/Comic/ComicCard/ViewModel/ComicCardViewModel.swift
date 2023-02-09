//
//  ComicCardViewModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import SwiftUI
import RealmSwift
import Combine

extension ComicCardView {
    class ViewModel: ObservableObject {
        var id: String!
        @Published var comic: ComicModel?
        
        private var bag = Set<AnyCancellable>()
        
        func fetch() {
            guard comic == nil else { return }
            
            if let id = Int(id), let comic = RealmHelper.shared.fetchComic(id: id) {
                self.comic = comic
            } else {
                self.requestComicsWithPublisher()
                    .on(queue: .global(qos: .background))
                    .on(success: { [unowned self] data in
                        DispatchQueue.main.async {
                            self.saveComic(comic: data)
                            self.comic = data
                        }
                    }, failure: { error in
                        DispatchQueue.main.async {
                            LError(error.localizedDescription)
                        }
                    }).store(in: &bag)
            }
        }
        
        private func saveComic(comic: ComicModel) {
            RealmHelper.shared.saveComic(comic: comic)
        }
        
        func requestComicsWithPublisher() -> AnyPublisher<ComicModel, APIResult.Error> {
            let comicsURLString = "https://xkcd.com/\(id ?? "-1")/info.0.json"
            let comicsURL: URL = {
                guard let url = URL(string: comicsURLString) else { preconditionFailure("Check urls befor release.") }
                return url
            }()
            
            let request = URLRequest(url: comicsURL)
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIResult.Error.invalidResponse
                    }
                    guard httpResponse.statusCode == 200 else {
                        throw APIResult.Error.statusCode(httpResponse.statusCode)
                    }
                    return data
                }
                .decode(type: ComicDecodableModel.self, decoder: JSONDecoder())
                .map({ ComicModel(from: $0) })
            
                .mapError { error -> APIResult.Error in
                    if let httpError = error as? APIResult.Error {
                        return httpError
                    }
                    return APIResult.Error.unknown(error)
                }
                .eraseToAnyPublisher()
        }
    }
}
