//
//  Global.swift
//  Calatrava
//
//  Created by 郑宇琦 on 2017/6/24.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import SwiftyJSON
import PerfectLib

#if os(macOS)
let WEBSITE_HOST = "watchdog.enumsblogtest.com"
#else
let WEBSITE_HOST = "watchdog.enumsblog.com"
#endif

var REDIRECTION_HOSTS = Dictionary<String, Int>()

func loadHostsConfig() {
#if os(macOS)
    let configPath = "/Users/enum/Developer/Watchdog/Workspace/runtime/hosts_config.json"
#else
    let currentPath = FileManager.default.currentDirectoryPath
    let configPath = "\(currentPath)/Workspace/runtime/hosts_config.json"
#endif
    let configFile = File.init(configPath)
    let content = (try? configFile.readString()) ?? ""
    REDIRECTION_HOSTS = JSON.init(parseJSON: content).dictionaryObject as? [String: Int] ?? [:]
}
