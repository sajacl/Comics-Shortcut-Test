//
//  SearchViewModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import RealmSwift
import Combine
import Foundation

extension SearchView {
    class ViewModel: ObservableObject {
        @Published var comics: [ComicModel] = []
        
        private var bag = Set<AnyCancellable>()
        private let searchComicsURLString = "https://relevantxkcd.appspot.com/process?action=xkcd&query="
        
        private var workItem: DispatchWorkItem?
        
        func search(for searchedString: String) {
            self.workItem?.cancel()

            let workItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
            self.comics = []
                self.searchComicsWithPublisher(with: searchedString)
                    .on(queue: .global(qos: .background))
                    .on(success: { data in
                        data.forEach { comic in
                            self.requestComicWithPublisher(id: comic.id)
                                .on(queue: .global(qos: .background))
                                .on(success: { comic in
                                    self.comics.append(comic)
                                }) { error in }
                                .store(in: &self.bag)
                        }
                    }, failure: { error in
                        DispatchQueue.main.async {
                            LError(error.localizedDescription)
                        }
                    }).store(in: &self.bag)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
            self.workItem = workItem
        }
        
        private func searchComicsWithPublisher(with searchedString: String) -> AnyPublisher<[SearchComicModel], APIResult.Error> {
            let searchComicsURL: URL = {
                guard let url = URL(string: searchComicsURLString + searchedString) else { preconditionFailure("Check urls befor release.") }
                return url
            }()
            
            let request = URLRequest(url: searchComicsURL)
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
                .decode(type: [SearchedComicsDecodableModel].self, decoder: JSONDecoder())
                .map({ decodableModels in
                    decodableModels.map { SearchComicModel(decodableModel: $0) }
                })
                .mapError { error -> APIResult.Error in
                    if let httpError = error as? APIResult.Error {
                        return httpError
                    }
                    return APIResult.Error.unknown(error)
                }
                .eraseToAnyPublisher()
        }
        
        private func requestComicWithPublisher(id: Int) -> AnyPublisher<ComicModel, APIResult.Error> {
            let comicsURLString = "https://xkcd.com/\(id)/info.0.json"
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
                .map({ ComicModel(decodableModel: $0) })
            
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
