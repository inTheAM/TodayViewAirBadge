//
//  CurrentTimeView.swift
//  TodayViewAirBadge
//
//  Created by Ahmed Mgua on 21/07/23.
//

import SwiftUI

struct CurrentTimeView: View {
    @State private var time = Date()
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Current Time")
                    .foregroundStyle(.gray)
                AnalogClock()
                    .frame(width: 33, height: 33)
                Text(time, formatter: DateFormatter.timeLong)
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 8)
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.white)
        }
        .onReceive(timer, perform: { _ in
            time = Date()
        })
    }
}

extension Text {
    init(_date: Date, formatter: DateFormatter) {
        self.init(formatter.string(from: _date))
    }
}

extension DateFormatter {
    static let dayMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd LLLL"
        return formatter
    }()

    static let timeLong : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
}

#Preview {
    CurrentTimeView()
}
