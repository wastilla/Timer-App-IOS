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
    @State private var elapsedTime = 0
    
    @State private var hasSelectedTime: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private func cancelAction(){
        hasSelectedTime = false
        self.elapsedTime = 0
        self.totalSecondsInTimer = 0
        self.hourText = ""
        self.minuteText = ""
        self.secondText = ""
    }
    
    func handleTimerEvent(){
        if hasSelectedTime == true && totalSecondsInTimer > elapsedTime{
            elapsedTime += 1
        }
        if elapsedTime == totalSecondsInTimer{
            self.hasSelectedTime = false
            self.elapsedTime = 0
            self.totalSecondsInTimer = 0
            self.hourText = ""
            self.minuteText = ""
            self.secondText = ""
        }
    }
    
    private var timeRemaining: String {
        let remainingSeconds = totalSecondsInTimer - elapsedTime

        let hours = remainingSeconds / (60 * 60)
        let minutes = (remainingSeconds % (60 * 60)) / 60
        let seconds = remainingSeconds % 60

        let hoursString = String(format: "%02d", hours)
        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)

        return "\(hoursString):\(minutesString):\(secondsString)"
    }
    
    private func startAction(){
        let hoursAsInt = Int(hourText) ?? 0
        let minutesAsInt = Int(minuteText) ?? 0
        let secondsAsInt = Int(secondText) ?? 0
        
        var hoursToSecs: Int{
            return hoursAsInt*3600
        }
        
        var minutesToSecs: Int{
            return minutesAsInt*60
        }
        
        var totalSecs: Int{
            return hoursToSecs + minutesToSecs + secondsAsInt
        }
        
        self.totalSecondsInTimer = totalSecs
        //self.timeStarted = true
        self.hasSelectedTime = true
    }
    
    private var timerView: some View{
        ZStack{
            CirclesView(elapsedTime: elapsedTime, totalTime: totalSecondsInTimer)
            Text(timeRemaining)
            
        }
    }
   
    private var selectTime: some View {
        HStack {
            TextField( "h", text: $hourText)
                //.textFieldStyle(.roundedBorder)
                //.padding()
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                
                .font(.title)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 3)
                )
                .padding()
            
            Text(":")
            
            TextField("m", text: $minuteText)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .font(.title)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 3)
                )
                .padding()
            
            Text(":")
            
            TextField("s", text: $secondText)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .font(.title)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 3)
                )
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
                    timerView
                    

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
        .onReceive(timer) { _ in
                        handleTimerEvent()
                       
                    }
    }
        
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
