//
//  CustomTableView.swift
//  ClassNotes
//
//  Created by 岡本　優河 on 2018/07/01.
//  Copyright © 2018年 岡本　優河. All rights reserved.
//

import Foundation
import UIKit

class CustomTableView: UITableView{
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touchesBeganを次のResponderへ
        self.next?.touchesBegan(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {        
  }
}
