//
//  SlotViewController.swift
//  SlotLabel
//
//  Created by Eden on 2023/9/5.
//

import UIKit

public class SlotViewController: UIViewController
{
    // MARK: - Properties -
    
    @IBOutlet private weak var slotNumberView: SlotNumberView!
    
    @IBOutlet private weak var button: UIButton!
    
    private
    var finalValue: Int = .random(in: 1000 ..< 10000)
    
    // MARK: - Methods -
    // MARK: Initial Method
    
    public init()
    {
        super.init(nibName: "SlotViewController", bundle: nil)
        
    }
    
    internal required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
    public override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
    
    // MARK: View Live Cycle
    
    public override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
    }
    
    public override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
    }
    
    public override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
    }
    
    public override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
    }
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.button.addTarget(self, action: #selector(self.startAnimate(_:)), for: .touchUpInside)
    }
    
    deinit
    {
        
    }
}

// MARK: - Actions -

private
extension SlotViewController
{
    @objc
    func startAnimate(_ sender: UIButton)
    {
        let finalValue = self.finalValue + Int.random(in: 1 ..< 100)
        let text = String(finalValue)
        
        self.finalValue = finalValue
        self.slotNumberView.text = text
    }
}

// MARK: - Private Methons -

private
extension SlotViewController
{
    func startAnimation()
    {
        
        
    }
}

// MARK: -

import SwiftUI

struct SlotViewControllerPreview: PreviewProvider
{
    static var previews: some View {
        
        ViewControllerPreviewer {
            
            SlotViewController()
        }
        .ignoresSafeArea()
    }
}
