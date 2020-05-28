//
//  RunLogCell.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 28/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {
    
    @IBOutlet weak var runDurationLbl: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var averagePaceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(run: Run) {
        runDurationLbl.text = run.duration.formatTimeDurationToString()
        totalDistanceLbl.text = "\(run.distance.metersToKm(decimals: 2)) km"
        averagePaceLbl.text = run.pace.formatTimeDurationToString()
        dateLbl.text = run.date.dateString()  //date format is not as we need hence we have created extension for NSDate and created dateString func
    }

}
