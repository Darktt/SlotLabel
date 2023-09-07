//
//  SlotCharacterView.swift
//  SlotLabel
//
//  Created by Eden on 2023/9/5.
//

import UIKit
import SwiftExtensions

class SlotCharacterView: UIView
{
    // MARK: - Properties -
    
    public
    var textIndex: Int = 0
    
    public
    var text: String = "0" {
        
        didSet {
            
            self.updateTableView(from: oldValue)
        }
    }
    
    @IBOutlet private
    weak var tableView: UITableView!
    
    fileprivate
    var offset: Int = 0
    
    fileprivate
    var finalValue: Int = 0
    
    private
    lazy var tableViewDelegate: TableViewDelegate = {
        
        TableViewDelegate(parent: self)
    }()
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.tableView.fluent
            .dataSource(self.tableViewDelegate)
            .delegate(self.tableViewDelegate)
            .rowHeight(22.0)
            .separatorStyle(.none)
            .estimatedRowHeight(22.0)
            .showsVerticalScrollIndicator(false)
            .showsHorizontalScrollIndicator(false)
            .subject
            .register(SlotCharacterCell.self)
        
        self.backgroundColor = .clear
    }
    
    deinit
    {
        
    }
}

// MARK: - Private Methods -

private
extension SlotCharacterView
{
    func updateTableView(from oldText: String)
    {
        guard self.textIndex >= 0, self.text != oldText else {
            
            return
        }
        
        self.updateOffset(with: oldText)
        self.tableView.reloadData()
        self.tableView.scrollToRow(self.offset, atScrollPosition: .middle, animated: false)
        self.startAnimation()
    }
    
    func updateOffset(with oldText: String)
    {
        let oldText: String = {
            
            guard self.text.count > oldText.count else {
                
                return oldText
            }
            
            /**
             如果新值的字數比舊值多，
             那麼將舊值的前面補 0，
             （eg: 99 -> 1000, 此時舊值變成 0099 -> 1000）
             讓兩值的長度相等
             */
            let textOffset: Int = self.text.count - oldText.count
            let prefix = Array(repeating: "0", count: textOffset)
            
            return prefix.joined() + oldText
        }()
        
        let value = Int(self.text[self.textIndex]) ?? 0
        let oldValue = Int(oldText[self.textIndex]) ?? 0
        var offset = value - oldValue
        /**
         如果 offset 小於 0 的話，
         （eg: 9 -> 10, 11 -> 20）
         那麼就設定為 value 的值
         */
        if offset < 0 {
            
            offset = value
        }
        
        let needsUpdate: Bool = {
            
            guard self.textIndex != 0 else {
                
                // 是第一位數字，就不做任何差異量調整
                return false
            }
            
            if let previousValue = Int(self.text[self.textIndex - 1]),
               let previousOldValue = Int(oldText[self.textIndex - 1]),
               previousValue != previousOldValue {
                
                /**
                 如果前數字有差異時（進位），才進行差異量調整
                 */
                return true
            }
            
            return false
        }()
        if needsUpdate {
            
            // 需做差異量調整就增加 10 次方的差異量
            offset += Int(10.0.pow(Double(self.textIndex)))
        }
        
        self.offset = offset
        self.finalValue = value
    }
    
    func startAnimation()
    {
        self.tableView.scrollToRow(0, atScrollPosition: .top)
    }
}

// MARK: - SlotCharacterView.TableViewDelegate -

private
extension SlotCharacterView
{
    class TableViewDelegate: NSObject
    {
        // MARK: - Properties -
        
        private weak
        var parent: SlotCharacterView?
        
        private
        var textIndex: Int {
            
            self.parent?.textIndex ?? 0
        }
        
        private
        var offset: Int {
            
            self.parent?.offset ?? 0
        }
        
        private
        var finalValue: Int {
            
            self.parent?.finalValue ?? 0
        }
        
        // MARK: - Methods -
        // MARK: Initial Method
        
        convenience
        init(parent: SlotCharacterView)
        {
            self.init()
            
            self.parent = parent
        }
    }
}

// MARK: - Delegate Mehtods -

extension SlotCharacterView.TableViewDelegate: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.offset + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(SlotCharacterCell.self, for: indexPath) else {
            
            return UITableViewCell()
        }
        
        let index: Int = indexPath.row
        var value: Int = ((index - self.finalValue) - 10).absoluteValue
        value = value.modulo(by: 10)
        
        let text: String = String(value)
        cell.text = text
        
        return cell
    }
}
