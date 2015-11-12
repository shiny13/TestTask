//
//  ScrollViewContainer.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 10/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

class ScrollViewContainer: UIView {
    
    //MARK: Properties
    @IBOutlet var scrollView1: UIScrollView?
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
        let view = super.hitTest(point, withEvent: event)
        if let theView = view {
            if theView == self {
                return scrollView1
            }
        }
        
        return view
    }
    
}
