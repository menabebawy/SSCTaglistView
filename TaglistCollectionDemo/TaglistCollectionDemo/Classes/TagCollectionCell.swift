//
//  TagCollectionCell.swift
//  TaglistCollectionDemo
//
//  Created by Sanjaysinh Chauhan on 17/11/17.
//  Copyright © 2017 Sanjaysinh Chauhan. All rights reserved.
//

import UIKit
protocol TagColllectionCellDelegate {
    func removeTagAt(indexPath : IndexPath)
}

class TagCollectionCell: UICollectionViewCell {
    
    // IBOutlets
    @IBOutlet var lblTag: UILabel!
    @IBOutlet var viewTag: UIView!
    @IBOutlet var btnRemoveTag: CloseButton!
    
    // Variables
    var objTagName : String!
    var isCellSelected : Bool!
    var indexPath : IndexPath!
    var delegate : TagColllectionCellDelegate!
    var isHeightCalculated: Bool = false
    
    // IBActions
    @IBAction func removeAction(_ sender: CloseButton) {
        self.delegate.removeTagAt(indexPath: self.indexPath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // initial setup
        self.lblTag.backgroundColor = UIColor.clear
        self.backgroundColor = TagListTheme.shared.cellBackGroundColor
        self.lblTag.textColor = TagListTheme.shared.tagTextColor
        self.lblTag.font = TagListTheme.shared.textFont
        self.viewTag.backgroundColor = TagListTheme.shared.tagBackgroundColor
        self.viewTag.layer.cornerRadius = 15.0
        self.viewTag.clipsToBounds = true
        
        // Apply theme
        if (TagListTheme.shared.isShadowEnabled == true) {
            self.viewTag.layer.masksToBounds = false
            self.viewTag.layer.shadowRadius = TagListTheme.shared.tagShadowRadius
            self.viewTag.layer.shadowOpacity = TagListTheme.shared.tagShadowOpacity
            self.viewTag.layer.shadowOffset = CGSize.zero
            self.viewTag.layer.shadowColor = TagListTheme.shared.tagShadowColor.cgColor
        }
        else {
            self.viewTag.layer.borderWidth = TagListTheme.shared.tagBorderWidth
            self.viewTag.layer.borderColor = TagListTheme.shared.tagBorderColor.cgColor
        }
        
    }
    
    /// Cell configuration
    func configureCell() {
        
        self.lblTag.text = objTagName
        if(TagListTheme.shared.isDeleteEnabled == false) {
            self.btnRemoveTag.removeFromSuperview()
        }
        if(TagListTheme.shared.isDeleteEnabled == true) {
            if(self.isCellSelected == true) {
                self.viewTag.backgroundColor = TagListTheme.shared.selectionColor
                self.lblTag.textColor = TagListTheme.shared.selectionTagTextColor
                self.btnRemoveTag.tintcolor = TagListTheme.shared.selectionCloseIconTint
            }
            else {
                self.lblTag.textColor = TagListTheme.shared.tagTextColor
                self.viewTag.backgroundColor = TagListTheme.shared.tagBackgroundColor
                self.btnRemoveTag.tintcolor = TagListTheme.shared.closeIconTint
            }
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
}

