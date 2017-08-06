//
//  ClientCell.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 8/5/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class ClientCell: UITableViewCell {
    @IBOutlet weak var firstNameLabel: UILabel!

    @IBOutlet weak var emailAddressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(client: User) {
        firstNameLabel.text = "\(client.firstName)"
        emailAddressLabel.text = "\(client.emailAddress)"
    }
    
    
    
    
    
}
