//
//  ViewController.swift
//  FlyingSwiftExtension
//
//  Created by jun on 2019/6/29.
//  Copyright © 2019 OCX.ai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let jsonString =
    """
{
    "name":"jimmy",
    "age":28,
    "address":"china"
}
"""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let filePathUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("account.plist")
//        var accountPath  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! //因为你知道路径一定有，所以可以强制解包
//        accountPath = (accountPath as NSString ).appendingPathComponent("account.plist")
//        let accountPathURL = URL.init(string: accountPath)!
        
        JimmyLog(message: filePathUrl)
        
        
        let p2 = Person(name: "jimmy", age: 22, address: "china")
        JimmyLog(message: p2)
        
        let codedData = try! NSKeyedArchiver.archivedData(withRootObject: p2, requiringSecureCoding: false)
        
        
        
        do{
            try codedData.write(to: filePathUrl )
        }catch{
            print("Couldn't write to save file: " + error.localizedDescription)
        }
        
        // codable 只写入json格式
//        do{
//            //encode
//            var encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//            let encodeData = try encoder.encode(p2)
//
//            try encodeData.write(to: filePathUrl )
//        }catch{
//            print("Couldn't write to save file: " + error.localizedDescription)
//        }
        
        
        // 将 json 字符串转为 data 类型
//        if let jsonData = jsonString.data(using: String.Encoding.utf8) {
//            if let person = try? JSONDecoder().decode(Person.self, from: jsonData){
//                // 转换成功，我们将数据输出
//                print(person.name!,person.age!,person.address!)
//            }
//        }
        
//        //decode
//        let jsonData = jsonString.data(using: .utf8)!
//        let persons = try JSONDecoder().decode([MyPerson].self, from: jsonData)
        
//        //encode
//        var encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        let encodeData = encoder.encode(p2)
        
    }
}

