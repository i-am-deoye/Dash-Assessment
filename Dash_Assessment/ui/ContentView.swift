//
//  ContentView.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit


 class ContentView: UIView {
     var any: Any?
     var isLayoutSubviewsLoaded = false
     
     required init() {
         super.init(frame: .zero)
         self.backgroundColor = UIColor.white
         self.translatesAutoresizingMaskIntoConstraints = false
         setup()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         self.backgroundColor = UIColor.white
     }
     
    
     func setup() {}
     
}

