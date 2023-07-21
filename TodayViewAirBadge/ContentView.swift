//
//  ContentView.swift
//  TodayViewAirBadge
//
//  Created by Ahmed Mgua on 21/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Text(Date(),formatter: DateFormatter.dayMonth)
                            .textCase(.uppercase)
                            .foregroundStyle(.gray)
                            .font(.caption.bold())
                        
                        Spacer()
                    }
                    .padding(.horizontal)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            HStack(spacing: 16) {
                                CurrentTimeView()

                                HoursTodayView(hoursCompleted: 3)
                            }

                            Text("No marks today")
                                .fontWeight(.bold).accessibilityIdentifier("markslabel")

                        }
                        .padding()
                    }
                    .refreshable {

                    }


                    Button {

                    } label: {

                        Circle()
                            .foregroundStyle(.blue)
                            .frame(width: 140)
                            .overlay{
                                Text("Badge in")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }

                    }
                    .accessibilityIdentifier("badgeinout")

                }
            }

                .navigationTitle("Today")


        }
    }
}

#Preview {
    ContentView()
}
