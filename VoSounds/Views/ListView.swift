//
//  ListView.swift
//  FoodApi_doz_14
//
//  Created by Alexander Hoch on 10.09.21.
//

import SwiftUI
import UIKit

struct ListView: View {
    @Binding var aRecords:[Recording]
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List{
                        ForEach(aRecords, id: \.id) { (rec) in
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
