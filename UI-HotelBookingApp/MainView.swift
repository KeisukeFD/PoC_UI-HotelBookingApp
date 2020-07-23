//
//  MainView.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-21.
//
import SwiftUI

struct MainView: View {
    @EnvironmentObject var fullScreen: FullScreenController
    @State var query: String = ""
    
    @ObservedObject var data: Data
    
    static let selectionDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                SearchFieldView(query: $query)
 
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Choose date")
                            .foregroundColor(.gray)
                            .bold()
                            .font(.caption)
                            .padding(.bottom, 10)

                        Text("\(data.startDate, formatter: MainView.selectionDateFormatter) - \(data.endDate, formatter: MainView.selectionDateFormatter)")
                            .foregroundColor(Color("defaultColor"))
                            .font(.callout)
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.6)) {
                                    self.fullScreen.show(content: {
                                        AnyView(CalendarView(startDate: $data.startDate, endDate: $data.endDate, isShowing: $fullScreen.isIt))
                                    })
                                }
                            }
                    }
 
                    VStack(alignment: .leading) {
                        Text("Number of Rooms")
                            .foregroundColor(.gray)
                            .bold()
                            .font(.caption)
                            .padding(.bottom, 10)

                        Text("1 Room - 2 Adults")
                            .foregroundColor(Color("defaultColor"))
                            .font(.callout)
                        
                    }.overlay(Rectangle().frame(width: 1).offset(x: -15).opacity(0.2), alignment: .topLeading)
                }.padding(.leading)
                .padding(.bottom)

            }.background(Color("veryLightGray"))
            
            HStack {
                Text("530 hotels found")
                    .font(.caption)
                    .foregroundColor(Color("defaultColor"))
                    .bold()
                
                Spacer()
                
                HStack(spacing: 15) {
                    Text("Filters")
                        .font(.callout)
                        .foregroundColor(Color("defaultColor"))

                    Button(action: {}) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(Color("defaultColor"))
                    }
                }
            }.padding(.leading)
            .padding(.trailing)
            .padding(.top)
            
            ScrollView {
                ForEach(hotels, id: \.self.name) { hotel in
                    HotelCard(hotel: hotel)
                        .padding()
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text("Explore"), displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(Color("defaultColor"))
        },
        trailing: HStack {
            Button(action: {}) {
                Image(systemName: "heart")
                    .foregroundColor(Color("defaultColor"))
            }
            Spacer().frame(width: 20)
            Button(action: {}) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(Color("defaultColor"))
            }
        })
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
