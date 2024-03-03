//
//  ContentView.swift
//  iosSandboxTester
//
//  Created by t2o0n321 on 2024/3/3.
//

import SwiftUI

struct buttonPressEffect: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

func getDocumentDirectoryPath() -> URL {
    let documentFolderPath = FileManager.SearchPathDirectory.documentDirectory
    let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    let documentPath = NSSearchPathForDirectoriesInDomains(documentFolderPath, userDomainMask, true)
    return URL(fileURLWithPath: documentPath[0])
}

struct ContentView: View {
    @State private var isPressed: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        VStack {
            Button(action: {
                let docDirPath = getDocumentDirectoryPath()
                print(docDirPath)
                
            }, label: {
                Text("選擇新照片")
            }).buttonStyle(buttonPressEffect())
        }
        .fontWeight(.bold)
        .font(.system(.title2, design: .rounded))
    }
}

#Preview {
    ContentView()
}
