//
//  BaseCollectionViewCell.swift
//  EyeTest
//
//  Created by edy on 2024/12/16.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: -
    
    func setWith(title:String,imageName:String){
        L.isHidden = false
        I.isHidden = false

        if title.count == 0 {
            L.isHidden = true
        }else{
            L.text = title
        }
        
        if imageName.count == 0 {
            I.isHidden = true
        }else{
            I.image = UIImage.init(named: imageName)
        }
    }
    
    @IBOutlet weak var L: UILabel!
    @IBOutlet weak var I: UIImageView!
    
}
