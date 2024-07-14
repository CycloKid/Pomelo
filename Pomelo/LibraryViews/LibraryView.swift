//
//  LibraryView.swift
//  Pomelo
//
//  Created by Stossy11 on 13/7/2024.
//

import SwiftUI

struct LibraryView: View {
    @Binding var core: Core
    @State var doesitexist = (false, false)
    var body: some View {
        NavigationStack {
            VStack {
                if doesitexist.0 && doesitexist.1 {
                    GameListView(core: core)
                } else {
                    let (doesKeyExist, doesProdExist) = doeskeysexist()
                    ScrollView {
                        Text("You Are Missing These Files:")
                            .font(.headline)
                            .foregroundColor(.red)
                        HStack {
                            if !doesProdExist {
                                Text("Prod.keys")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                            }
                            if !doesKeyExist {
                                Text("Title.keys")
                                    .font(.subheadline)
                                    .foregroundColor(.red)
                            }
                        }
                        Text("These goes into the Keys folder")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    .refreshable {
                        doesitexist = doeskeysexist()
                    }
                }
                
            }
            .onAppear() {
                doesitexist = doeskeysexist()
            }
            .navigationBarTitle("Library", displayMode: .inline)
        }
    }
    
    
    func doeskeysexist() -> (Bool, Bool) {
        var doesprodexist = false
        var doestitleexist = false
        
        
        let title = core.root.appendingPathComponent("keys").appendingPathComponent("title.keys")
        let prod = core.root.appendingPathComponent("keys").appendingPathComponent("prod.keys")
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        if fileManager.fileExists(atPath: prod.path) {
            doesprodexist = true
        } else {
            print("File does not exist")
        }
        
        if fileManager.fileExists(atPath: title.path) {
            doestitleexist = true
        } else {
            print("File does not exist")
        }
        
        return (doestitleexist, doesprodexist)
    }
}

