//
//  ListView.swift
//  FoodApi_doz_14
//
//  Created by Alexander Hoch on 10.09.21.
//  Copyright © 2021 zancor. All rights reserved.
//

import SwiftUI
import UIKit

struct ListView: View {
    @Binding var aRecords:[Recording]
    // @EnvironmentObject var vm: SoundViewModel
    //struct vars
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List{
                        ForEach(aRecords, id: \.id) { (rec) in
                            //    ForEach($vm.recordingsList, id: \.id) { (rec) in
                            NavigationLink(destination:
                                            
                                            ListPlayer(currentRecordingAudio: rec.fileURL)
                            
                            ) {
                                HStack{
                                    
                                    
                                    Text("\(rec.name)")
                                }.onAppear{
                                    print("IN LIST VIEW")
                                    
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
}
