//
//  JimmyLog-Extension.swift
//  FlyingSwiftExtension
//
//  Created by jun on 2019/6/29.
//  Copyright © 2019 OCX.ai. All rights reserved.
//

import UIKit

// MARK: - 全局log函数

/// 全局log函数
///
/// - Parameters:
///   - message: log信息
///   - file: 所在源代码
///   - funcName: 函数名
///   - lineNum: 行
func JimmyLog<T>(message: T , file : String = #file, funcName : String = #function , lineNum: Int = #line){
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("【Log】\(fileName):(\(lineNum))-\(message)")
    #endif
}

/// 字典 -> 模型
///
/// - Parameters:
///   - type: 类型
///   - data: 字典数据
/// - Returns: 模型结果
/// - Throws: 错误处理
func JSONModel<T>(_ type: T.Type, withKeyValues data:[String:Any]) throws -> T where T: Decodable {
    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
    let model = try JSONDecoder().decode(type, from: jsonData)
    return model
}
