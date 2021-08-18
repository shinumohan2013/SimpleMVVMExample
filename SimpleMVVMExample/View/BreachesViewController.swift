//
//  ViewController.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 17/08/21.

import UIKit
import Alamofire
import PromiseKit

class BreachesViewController: UIViewController {
    
    var tableView = UITableView()
    var activityIndicator: UIActivityIndicatorView!

    var data = [BreachModel]()
    
    var breachesViewModel = BreachViewModel()
    private let photosURL = "https://jsonplaceholder.typicode.com/photos"
    private var photos: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        let backgroundQueue = DispatchQueue.global(qos: .background)
        
        firstly {
            self.tableView.isHidden = true
            return self.showLoader()
        }.then(on: backgroundQueue) {
            self.fetchJSON()
        }.then(on: backgroundQueue) { (photos) in
            self.downloadPhotos(photos: Array(photos.prefix(40)))
        }.done(on: DispatchQueue.main, flags: nil) { _ in
            self.hideLoader()
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }.catch { (error) in
                print(error.localizedDescription)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        
    }
}

extension BreachesViewController {
    
    private func showLoader() -> Guarantee<Void> {
        self.activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        self.activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        return Guarantee()
    }
    
    private func hideLoader() -> Guarantee<Void> {
        self.activityIndicator.stopAnimating()
        return Guarantee()
    }

    private func fetchJSON() -> Promise<[Photo]> {
        return Promise { seal in
            
            let request = AF.request(photosURL).validate().response { (data) in
                guard let data = data.data else {
                    seal.reject(PhotoError.ConvertToData)
                    return
                }
                guard let photos = try? JSONDecoder().decode([Photo].self, from: data) else {
                    seal.reject(PhotoError.PhotoDecoding)
                    return
                }
                seal.fulfill(photos)
            }
            // 2
            request.responseJSON { (data) in
                print(data)
            }
        }
    }
    
    private func downloadPhotos(photos: [Photo]) -> Promise<[UIImage]> {
        return Promise { seal in
            var count = 0
            for photo in photos {
                guard let photoUrl = URL(string: photo.url) else {
                    seal.reject(PhotoError.downloadPhotoUrl)
                    return
                }
                guard let photoData = try? Data(contentsOf: photoUrl) else {
                    seal.reject(PhotoError.downloadPhotoConvertToData)
                    return
                }
                guard let photoImage = UIImage(data: photoData) else {
                    seal.reject(PhotoError.downloadPhotoConvertToUIImage)
                    return
                }
                self.photos.append(photoImage)
                count+=1
                print("Finished downloading photo: " + String(count))
                
            }
            print("Finished downloading \(self.photos.count) photos")
            seal.fulfill(self.photos)
        }
    }
    
}

enum PhotoError: Error {
    case ConvertToData
    case PhotoDecoding
    case downloadPhotoUrl
    case downloadPhotoConvertToData
    case downloadPhotoConvertToUIImage
}

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

extension BreachesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = indexPath.row.description
        return cell
    }
}

extension BreachesViewController: UITableViewDelegate {
    
}

