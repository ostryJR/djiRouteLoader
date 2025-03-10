//
//  ContentView.swift
//  djiRouteLoader
//
//  Created by Mikolaj Ostrowski on 5/3/25.
//

import SwiftUI

struct MainView: View {
    @State public var dbData:[Map] = []
    var body: some View {
        NavigationStack {
            VStack{
                if(dbData.isEmpty){
                    Text("Click the Connect (\(Image(systemName: "app.connected.to.app.below.fill")))")
                    Text("button to load data from database")
                    .background(Image(systemName: "arrow.up.backward.square").font(.system(size: 250)).opacity(0.05))
                }else{
                    List{
                        ForEach(dbData, id: \.missionId){ map in
                            NavigationLink(destination: {
                                //Info of specific map
                                
                                List{
                                    Image(systemName: "photo.on.rectangle.fill")
                                        .padding(10)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        //.frame(width: 30, height: 30)
                                    HStack{
                                        Text("Mission Id:").padding(10);Spacer();
                                        Text("\(map.missionId)").padding(10)}
                                    HStack{
                                        Text("Mission Name:").padding(10);Spacer();
                                        Text("\(map.name)").padding(10)}
                                    HStack{
                                        Text("Author:").padding(10);Spacer();
                                        Text("\(map.author)").padding(10)}
                                    HStack{
                                        Text("Created @:").padding(10);Spacer();
                                        Text("\(NSDate(timeIntervalSince1970:map.createdTime))").padding(10)}
                                    HStack{
                                        Text("Modified @:").padding(10);Spacer();
                                        Text("\(NSDate(timeIntervalSince1970:map.modifiedTime))").padding(10)}
                                    HStack{
                                        Text("Waypoint #:").padding(10);Spacer();
                                        Text("\(map.waypointCount)").padding(10)}
                                    HStack{
                                        Text("Mileage:").padding(10);Spacer();
                                        Text("\(Int(map.mileage)) m").padding(10)}
                                    HStack{
                                        Text("Wayline Latitude:").padding(10);Spacer();
                                        Text("\(map.waylineLatitude)").padding(10)}
                                    HStack{
                                        Text("Wayline Longitude:").padding(10);Spacer();
                                        Text("\(map.waylineLongitude)").padding(10)}
                                    HStack{
                                        Text("Location Desc:").padding(10);Spacer();
                                        Text("\(map.locationDes)").padding(10)}
                                
                            }.navigationTitle("Info")
                            .navigationBarTitleDisplayMode(.inline)
                            }){
                                HStack{
//                                    if(map.coverImagePath == ""){
                                        Image(systemName: "map")
                                            .resizable()
                                            .frame(width: 30, height: 30)
//                                    }else{
//                                        var path = map.missionId+"/mission_cover/"+map.coverImagePath
//                                        Image(uiImage: UIImage(path: path))
//                                            .resizable()
//                                            .frame(width: 30, height: 30)
//                                    }
                                    VStack{
                                        Text("\(map.name)").lineLimit(1).frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(map.author)")/*.monospaced()*/.frame(maxWidth: .infinity, alignment: .leading).foregroundStyle(.secondary)
                                    }
                                }
                                
                            }.navigationTitle("Main")
                            .navigationBarTitleDisplayMode(.inline)
                        }
                    }.cornerRadius(20)
                }
            }.padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dbData = connectToDatabase()
                    } label: {
                        Image(systemName: "app.connected.to.app.below.fill")
                    }
                    //Image(systemName: "app.connected.to.app.below.fill")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddNewView()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background {
//                Color.gray.opacity(0.1)
//                    .ignoresSafeArea()
//            }
        }.task{
            do{
                dbData = await connectToDatabase()
                print(dbData[0].filePaths)
            }}
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
