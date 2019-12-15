//
//  RowView.swift
//  ReadingList
//
//  Created by Nelson Gonzalez on 12/3/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import SwiftUI


struct RowView: View {
    var book: Book
    @ObservedObject var bookController = BookController()
    
    
    var body: some View {
        
        HStack {
            Text(book.name)
            
            Spacer()
            Image(systemName: book.hasBeenRead ? "checkmark": "square").font(.largeTitle).onTapGesture {
                
                let bookHasbeenReadStatus = !self.book.hasBeenRead
                
                print(bookHasbeenReadStatus, "Status")
                self.bookController.setIsCompleted(bookId: self.book.id, isCompleted: bookHasbeenReadStatus)
            }
        }
        
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(book: Book(name: "Test", reasonToRead: "Just a test"), bookController: BookController())
    }
}
