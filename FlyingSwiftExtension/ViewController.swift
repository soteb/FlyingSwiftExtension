//
//  ViewController.swift
//  FlyingSwiftExtension
//
//  Created by jun on 2019/6/29.
//  Copyright © 2019 OCX.ai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - 储存属性，不能写在extension
    let jsonString =
    """
{
    "name":"rex",
    "age":29,
    "address":"canton"
}
"""

    let dict: [String : Any] = [
        "name" : "jimmyDict",
        "age" : 28 ,
        "address" : "gz"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - 点击屏幕触发
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // MARK: - 测试一：对象object保存到沙盒localFile
        // 逻辑：object  save as -> localFile
//        object2LocalFile()
        
        // MARK: - 测试二：字典转json保存到本地沙盒
        // 逻辑： dict -> json -> localFile
        dict2json2Local()
 
        

        
    }
}

// FIXME: - codable编码逻辑
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


// FIXME: - （字典 -> KVO -> 模型）逻辑
/*
 1.通过AFNetwork获取（result,error)的result 字典
 2.字典 -> KVO -> 模型 ，在model的属性使用@objc 关键词
 3.model实现nscoding，用VNSKeyedArchiver.archivedData 转data
 4.write 进去 沙盒目录
 
 2.用codable 脱离 @objc
 
 */



// MARK: - 获得 沙盒 路径 方法一
extension ViewController {
    
    func getFilePathUrl(fileName : String) -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
    }
}

// MARK: - 获得 沙盒 路径 方法二
extension ViewController {
    func getFilePathUrl2(){
        //        var accountPath  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! //因为你知道路径一定有，所以可以强制解包
        //        accountPath = (accountPath as NSString ).appendingPathComponent("account.plist")
        //        let accountPathURL = URL.init(string: accountPath)!
    }
 
}

// MARK: - 对象保存到沙盒测试代码
// 逻辑：object  save as -> localFile
extension ViewController {
    func object2LocalFile(){
        // 1.获得沙盒路径
        let filePathUrl = getFilePathUrl(fileName: "personJson.plist")
        JimmyLog(message: filePathUrl)

        // 2.创建待保存的文件的对象
        let p1 = Person(name: "jimmy", age: 22, address: "china")
        JimmyLog(message: p1)

        // 3.归档数据
        let codedData = try! NSKeyedArchiver.archivedData(withRootObject: p1, requiringSecureCoding: false)

        // 4.写入x沙盒目录
        do{
            try codedData.write(to: filePathUrl )
        }catch{
            print("不能写入文件: " + error.localizedDescription)
        }
    }
}

// MARK: - 测试二：字典转json保存到本地沙盒
// 逻辑： dict -> json -> localFile
extension ViewController {
    func dict2json2Local(){
        // 1.获得沙盒路径
        let filePathUrl = getFilePathUrl(fileName: "personDict.plist")
        JimmyLog(message: filePathUrl)
        
        // 2.创建待保存的文件的对象
        
        let p2 = try? JSONModel(Person.self, withKeyValues: dict)
        JimmyLog(message: p2)

        
        // 3.归档数据
        // 需要在model实现nscoding协议,当然也少不了codable
        //        let codedData = try! NSKeyedArchiver.archivedData(withRootObject: p2, requiringSecureCoding: false)
        // 只需要实现codable，不需要nscoding
        let codedData = try! PropertyListEncoder().encode(p2)
        
        // 4.写入沙盒目录
        do{
            try codedData.write(to: filePathUrl )
        }catch{
            print("不能写入文件: " + error.localizedDescription)
        }
        
        // 5.读取数据
        // FIXME: - 强制解包有问题
        let contents = try! Data(contentsOf: filePathUrl)
        let decodedPerson = try! PropertyListDecoder().decode(Person.self, from: contents) // 解码
        print(decodedPerson)
    }
}
