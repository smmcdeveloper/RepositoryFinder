//
//  RepositoryTableViewCell.swift
//  RepositoryFinder
//
//  Created by SMMC on 15/10/2021.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(name: String, fullName: String) {
        self.name.text? = name
        self.fullName.text? = fullName
   }

}
