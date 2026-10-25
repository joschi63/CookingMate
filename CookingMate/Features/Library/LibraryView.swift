//
//  LibraryView.swift
//  CookingMate
//
//  Created by Johann Schneider on 04.09.26.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        VStack {
           
            NavigationLink {
                Text("Hi")
            } label: {
                Rectangle()
                    .frame(width: 150, height: 150)
            }
        }
        .navigationTitle("Library")
        
    }
}

#Preview {
    LibraryView()
}
