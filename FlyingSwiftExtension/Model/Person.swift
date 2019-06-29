//
//  Person.swift
//  FlyingSwiftExtension
//
//  Created by jun on 2019/6/29.
//  Copyright © 2019 OCX.ai. All rights reserved.
//

import Foundation

/// Persion模型，遵循 Codable 协议
class Person: NSObject,Codable,NSCoding {
    var name: String?
    var age: Int?
    var address: String?
    
    init(name:String,age:Int,address:String){
        self.name = name
        self.age = age
        self.address = address
    }
    
    override var description: String {
        return "姓名：\(self.name)，年龄：\(self.age),地址：\(self.address)"
    }

    // MARK: -   协议必须实现的方法
    // 自定义对象必须实现这个方法，（那些属性需要归档，归档时怎么存储）
    func encode(with aCoder: NSCoder)  {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(address, forKey: "address")
    }
    
    
 

    // 自定义对象解档必须实现这个方法，（那些属性需要解档，解档后怎么赋值）
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String
        age = aDecoder.decodeObject(forKey: "age") as? Int
        address = aDecoder.decodeObject(forKey: "address") as? String
    }
}
