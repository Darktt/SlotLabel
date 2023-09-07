//
//  CustomCellRegisterable.swift
//
//  Created by Darktt on 19/8/13.
//  Copyright © 2019 Darktt. All rights reserved.
//

import UIKit

public protocol CustomCellRegisterable
{
    static var cellNib: UINib? { get }
    
    static var cellIdentifier: String { get }
}

// MARK: - Extensions -
// MARK: UITableView

public typealias UITableViewCellRegisterable = (UITableViewCell & CustomCellRegisterable)

public extension UITableView
{
    func register<Cell>(_ cell: Cell.Type) where Cell: UITableViewCellRegisterable
    {
        if let nib = cell.cellNib {
            
            self.register(nib, forCellReuseIdentifier: cell.cellIdentifier)
        } else {
            
            self.register(Cell.self, forCellReuseIdentifier: cell.cellIdentifier)
        }
    }
    
    func cellForRow<Cell>(_ cell: Cell.Type, at indexPath: IndexPath) -> Cell? where Cell: UITableViewCellRegisterable
    {
        let cell = self.cellForRow(at: indexPath) as? Cell
        
        return cell
    }
    
    func dequeueReusableCell<Cell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell? where Cell: UITableViewCellRegisterable
    {
        let cell = self.dequeueReusableCell(withIdentifier: cell.cellIdentifier, for: indexPath) as? Cell
        
        return cell
    }
}

// MARK: UICollectionView

public typealias UICollectionViewCellRegisterable = (UICollectionViewCell & CustomCellRegisterable)

public extension UICollectionView
{
    func register<Cell>(_ cell: Cell.Type) where Cell: UICollectionViewCellRegisterable
    {
        if let nib = cell.cellNib {
            
            self.register(nib, forCellWithReuseIdentifier: cell.cellIdentifier)
        } else {
            
            self.register(Cell.self, forCellWithReuseIdentifier: cell.cellIdentifier)
        }
    }
    
    func cellForItem<Cell>(_ cell: Cell.Type, at indexPath: IndexPath) -> Cell? where Cell: UICollectionViewCellRegisterable
    {
        let cell = self.cellForItem(at: indexPath) as? Cell
        
        return cell
    }
    
    func dequeueReusableCell<Cell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell? where Cell: UICollectionViewCellRegisterable
    {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cell.cellIdentifier, for: indexPath) as? Cell
        
        return cell
    }
}
