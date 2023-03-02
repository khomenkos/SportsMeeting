//
//  String+Extensions.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 01.03.2023.
//

import Foundation

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
