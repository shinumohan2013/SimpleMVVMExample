//
//  PhotoListViewController.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 17/08/21.

import UIKit
import Alamofire
import PromiseKit

class PhotoListViewController: UIViewController {
    
    var tableView = UITableView()
    var activityIndicator: UIActivityIndicatorView!
    var data = [PhotoModel]()
    var photosViewModel = PhotoViewModel()
    private let photosURL = "https://jsonplaceholder.typicode.com/photos"
    private var photos: [UIImage] = []

// MARK :- View LifeCycle

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
        
        tableView.register(CustomPhotoCell.self, forCellReuseIdentifier: "imageCell")
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

// MARK :- Loading Indicator Helper Methods

extension PhotoListViewController {
    
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
}

// MARK :- Photo Api Calls

extension PhotoListViewController {
    
    private func fetchJSON() -> Promise<[PhotoModel]> {
        return Promise { seal in
            let request = AF.request(photosURL).validate().response { (data) in
                guard let data = data.data else {
                    seal.reject(PhotoViewModel.PhotoError.ConvertToData)
                    return
                }
                guard let photos = try? JSONDecoder().decode([PhotoModel].self, from: data) else {
                    seal.reject(PhotoViewModel.PhotoError.PhotoDecoding)
                    return
                }
                seal.fulfill(photos)
            }
            
            request.responseJSON { (data) in
                print(data)
            }
        }
    }
    
    private func downloadPhotos(photos: [PhotoModel]) -> Promise<[UIImage]> {
        return Promise { seal in
            var count = 0
            for photo in photos {
                guard let photoUrl = URL(string: photo.url) else {
                    seal.reject(PhotoViewModel.PhotoError.downloadPhotoUrl)
                    return
                }
                guard let photoData = try? Data(contentsOf: photoUrl) else {
                    seal.reject(PhotoViewModel.PhotoError.downloadPhotoConvertToData)
                    return
                }
                guard let photoImage = UIImage(data: photoData) else {
                    seal.reject(PhotoViewModel.PhotoError.downloadPhotoConvertToUIImage)
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

// MARK :- TableViewDataSource

extension PhotoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! CustomPhotoCell
        cell.imgUser.image = self.photos[indexPath.row]
        cell.labUerName.text = indexPath.row.description
        cell.labMessage.text = indexPath.row.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK :- TableViewDelegate

extension PhotoListViewController: UITableViewDelegate {
    
}

// MARK :- TableViewCell

class CustomPhotoCell: UITableViewCell {
    
    let imgUser = UIImageView()
    let labUerName = UILabel()
    let labMessage = UILabel()
    let labTime = UILabel()
    
    let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true // this will make sure its children do not go out of the boundary
      return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgUser.translatesAutoresizingMaskIntoConstraints = false
        labUerName.translatesAutoresizingMaskIntoConstraints = false
        labMessage.translatesAutoresizingMaskIntoConstraints = false
        labTime.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imgUser)
        contentView.addSubview(labUerName)
        contentView.addSubview(labMessage)
        contentView.addSubview(labTime)

        let viewsDict = [
            "image" : imgUser,
            "username" : labUerName,
            "message" : labMessage,
            "labTime" : labTime,
        ] as [String : Any]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(10)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[labTime]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-[image(10)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-[labTime]-|", options: [], metrics: nil, views: viewsDict))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
