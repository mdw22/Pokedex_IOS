//
//  ContentView.swift
//  Pokedex
//
//  Created by Michael White on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var legendaryBool: Bool = false
    @State private var typeText: String = ""
    @State private var outputText: String = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Pokedex App")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            NavigationStack {
                TextField(
                    "Enter name of Pokemon here \(searchText)",
                    text: $searchText
                )
                Toggle(isOn: $legendaryBool, label: {
                    Text("Legendary?")
                })
                TextField(
                    "Enter type of Pokemon here \(typeText)",
                    text: $typeText
                )
                Button(action: {
                    let hook = DBHook()
                    //let result = hook.queryPokeDB(search: searchText, type: typeText, legendary: legendaryBool)
                    //outputText = result
                }, label: { Text("SEARCH")
                })
                .scenePadding()
                .background(Color .gray)
                .foregroundColor(Color .white)
                Text("OUTPUT\(outputText)")
                    .scenePadding()
                Spacer()
                Button(action: {
                    searchText = ""
                    typeText = ""
                    outputText = ""
                    legendaryBool = false
                }, label: {
                    Text("CLEAR")
                })
                .scenePadding()
                .background(Color .gray)
                .foregroundColor(Color .white)
            }
            .font(.body)
            .padding()
            .lineSpacing(20)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
