//
//  Shopping.swift
//  Shopping List
//
//  Created by Barış Can Akkaya on 23.06.2021.
//

import Foundation
import RealmSwift

class Shopping: Object {
    @objc dynamic var product: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var isSelected: Bool = false
    
    convenience init(product: String) {
        self.init()
        self.product = product
    }
}


