//
//  ContentView.swift
//  djiRouteLoader
//
//  Created by Mikolaj Ostrowski on 5/3/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack{
                Text("Home")
                Button("connect"){connectToDatabase()}
            }.padding()
                    
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddNewView()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
}

struct AddNewView: View {
    var body: some View{
        Text("Add new")
    }
}

#Preview {
    MainView()
}
