//
//  ListView.swift
//  VoSounds
//
//  Created by devtolife on 21.09.21.
//

import SwiftUI
import UIKit

struct ListView: View {
    @EnvironmentObject var vm: SoundViewModel
   
    var body: some View {
        ZStack{
            VStack{
                List{
                    ForEach(vm.studentRecordingList, id: \.id) { (rec) in
                        NavigationLink(destination: Text("löl")) {
                            HStack{
                                                              
                            Text("\(rec.name)")
                                Text("(\(Date(stringOfMilliseconds: rec.created).getDateAsString)")
                            }.onAppear{
                                print("IN LIST VIEW")
                                
                            }
                        }
                    }
                }.navigationBarItems(leading: EditButton(),
                                     trailing: Button("Add") {
                    
                })
            }
        }
    }
}
