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
            }.padding()
                    
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        //ContentView2()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
}

#Preview {
    MainView()
}
