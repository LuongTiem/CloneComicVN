//
//  CellCategory.swift
//  ComicVN
//
//  Created by tubjng on 9/30/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
class AppCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "chobeo.jpg")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()

    func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)

        
        imageView.frame = CGRect(x: 10, y: 10, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 10, y: frame.width + 7, width: frame.width, height: 40)


    }

    
}


