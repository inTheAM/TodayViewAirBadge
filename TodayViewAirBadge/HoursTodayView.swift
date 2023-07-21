//
//  HoursTodayView.swift
//  TodayViewAirBadge
//
//  Created by Ahmed Mgua on 21/07/23.
//

import SwiftUI

struct HoursTodayView: View {
    let hoursCompleted: Int
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Hours Today: ")
                    .foregroundStyle(.gray)
                
                LazyVGrid(columns: [GridItem].init(repeating: .init(.fixed(11)), count: 2), spacing: 2.5) {
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.gray)
                            .frame(width: 16, height: 16)
                            .accessibilityIdentifier("hoursindicator")
                            .overlay {
                                if hoursCompleted > index {
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 16, height: 16)
                                        .foregroundStyle(.blue)
                                        .accessibilityIdentifier("hoursindicator")
                                }
                            }
                    }
                }
                Text("\(hoursCompleted)")
                    .fontWeight(.semibold)
            }
            .padding(.vertical, 8)
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    HoursTodayView(hoursCompleted: 2)
}
