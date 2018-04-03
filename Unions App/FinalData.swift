//
//  FinalData.swift
//  Unions App
//
//  Created by Hitendra Dubey on 03/04/18.
//  Copyright © 2018 Hitendra Dubey. All rights reserved.
//

import Foundation
import RealmSwift
class FinalData: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var emailId : String = ""
    @objc dynamic var accountId : String = ""
}
