//
//  AccountTableViewCell.swift
//  Created by Shinu Mohan on 24/08/21.

import UIKit

class AccountTableViewCell: UITableViewCell {

    var nameLabel: UILabel!
    var numberLabel: UILabel!
    var contactLabel: UILabel!
    var balanceLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.darkGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

            nameLabel = UILabel(frame: CGRect(x: 10,y: 5,width: 200,height: 40))
            nameLabel.textAlignment = .left
            nameLabel.textColor = UIColor.black
            contentView.addSubview(nameLabel)

            numberLabel = UILabel(frame: CGRect(x: 10,y: 45,width: 150,height: 20))
            numberLabel.textAlignment = .left
            numberLabel.textColor = UIColor.purple
            contentView.addSubview(numberLabel)

            contactLabel = UILabel(frame: CGRect(x: 140,y: 45,width: 200,height: 20))
            contactLabel.textAlignment = .left
            contactLabel.textColor = UIColor.lightGray
            contentView.addSubview(contactLabel)
            
            balanceLabel = UILabel(frame: CGRect(x: 160,y: 5,width: 200,height: 40))
            balanceLabel.textAlignment = .right
            balanceLabel.textColor = UIColor.purple
            contentView.addSubview(balanceLabel)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
