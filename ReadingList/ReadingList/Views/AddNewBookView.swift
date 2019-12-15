//
//  AddNewBookView.swift
//  ReadingList
//
//  Created by Nelson Gonzalez on 12/3/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct AddNewBookView: View {
    @State private var bookTitle = ""
    @State private var reasonToRead = ""
    @ObservedObject var bookController: BookController
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Book title...", text: $bookTitle).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
                TextField("Reason to read...", text: $reasonToRead).padding().background(Color(red: 239/255, green: 243/255, blue: 244/255))
                
                Button("Submit") {
                    if !self.bookTitle.isEmpty && !self.reasonToRead.isEmpty {
                        self.bookController.addBook(title: self.bookTitle, description: self.reasonToRead)
                        self.presentationMode.wrappedValue.dismiss()
                        self.bookTitle = ""
                        self.reasonToRead = ""
                    } else {
                        self.showingAlert = true
                    }
                }.font(.subheadline)
                Spacer()
            }.padding().navigationBarTitle("Add a New Book", displayMode: .inline).alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Title and Description can't be empty. Please fill them in an try again."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddNewBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewBookView(bookController: BookController())
    }
}
