//
//  NamesDictionary.swift
//
//
//  Created by Radzivon Bartoshyk on 11/01/2023.
//

import Foundation
import Yams

public struct NamesGenerator {

    private static var savedPrefixes: [[String]] = []
    private static var savedWords: [[String]] = []
    private static let lock = NSLock()
    private static var isInitialized = false

    static func register() throws {
        guard !NamesGenerator.isInitialized else {
            return
        }
        let prefixes = try ["adjectives", "colors"].map { name in
            if let url = Bundle.module.url(forResource: name, withExtension: "yml") {
                return url
            } else {
                throw PrepareResourcesError(name: name)
            }
        }.map { url in
            try YAMLDecoder().decode(NamesDictionary.self, from: try Data(contentsOf: url, options: .mappedIfSafe))
        }.map { $0.items }
        let words = try ["animals", "star_wars", "stars", "witcher", "westeros"].map { name in
            if let url = Bundle.module.url(forResource: name, withExtension: "yml") {
                return url
            } else {
                throw PrepareResourcesError(name: name)
            }
        }.map { url in
            try YAMLDecoder().decode(NamesDictionary.self, from: try Data(contentsOf: url, options: .mappedIfSafe))
        }.map { $0.items }
        NamesGenerator.savedWords = words
        NamesGenerator.savedPrefixes = prefixes
        NamesGenerator.isInitialized = true
    }

    public struct PrepareResourcesError: LocalizedError {
        let name: String
        public var errorDescription: String? {
            "Names generator can't prepare resource named: \(name)"
        }
    }

    public struct InitializationError: LocalizedError {
        public var errorDescription: String? {
            "Initialization failed due to unknown reasons"
        }
    }

    public static func generate() throws -> String {
        try lock.withLock {
            try register()
            if NamesGenerator.savedPrefixes.isEmpty || NamesGenerator.savedWords.isEmpty {
                throw InitializationError()
            }
        }

        let anyPair = [NamesGenerator.savedPrefixes[Int.random(in: 0..<NamesGenerator.savedPrefixes.count)],
                       NamesGenerator.savedWords[Int.random(in: 0..<NamesGenerator.savedWords.count)]]
        let generated = anyPair
            .map { $0[Int.random(in: 0..<$0.count)] }
            .compactMap { $0 }
            .map { $0.capitalized }.joined(separator: " ")
        return "\(generated.prefix(92))"
    }

}
