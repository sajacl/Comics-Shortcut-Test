//
//  PublisherExtensions.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation
import Combine

public extension Publisher {
    func on(queue: DispatchQueue) -> Publishers.ReceiveOn<Self, DispatchQueue> {
        self.receive(on: queue, options: nil)
    }

    func on(success: @escaping ((Self.Output) -> Void),
            failure: @escaping ((Self.Failure) -> Void)) -> AnyCancellable {
        self.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                failure(error)
            case .finished:
                break
            }
        }, receiveValue: success)
    }
}
