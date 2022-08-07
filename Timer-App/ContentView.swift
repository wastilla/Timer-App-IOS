//
//  ContentView.swift
//  Timer-App
//
//  Created by will astilla on 7/13/22.
//

import SwiftUI


struct ContentView: View {
    @State  private var hourText = ""
    @State  private var minuteText = ""
    @State  private var secondText = ""
    
    @State private var totalSecondsInTimer = 0
    
    @State private var hasSelectedTime: Bool = false
    
    private func cancelAction(){
        hasSelectedTime = false
    }
    
    private func startAction(){
        hasSelectedTime = true
    }
   
    private var selectTime: some View {
        HStack {
            TextField( "h", text: $hourText)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text(":")
            
            TextField("m", text: $minuteText)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text(":")
            
            TextField("s", text: $secondText)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
    
    private var topbar: some View {
        HStack {
            Text("Timer")
                .bold()
        }
    }
    
    var body: some View {
        
        VStack {
            topbar
            Group{
                if(hasSelectedTime){
                    Text("Select a Time")
                    
                        
                } else {
                    
                    selectTime
                }
            }
            .frame(height: 300)
            
            HStack{
                Button(action: {
                    cancelAction()
                }){
                   Text("Cancel")
                        .foregroundColor(.white)
                        .padding()
                }
                .padding()
                .background(.secondary)
                .clipShape(Circle())
                .padding(5)
                .overlay(
                    Circle()
                        .stroke(Color.secondary, lineWidth: 2)
                )
                
                Spacer()
                
                Button(action: {
                    startAction()
                }){
                   Text("Start")
                        .foregroundColor(.white)
                        .padding()
                }
                .padding()
                .background(.green)
                .clipShape(Circle())
                .padding(5)
                .overlay(
                    Circle()
                        .stroke(Color.green, lineWidth: 2)
                )
            }
            
            
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
