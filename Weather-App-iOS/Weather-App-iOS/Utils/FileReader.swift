//
//  FileReader.swift
//  Weather-App-iOS
//
//  Created by Gulshan on 06/06/20.
//  Copyright © 2020 Gulshan. All rights reserved.
//

import Foundation

class FileReader {
    
    static let shared = FileReader()
        
    private init() { }
    
    func read(at dataSource: FileReadDataSource) -> String? {
        
        guard let filepath = dataSource.bundle.path(
            forResource: dataSource.filePath.rawValue,
            ofType: dataSource.fileType.rawValue)
            else {
            debugPrint("Not able to read file \(dataSource.filePath.rawValue)")
            return nil
        }
        
        do {
            let contents = try String(contentsOfFile: filepath)
            return contents
        } catch let error {
            debugPrint("Not able to read file at Url: \(filepath) due to error: \(error.localizedDescription)")
            return nil
        }
    }
}
