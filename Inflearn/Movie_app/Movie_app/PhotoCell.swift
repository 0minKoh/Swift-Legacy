//
//  PhotoCell.swift
//  Movie_app
//
//  Created by supaja on 2023/02/04.
//

import UIKit
import PhotosUI

class PhotoCell: UICollectionViewCell {
    
    func loadImage(asset: PHAsset) {
        
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
        
        // 옵션: 화질 결정
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic
        
        // 초기 이미지를 제거
        self.photoImageView.image = nil
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options) { image, info in
            // 저화질, 고화질 옵션으로 선택
//            if ( info?[PHImageResultIsDegradedKey] as? Bool) == true {
//                //저화질
//
//            } else {
//                //고화질
//            }
            
            // default: 저화질, 고화질 모두 가져옴
            self.photoImageView.image = image
        }
        
    }
    
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.contentMode = .scaleAspectFill
        }
    }
}
