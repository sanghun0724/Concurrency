//
//  ViewController.swift
//  Concurrency_Images
//
//  Created by sangheon on 2023/03/04.
//

import UIKit

final class DownloadTableViewController: UITableViewController {
    var photos: [Photo] = [
        .init(name: "귀요미", url: URL(string: "https://picsum.photos/200")!),
        .init(name: "귀요미", url: URL(string: "https://picsum.photos/200")!),
        .init(name: "귀요미", url: URL(string: "https://picsum.photos/200")!),
        .init(name: "귀요미", url: URL(string: "https://picsum.photos/200")!),
        .init(name: "귀요미", url: URL(string: "https://picsum.photos/200")!)
        
    ]
    let pendingOperations = PendingOperations()
    
    private lazy var loadAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load All Image", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(loadAllImage), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(DownLoadTableViewCell.self, forCellReuseIdentifier: "DownLoadTableViewCell")
        configureFooterView()
    }
    
    private func configureFooterView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        footerView.addSubview(loadAllButton)
        loadAllButton.frame = .init(x: tableView.frame.midX, y: footerView.frame.midY, width: tableView.frame.width, height: 100)
        tableView.tableFooterView = loadAllButton
    }
    
    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DownLoadTableViewCell", for: indexPath) as? DownLoadTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.loadImageView.image = photos[indexPath.row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    // When loadButton click..!
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        startDownload(for: photos[indexPath.row], at: indexPath)
    }
    
    func startDownload(for photo: Photo, at indexPath: IndexPath) {
      //1
      guard pendingOperations.downloadsInProgress[indexPath] == nil else {
        return
      }
      
      //2
      let downloader = ImageDownloader(photo)
      startIndicator(at: indexPath)
        
      //3
      downloader.completionBlock = {
        if downloader.isCancelled {
          return
        }
        
        DispatchQueue.main.async {
          self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
          self.stopIndicator(at: indexPath)
          self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
      }
      //4
      pendingOperations.downloadsInProgress[indexPath] = downloader
      //5
      pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    private func startIndicator(at indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! DownLoadTableViewCell
        cell.loadImageView.image = .init()
        cell.indicator.isHidden = false
        cell.indicator.startAnimating()
    }
    
    private func stopIndicator(at indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! DownLoadTableViewCell
        cell.indicator.isHidden = true
        cell.indicator.stopAnimating()
    }
    
    @objc
    private func loadAllImage() {
        for index in 0..<photos.count {
            startDownload(for: photos[index], at: IndexPath(row: index, section: 0))
        }
    }
    
}


