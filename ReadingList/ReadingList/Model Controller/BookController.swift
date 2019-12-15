//
//  BookController.swift
//  ReadingList
//
//  Created by Nelson Gonzalez on 12/3/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//https://github.com/ryanashcraft/SwiftUI-TodoMVC

import Foundation
import SwiftUI
import Combine

class BookController: ObservableObject {
    
    @Published private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter{ $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        return books.filter{ $0.hasBeenRead == false }
    }
    
    init() {
        loadFromPersistantStore()
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return docDir.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            guard let fileURL = readingListURL else { return }
            try booksData.write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistantStore() {
        let fileManager = FileManager.default
        guard let fileURL = readingListURL,
            fileManager.fileExists(atPath: fileURL.path) else { return }
        do {
            let booksData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: booksData)
        } catch  {
            print(error)
        }
    }
    
    
    func addBook(title: String, description: String) {
        let newBook = Book(name: title, reasonToRead: description)
        books.append(newBook)
        saveToPersistentStore()
    }

    
    func setIsCompleted(bookId: UUID, isCompleted: Bool) {
        
      //  print("IsCompleted: \(isCompleted)")
        books = books.map {
            if $0.id == bookId {
               // return TodoItem(id: $0.id, isCompleted: isCompleted, title: $0.title)
                return Book(name: $0.name, reasonToRead: $0.reasonToRead, hasBeenRead: isCompleted)
            }
           
            return $0
        }
        saveToPersistentStore()
    }
//    
//    func updateBook(for book: Book, newTitle: String, newDescription: String) {
//        guard let index = books.firstIndex(of: book) else { return }
//        books[index].name = newTitle
//        books[index].reasonToRead = newDescription
//    }

    
    func deleteItem(at offset: IndexSet) {
           
           guard let index = Array(offset).first else { return }
           books.remove(at: index)
           
           saveToPersistentStore()
       }
    
}
