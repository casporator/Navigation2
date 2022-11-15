//
//  Errors.swift
//  Navigation
//
//  Created by Oleg Popov on 12.11.2022.
//

import Foundation
import UIKit

enum LoginError: Error {
    case incorrect
    case loginEmpty
    case passwordEmpty
    case empty
}

enum StatusError: Error {
    case emptyStatus
    case longStatus
}
