//
//  WordManager.swift
//  VocabList
//
//  Created by Kaan Odabaş on 22.08.2023.
//

import Foundation

class WordManager {
    static let shared = WordManager()  // Singleton instance

    var words: [Word] = []
    var currentIndex = 0

    private init() {
        // JSON dosyasını yükle ve words dizisine ekle
        if let url = Bundle.main.url(forResource: "words", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let wordData = jsonData["words"] as? [[String: String]] {
            words = wordData.compactMap { word in
                guard let english = word["english"], let turkish = word["turkish"] else {
                    return nil
                }
                return Word(english: english, turkish: turkish)
            }
        }
    }

    func getRandomWord() -> Word? {
        guard !words.isEmpty else {
            return nil
        }
        currentIndex = Int.random(in: 0..<words.count)
        return words[currentIndex]
    }
}
