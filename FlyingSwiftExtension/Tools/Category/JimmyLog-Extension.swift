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

