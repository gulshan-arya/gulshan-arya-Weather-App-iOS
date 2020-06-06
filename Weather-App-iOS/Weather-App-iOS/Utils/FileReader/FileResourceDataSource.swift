//
//  FileResourceDataSource.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation


struct FileReadDataSource {
    let filePath: ResourcePath
    let fileType: FileExtension
    let bundle: Bundle
}

enum FileExtension: String {
    case csv = "csv"
}

enum ResourcePath: String {
    case indianCities = "indian-cities"
}
