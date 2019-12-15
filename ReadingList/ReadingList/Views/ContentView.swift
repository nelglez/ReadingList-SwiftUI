//
//  ContentView.swift
//  ReadingList
//
//  Created by Nelson Gonzalez on 12/3/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var bookController = BookController()
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                if bookController.books.count == 0 {
                    Text("No books added yet")
                } else {
                    if bookController.readBooks.count == 0 {
                        //No Section
                    } else {
                        Section(header: Text("Read Books")) {
                            
                            
                            
                            ForEach(bookController.readBooks) { readBook in
                                
                                RowView(book: readBook, bookController: self.bookController)
                                
                                
                            }.onDelete { (indexSet) in
                                self.bookController.deleteItem(at: indexSet)
                            }
                            
                            
                        }
                    }//
                    if bookController.unreadBooks.count == 0 {
                        //No Section
                    } else {
                        Section(header: Text("Unread Books")) {
                            ForEach(bookController.unreadBooks) { unreadBook in
                                
                                RowView(book: unreadBook, bookController: self.bookController)
                                
                            }.onDelete { (indexSet) in
                                self.bookController.deleteItem(at: indexSet)
                            }
                        }
                    }//
                }//
                
            }.listStyle(GroupedListStyle()).navigationBarTitle("Books").navigationBarItems(trailing: Button(action: {
                self.showModal = true
            }){
                Image(systemName: "plus.circle").resizable().frame(width: 40, height: 40).foregroundColor(.orange)
            }.sheet(isPresented: $showModal, content: {
                AddNewBookView(bookController: self.bookController)
            }))
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
