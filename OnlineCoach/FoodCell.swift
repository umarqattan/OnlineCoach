//
//  FoodCell.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/26/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var servingSizeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fiberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    func configure(food: Food) {
        foodNameLabel.text = food.name
        servingSizeLabel.text = "\(food.servingSize) " + "\(food.servingSizeUnits ?? "")"
        caloriesLabel.text = "\(food.calories)"
        fatLabel.text = "\(food.fat)"
        carbLabel.text = "\(food.carb)"
        proteinLabel.text = "\(food.protein)"
        fiberLabel.text = "\(food.fiber)"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
