//
//  SlotCharacterCell.swift
//  SlotLabel
//
//  Created by Eden on 2023/9/5.
//

import UIKit

public class SlotCharacterCell: UITableViewCell
{
    // MARK: - Properties -
    
    public
    var text: String = "0" {
        
        willSet {
            
            self.label.text = newValue
        }
    }
    
    @IBOutlet private
    weak var label: UILabel!
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }
    
    deinit
    {
        
    }
}

// MARK: - Confirm Protocol -

extension SlotCharacterCell: CustomCellRegistrable
{
    public static var cellNib: UINib? {
        
        let nib = UINib(nibName: "SlotCharacterCell", bundle: nil)
        
        return nib
    }
    
    public static var cellIdentifier: String {
        
        return "SlotCharacterCell"
    }
}
