//
//  Settings.swift
//  HA8.12
//
//  Created by Maksat Edil on 10/12/23.
//

import Foundation

enum SettingType {
    case none
    case configure
}

struct Setting {
    var title: String
    var type: SettingType
}
