//
//  DetailViewController.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 24/08/21.

import UIKit
import PromiseKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    private var tableView : UITableView!
    var objects = NSMutableArray()
    var activityIndicator: UIActivityIndicatorView!
    var accountArray = NSArray()
    var cardArray = NSArray()

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        self.title = "Customer Detail Page"
        
        tableView = UITableView()
        registerTableViewCells();
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
        
        if self.loadJson(fileName: "AccountJson") != nil {
            let persAccounts = self.loadJson(fileName: "AccountJson")
            if let accounts = persAccounts?.accounts {
                accountArray = accounts as NSArray
            }
            if let cards = persAccounts?.accounts {
                cardArray = cards as NSArray
            }
            print(accountArray)
            print(cardArray)
        }
    }
    
    func registerTableViewCells(){
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageTableViewCell")
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "CardTableViewCell")
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "AccountTableViewCell")
    }
    
    func setupTableView() {
      view.addSubview(tableView)
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}

// MARK :- Loading Indicator Helper Methods

extension DetailViewController {
    
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

extension DetailViewController {
    
    func loadJson(fileName: String) -> PersonnalAccounts? {
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let personAccounts = try? decoder.decode(PersonnalAccounts.self, from: data)
       else {
            return nil
       }
       return personAccounts
    }
}

extension DetailViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
            return "New Message"
            case 1:
            return "Accounts"
            case 2:
            return "Cards"
            default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         switch section {
            case 0:
            return 1
            case 1:
            return accountArray.count
            case 2:
            return cardArray.count
            default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.accessoryType = .disclosureIndicator
            return cell;
            case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
                let obj = accountArray[indexPath.row] as! Account
                cell.nameLabel.text = obj.accountName
                cell.numberLabel.text = obj.accountNumber
                cell.contactLabel.text = obj.contactNumber
                cell.balanceLabel.text = obj.currentBalance
            return cell;
            case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
                let obj = cardArray[indexPath.row] as! Account
            cell.nameLabel.text = obj.cardType
            cell.numberLabel.text = obj.accountNumber
            cell.contactLabel.text = obj.contactNumber
            cell.balanceLabel.text = obj.currentBalance
            return cell;
            default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
            return cell;
        }
    }
}

extension DetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
            return
            default:
            return
        }
    }
}
