//
//  Extensions.swift
//  NetflixClone
//
//  Created by Lucas Arthur on 31/01/24.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
