//
//  SlotNumberView.swift
//  SlotLabel
//
//  Created by Eden on 2023/9/6.
//

import UIKit

public
class SlotNumberView: UIView
{
    // MARK: - Properties -
    
    public
    var text: String = "0" {
        
        didSet {
            
            self.updateText()
        }
    }
    
    public override
    var isUserInteractionEnabled: Bool {
        
        set {
            
            super.isUserInteractionEnabled = false
        }
        
        get {
            
            false
        }
    }
    
    
    @IBOutlet private
    var characterViews: Array<SlotCharacterView>!
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public override
    func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    deinit
    {
        
    }
}

private
extension SlotNumberView
{
    func updateText()
    {
        let textCount: Int = text.count
        self.characterViews.enumerated().forEach {
            
            [unowned self] (index, view) in
            
            let textIndex: Int = textCount - index - 1
            let isHidden: Bool = (textIndex < 0)
            
            view.textIndex = textIndex
            view.text = self.text
            view.isHidden = isHidden
        }
    }
}
