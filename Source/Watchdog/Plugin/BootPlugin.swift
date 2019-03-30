//
//  BootPlugin.swift
//  Watchdog
//
//  Created by enum on 2019/3/25.
//

import Foundation
import Pjango

class BootPlugin: PCPlugin {
    
    override var task: PCTask? {
        return {
            loadHostsConfig()
        }
    }
}
