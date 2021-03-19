//
//  ImageLoader.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import Foundation
import UIKit



class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        print(#function, "url: ", url.absoluteURL)
      if let image = loadedImages[url] {
        completion(.success(image))
        return nil
      }

      let uuid = UUID()

      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        

        if let data = data, let image = UIImage(data: data) {
          self.loadedImages[url] = image
          completion(.success(image))
          return
        }

        guard let error = error else {
          return
        }

        guard (error as NSError).code == NSURLErrorCancelled else {
          completion(.failure(error))
          return
        }
        
        self.runningRequests.removeValue(forKey: uuid)
      }
      task.resume()
      runningRequests[uuid] = task
      return uuid
    }
    
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
    
}



