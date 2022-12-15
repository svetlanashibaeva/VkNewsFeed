//
//  WebImageView.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 25.11.2022.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlString: String?
    
    func set(imageURL: String?) {
        currentUrlString = imageURL
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            print("from cache")
            return
        }
        
        print("from internet")
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
        
        if responseUrl.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
}
