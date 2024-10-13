//
//  CatViewModel.swift
//  Cats
//
//  Created by aljon antiola on 10/11/24.
//

import Foundation
import UIKit

class CatViewModel {
    
    private let defaultDataCount = 10
    
    var catFacts: [String] = []
    var catImageUrls: [CatImage] = []
    var currentImageIndex = 0
    var imageCache: [String: UIImage] = [:]
    
    private let catAPIService = CatAPIService()
    
    // Fetch both cat facts and images concurrently using DispatchGroup
    func fetchCatData(completion: @escaping (Error?) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        var fetchError: Error? // To capture any errors during fetching
        
        dispatchGroup.enter()
        fetchCatFact(count: defaultDataCount) { error in
            if let error = error {
                fetchError = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchCatImage(limit: defaultDataCount) { error in
            if let error = error {
                fetchError = error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(fetchError) // Return any captured errors
        }
    }
    
    private func fetchCatFact(count: Int, completion: @escaping (Error?) -> Void) {
        catAPIService.fetchCatFact(count: count) { [weak self] result in
            switch result {
            case .success(let facts):
                self?.catFacts = facts
                completion(nil)
            case .failure(let error):
                self?.catFacts = []
                completion(error)
            }
        }
    }
    
    private func fetchCatImage(limit: Int, completion: @escaping (Error?) -> Void) {
        catAPIService.fetchCatImage(limit: limit) { [weak self] result in
            switch result {
            case .success(let imageUrls):
                self?.catImageUrls = imageUrls
                completion(nil)
            case .failure(let error):
                self?.catImageUrls = []
                completion(error) // Return the error
            }
        }
    }
    
    // Load the image and cache it
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let urlString = url.absoluteString
        
        // Check if image is already cached
        if let cachedImage = imageCache[urlString] {
            print("Loading image from cache: \(urlString)")
            completion(cachedImage)
            return
        }
        
        // If not cached, download and cache the image
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            // Cache the image
            self.imageCache[urlString] = image
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }

    // Preload the next image and cache it
    func preloadNextImage() {
        clearImageCache()
        
        let nextIndex = currentImageIndex + 1
        guard nextIndex < catImageUrls.count else { return }
        
        let catImage = catImageUrls[nextIndex]
        
        // If not already cached, load and cache it
        if imageCache[catImage.url] == nil, let url = URL(string: catImage.url) {
            loadImage(from: url) { _ in
                // Preloaded and cached the next image
            }
        }
    }
    
    // Method to fetch next image URL
    func getNextImageUrl() -> String? {
        guard !catImageUrls.isEmpty, currentImageIndex < catImageUrls.count else {
            return nil
        }
        return catImageUrls[currentImageIndex].url
    }
    
    func advanceToNextImage() {
        currentImageIndex += 1
        if currentImageIndex >= catImageUrls.count {
            currentImageIndex = 0 // Loop back if needed
        }
    }
    
    // Method to fetch next cat fact
    func getNextFact() -> String? {
        guard !catFacts.isEmpty else { return nil }
        return catFacts.removeFirst()
    }
    
    // Check if new data should be fetched
    func shouldFetchNewData() -> Bool {
        return currentImageIndex >= catImageUrls.count || catFacts.isEmpty
    }
    
    func clearImageCache() {
        imageCache.removeAll()
    }
}
