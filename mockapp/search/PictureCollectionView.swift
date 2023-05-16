//
//  PictureCollectionView.swift
//  mockapp
//
//  Created by tsewang sonam on 4/28/23.
//

import UIKit

class PictureCollectionView: UICollectionViewCell {


    
            static let id = "PictureCollectionView"
            
            private let imageView: UIImageView = {
                let imageView = UIImageView()
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFit
                return imageView
            }()
            
            override init(frame: CGRect) {
                super.init(frame: frame)
                contentView.addSubview(imageView)
            }
            
            required init?(coder: NSCoder) {
                fatalError()
            }
            
            override func layoutSubviews() {
                super.layoutSubviews()
                imageView.frame = contentView.bounds
            }
            
            override func prepareForReuse() {
                super.prepareForReuse()
                imageView.image = nil
            }
            
            func configure(with urlString : String){
                // URL object from the urlString is created
                guard let url = URL(string: urlString ) else {
                    return
                }
                
                // fetching the data from the URL with dataTask
                
                let _: Void = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    // Safely unwrap the data and check for errors
                    guard let data = data, error == nil else {
                        return
                    }
                    
                    // Switch to the main thread to update the UI
                    DispatchQueue.main.async{
                        let image = UIImage(data: data)
                        
                        self?.imageView.image = image
                    }
                }.resume() // Start the data task
            }
            
        


}
