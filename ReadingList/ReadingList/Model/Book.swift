//
//  Book.swift
//  ReadingList
//
//  Created by Nelson Gonzalez on 12/3/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Book: Codable ,Identifiable, Equatable {
    let id = UUID()
    var name: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
    var sectionTitle: String {
        hasBeenRead ? "Read Books": "Unread Books"
    }
}
