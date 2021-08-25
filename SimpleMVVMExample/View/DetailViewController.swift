//
//  DetailViewController.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 24/08/21.

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    private var tableView : UITableView!

    var objects = NSMutableArray()
    var accountArray = [["AccountName":"CTC Media Inc.","Account Number":"54678","Contact Number":"12678-89","Current Balance":"12448 Kr"],
                       ["AccountName":"ING Media Inc.","Account Number":"54678","Contact Number":"12678-89","Current Balance":"78678 Kr"],
                       ["AccountName":"SKANDIN Media Inc.","Account Number":"54678","Contact Number":"12678-89","Current Balance":"89786 Kr"],
                       ["AccountName":"SYSKA Media Inc.","Account Number":"54678","Contact Number":"12678-89","Current Balance":"34556 Kr"]
                    ]
    
    var cardArray = [["CardType":"VISA","Account Number":"54678","Contact Number":"12678-89","Current Balance":"12448 Kr"],
      ["CardType":"MasterCard","Account Number":"54678","Contact Number":"12678-89","Current Balance":"12448 Kr"],
      ["CardType":"CreditCard","Account Number":"54678","Contact Number":"12678-89","Current Balance":"12448 Kr"],
      ["CardType":"DebitCard","Account Number":"54678","Contact Number":"12678-89","Current Balance":"12448 Kr"]
    ]

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
            let obj = accountArray[indexPath.row] as NSDictionary
            cell.nameLabel.text = obj["AccountName"] as? String;
            cell.numberLabel.text = obj["Account Number"] as? String;
            cell.contactLabel.text = obj["Contact Number"] as? String;
            cell.balanceLabel.text = obj["Current Balance"] as? String;
            return cell;
            case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
            let obj = cardArray[indexPath.row] as NSDictionary
            cell.nameLabel.text = obj["CardType"] as? String;
            cell.numberLabel.text = obj["Account Number"] as? String;
            cell.contactLabel.text = obj["Contact Number"] as? String;
            cell.balanceLabel.text = obj["Current Balance"] as? String;
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
//                let messageView = MessageViewController();
//                self.navigationController!.pushViewController(messageView, animated: true)
            return
            default:
            return
        }
    }
}
