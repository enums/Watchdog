//
//  AppDelegate.swift
//  Calatrava
//
//  Created by 郑宇琦 on 2017/6/24.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import Pjango
import Dispatch

DispatchQueue.init(label: "server").async {
    PjangoRuntime.run(delegate: AppDelegate.init())
}


print("> Command line listenning...")
while let line = readLine() {
    guard line.count > 0 else {
        continue
    }
    print("> \(line)")
    
    switch line {
    case "reload":
        loadHostsConfig()
        printHostsConfig()
        print("> reload done!")
    default:
        break
    }
}
