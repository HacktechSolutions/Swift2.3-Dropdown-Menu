//
//  DropMenuButton.swift
//  DropDownMenu
//
//  Created by Marcos Paulo Rodrigues Castro on 9/1/16.
//  Copyright © 2016 HackTech. All rights reserved.
//

import UIKit

class DropMenuButton: UIButton, UITableViewDelegate, UITableViewDataSource
{
    var items = [String]()
    var table = UITableView()
    var act = Array<() -> (Void)>()
    
    var superSuperView = UIView()
    
    func showItems()
    {
        
        fixLayout()
  
        if(table.alpha == 0)
        {
            self.layer.zPosition = 1
            UIView.animateWithDuration(0.3, animations: { 
                self.table.alpha = 1;
            })
            
          
        }
        
        else
        {
            
            UIView.animateWithDuration(0.3, animations: { 
                self.table.alpha = 0;
                self.layer.zPosition = 0
            })
            
            
    
        }
        
    }

    
    func initMenu(items: [String], actions: [() -> (Void)])
    {
        self.items = items
        self.act = actions
        print(self.act.count)
        print("FD")
        
        
        var resp = self as UIResponder
        
        while !(resp.isKindOfClass(UIViewController.self) || (resp.isKindOfClass(UITableViewCell.self))) && resp.nextResponder() != nil {
            resp = resp.nextResponder()!
        }
   
        
        if let vc = resp as? UIViewController{
            superSuperView = vc.view
        }
        else if let vc = resp as? UITableViewCell{
            superSuperView = vc
        }
        
        table.delegate = self
        table.dataSource = self
        
        table = UITableView()
        table.rowHeight = self.frame.height
        table.delegate = self
        table.dataSource = self
        table.userInteractionEnabled = true
        table.alpha = 0
        table.separatorColor = self.backgroundColor
        superSuperView.addSubview(table)
        self.addTarget(self, action: #selector(DropMenuButton.showItems), forControlEvents: .TouchUpInside)
        
        //table.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
       
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func fixLayout()
    {
        
        let auxPoint2 = superSuperView.convertPoint(self.frame.origin, fromView: self.superview)
        
        var tableFrameHeight = CGFloat()
        
        if (items.count >= 3){
            tableFrameHeight = self.frame.height * 3
        }else{
            
            tableFrameHeight = self.frame.height * CGFloat(items.count)
        }
        table.frame = CGRect(x: auxPoint2.x, y: auxPoint2.y + self.frame.height, width: self.frame.width, height:tableFrameHeight)
        table.rowHeight = self.frame.height
        
        table.reloadData()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setNeedsDisplay()
        fixLayout()
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return items.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.setTitle(items[indexPath.row], forState: .Normal)
        self.setTitle(items[indexPath.row], forState: .Highlighted)
        self.setTitle(items[indexPath.row], forState: .Selected)
        
        if self.act.count > 1
        {
            self.act[indexPath.row]()
        }
        
        showItems()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let itemLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        itemLabel.textAlignment = NSTextAlignment.Center
        itemLabel.text = items[(indexPath as NSIndexPath).row]
        itemLabel.font = self.titleLabel?.font
        itemLabel.textColor = self.backgroundColor
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.redColor()
        
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        cell.backgroundColor = self.titleLabel?.textColor
        cell.selectedBackgroundView = bgColorView
        cell.separatorInset = UIEdgeInsetsMake(0, self.frame.width, 0, self.frame.width)
        cell.addSubview(itemLabel)
        
        
        return cell

    }


}
