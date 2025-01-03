//
//  TimerBoardView.swift
//  StickyNotes
//
//  Created by FayTek on 12/31/24.
//

import SwiftUI

struct TimerBoardView: View {
    @ObservedObject var viewModel: TimerBoardViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.timers) { timer in
                    HStack {
                        Text(timer.timerTitle)
                        Spacer()
                        Text("\(Int(timer.duration))s")
                        Button(action: {
                            withAnimation(.easeInOut(duration: Constants.noteAnimationDuration)) {
                                viewModel.deleteTimer(timer: timer)
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Timers")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation(.easeInOut(duration: Constants.noteAnimationDuration)) {
                            viewModel.addTimer()
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .background(Color("customLightGray"))
            .animation(.easeInOut(duration: Constants.noteAnimationDuration), value: viewModel.timers)
        }
    }
}

#Preview {
    TimerBoardView(viewModel: TimerBoardViewModel())
}
