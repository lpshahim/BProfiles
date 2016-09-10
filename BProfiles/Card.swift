//
//  Card.swift
//  BProfiles
//
//  Created by Louis-Philip Shahim on 2016/06/28.
//  Copyright © 2016 Louis-Philip Shahim. All rights reserved.
//

import Foundation
import UIKit

class Card: UIView {
    
    let artists = ["Shei Phan","Cavier Coleman","Sellah", "Chris Cuffaro", "Gregory Maroun", "Ev Bessar", "Kristen Reichert"]
    var currentArtist: String!
    
    
    @IBOutlet weak var shapeImage: UIImageView!
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        selectArtist()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        self.setNeedsLayout()
    }
    
    func selectArtist() {
        currentArtist = artists[Int(arc4random_uniform(7))]
        shapeImage.image = UIImage(named: currentArtist)
        
    }
    
    
    
}