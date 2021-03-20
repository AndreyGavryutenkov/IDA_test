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
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
                
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            
            if let data = data, let image = self?.cachedImage(from: data, for: url.absoluteString as! NSString)  {
                print("Image cached!\n")
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
            
            self?.runningRequests.removeValue(forKey: uuid)
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


private extension ImageLoader {
    
    
    func cachedImage(from data: Data, for key: NSString) -> UIImage? {
        if let image = UIImage(data: data) {
            print("Caching image from: ", key)
            self.imageCache.setObject(image, forKey: key)
            return image
        }
        
        return nil
    }
}



