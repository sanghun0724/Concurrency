//
//  PhotoOperations.swift
//  Concurrency_Images
//
//  Created by sangheon on 2023/03/04.
//

import UIKit

enum PhotoState {
    case new, downloaded, failed
}

class Photo {
  let name: String
  let url: URL
  var state = PhotoState.new
  var image = UIImage(named: "Placeholder")
  
  init(name:String, url:URL) {
    self.name = name
    self.url = url
  }
}

class PendingOperations {
    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
      var queue = OperationQueue()
      queue.name = "Download queue"
      queue.maxConcurrentOperationCount = 1
      return queue
    }()
}

class ImageDownloader: Operation {
  //1
  let photo: Photo
  
  //2
  init(_ photo: Photo) {
    self.photo = photo
  }
  
  //3
  override func main() {
    //4
    if isCancelled {
      return
    }
    
    //5
    guard let imageData = try? Data(contentsOf: photo.url) else { return }
    
    //6
    if isCancelled {
      return
    }
    
    //7
    if !imageData.isEmpty {
        photo.image = UIImage(data: imageData)
        photo.state = .downloaded
    } else {
        photo.state = .failed
        photo.image = UIImage(named: "Failed")
    }
  }
}
