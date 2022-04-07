//
//  RealmHelperMockTests.swift
//  Comics Shortcut TestTests
//
//  Created by Sajad Vishkai on 4/7/22.
//

import XCTest
@testable import Comics_Shortcut_Test

class RealmHelperMockTests: XCTestCase {
    class MockRealmHelper: RealmHelper {
        override init() {
            super.init()
        }
        
        private var comics: [ComicModel] = []
         
        override func saveComic(comic: ComicModel) {
            comics.append(comic)
        }
        
        override func fetchComic(id: Int) -> ComicModel? {
            comics.first(where: { $0.id == id })
        }
       
        override func fetchAllComics() -> [ComicModel] {
            comics
        }
        
        override func fetchFavoritedComics() -> [ComicModel] {
            comics.filter((\.isFavorite))
        }
        
        override func comicIsFavorited(comic: ComicModel) -> Bool {
            comics.first(where: { $0.id == comic.id })?.isFavorite ?? false
        }
       
       @discardableResult
        override func toggleFavorite(comic: ComicModel) -> Bool {
            if let (index, comic) = comics.enumerated().first(where: { ($0).element.id == comic.id }) {
                comics[index].isFavorite = !comic.isFavorite
            }
            
            return false
        }
    }
    
    private var sut: MockRealmHelper!
    
    internal let mockComic = ComicModel(id: -1, month: "1", num: -1, link: "", year: "2022", news: "", safeTitle: "Mock Comic", transcript: "", alt: "", img: "https://imgs.xkcd.com/comics/woodpecker.png", title: "Mock Comic", day: "1", isFavorite: false)

    override func setUpWithError() throws {
        sut = MockRealmHelper()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSaveComic() {
        sut.saveComic(comic: mockComic)
        
        XCTAssertNotNil(sut.fetchComic(id: -1), "Comic should be saved in Realm")
    }
    
    func testUpdateComic() {
        let mockComicForUpdate = ComicModel(id: -1, month: "1", num: -1, link: "", year: "2022", news: "", safeTitle: "Updated Mock Comic", transcript: "", alt: "", img: "https://imgs.xkcd.com/comics/woodpecker.png", title: "Mock Comic", day: "1", isFavorite: false)
        sut.saveComic(comic: mockComicForUpdate)
        
        let comic = sut.fetchComic(id: -1)
        XCTAssertNotNil(comic, "Comic should be saved in Realm")
        XCTAssertEqual(comic?.safeTitle, "Updated Mock Comic")
    }
    
    func testFetchMockComic() {
        if let comic = sut.fetchComic(id: -1) {
            XCTAssertNotNil(comic)
        } else {
            sut.saveComic(comic: mockComic)
            
            XCTAssertNotNil(sut.fetchComic(id: -1))
        }
    }
    
    func testFetchAllComics() {
        let comics = sut.fetchAllComics()
            
        if !comics.isEmpty {
            XCTAssertGreaterThan(comics.count, 0)
        } else {
            sut.saveComic(comic: mockComic)
            
            let comics = sut.fetchAllComics()
                
            XCTAssertGreaterThan(comics.count, 0)
        }
    }
    
    func testFetchFavoritedComics() {
        let comics = sut.fetchFavoritedComics()
        
        if !comics.isEmpty {
            XCTAssertGreaterThan(comics.count, 0)
        } else {
            sut.saveComic(comic: mockComic)
            sut.toggleFavorite(comic: mockComic)
            
            XCTAssertGreaterThan(sut.fetchFavoritedComics().count, 0)
        }
    }
    
    func testToggleFavorite() {
        if let comic = sut.fetchComic(id: -1) {
            sut.toggleFavorite(comic: mockComic)
            
            XCTAssertNotEqual(comic.isFavorite, sut.fetchComic(id: -1)!.isFavorite)
        } else {
            sut.saveComic(comic: mockComic)
            sut.toggleFavorite(comic: mockComic)
            
            XCTAssertNotEqual(mockComic.isFavorite, sut.fetchComic(id: -1)!.isFavorite)
        }
    }

}
