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

class xFileManager {
    /*
        Private Variables
     */
    private var sdbxDocPath: String = ""
    /*
        Initialize
     */
    init(){
        let documentFolderPath = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let documentPath = NSSearchPathForDirectoriesInDomains(documentFolderPath, userDomainMask, true)
        self.sdbxDocPath = documentPath[0]
    }
    /*
        Generate File Path by time
        - Return URL
     */
    public func genFileUrl() -> URL{
        var fileName: String = ""
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        fileName = dateFormatter.string(from: now).components(separatedBy: "(")[0]
        return URL(fileURLWithPath: "\(self.sdbxDocPath)/\(fileName).txt")
    }
    /*
         Generate File Path randomly
         - Return URL
     */
    public func genFileUrl(fileNameLength: Int) -> URL{
        var fileName: String = ""
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        fileName = String((0..<fileNameLength).map{ _ in letters.randomElement()! })
        return URL(fileURLWithPath: "\(self.sdbxDocPath)/\(fileName).txt")
    }
    /*
        Write file to destination
        - Return true if success
        - Return false if fail
     */
    public func writeToDest(fileDest: URL, txtContents: String) -> Bool{
        do {
            try txtContents.write(to: fileDest, atomically: true, encoding: String.Encoding.utf8)
            return true
        }catch{
            print("Fail to write file ... ")
            return false
        }
    }
}

struct ContentView: View {
    @State private var isPressed: Bool = false
    @State private var txtContent: String = ""
    
    var body: some View {
        VStack {
            VStack{
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello")
                }
                VStack {
                    TextField("輸入文字", text: $txtContent)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.default)
                        .padding()
                    
                    Button(action: {
                        /*
                            Init text field
                         */
                        let cpTxtContent = txtContent
                        txtContent = ""
                        /*
                            Get Document directory and write txt file
                         */
                        let xFile = xFileManager()
                        let filePath = xFile.genFileUrl()
                        let isSuccess = xFile.writeToDest(fileDest: filePath, txtContents: cpTxtContent)
                    }, label: {
                        Text("確定")
                    }).buttonStyle(buttonPressEffect())
                    
                }
                .fontWeight(.bold)
                .font(.system(.title2, design: .rounded))
            }
            
        }
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

