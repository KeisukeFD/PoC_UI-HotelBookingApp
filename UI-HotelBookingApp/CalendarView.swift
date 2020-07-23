//
//  CalendarView.swift
//  UI-HotelBookingApp
//
//  Created by Valentin Malissen on 2020-07-21.
//
import SwiftUI


struct CalendarView: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var isShowing: Bool

    @State var initialDate: Date = Date.init()
    @State private var editing: Bool = false
    
    fileprivate static let monthDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()

    fileprivate static let monthYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    fileprivate static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd MMM"
        return formatter
    }()
    
    var body: some View {
        VStack {
            CalendarHeader(start: self.startDate, end: self.endDate, editing: self.editing)
            HStack {
                CircleImageButton(action: {
                    self.changeMonth(step: -1)
                }, systemName: "chevron.left")

                Spacer()
                
                if(initialDate.year() == Date().year()) {
                    Text("\(initialDate, formatter: CalendarView.monthDateFormatter)")
                        .font(.title2)
                } else {
                    Text("\(initialDate, formatter: CalendarView.monthYearDateFormatter)")
                        .font(.title2)
                }

                Spacer()
                CircleImageButton(action: {
                    self.changeMonth(step: 1)
                }, systemName: "chevron.right")
            }.padding()
            .padding(.top, -10)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                Text("Sun")
                Text("Mon")
                Text("Tue")
                Text("Wed")
                Text("Thu")
                Text("Fri")
                Text("Sat")
                
                ForEach(self.getCalendarMonthDays(from: initialDate), id:\.self.id) { d in
                        if(d.date.equals(to: self.startDate)) {
                            NumberCellStart(day: d, editing: self.editing)
                                .onTapGesture {
                                    self.selectDates(for: d.date)
                                }
                        } else if(d.date.equals(to: self.endDate)) {
                            NumberCellEnd(day: d, editing: self.editing)
                                .onTapGesture {
                                    self.selectDates(for: d.date)
                                }
                        } else if(d.date.greaterThan(to: self.startDate) && d.date.lessThan(to: self.endDate)) {
                            NumberCellMiddle(day: d, editing: self.editing)
                                .onTapGesture {
                                    self.selectDates(for: d.date)
                                }
                        } else {
                            NumberCell(day: d, editing: self.editing)
                                .onTapGesture {
                                    self.selectDates(for: d.date)
                                }

                        }
                }
            }.padding(.bottom, 20)
            .gesture(DragGesture()
                .onEnded { value in
                    // Swipe To Left
                    if value.translation.width < -100 {
                        self.changeMonth(step: 1)
                    } else if value.translation.width > 100 {
                        self.changeMonth(step: -1)
                    }
                }
            )
            if self.getCalendarMonthDays(from: initialDate).count == (5*7) {
                Spacer().frame(height: 60)
            }

            RoundedButton(value: "Apply") {
                self.isShowing = false
            }.padding(.bottom, 10)
            
        }.background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    private func changeMonth(step: Int) {
        self.initialDate = self.initialDate.addMonth(step)
    }

    private func selectDates(for newDate: Date) {
        if(!self.editing) {
            self.startDate = newDate
            self.editing = true
        } else if (self.editing) {
            if(newDate.greaterThan(to: self.startDate)) {
                self.endDate = newDate
                self.editing = false
            }
        }
    }

    private func getCalendarMonthDays(from currentDate: Date) -> [Days] {
        let lastMonth = currentDate.addMonth(-1)
        let lastMonthDays = (1...lastMonth.getNumberOfDaysInMonth()).map({ $0 })

        let interval = Calendar.current.dateInterval(of: .month, for: currentDate)
        let firstDayOfCurrentMonth = interval?.start
        
        let numberOfLastMonthDays = currentDate.getFirstWeekDay()-1

        let nextMonth = currentDate.addMonth(1)
        let nextMonthDays = (1...nextMonth.getNumberOfDaysInMonth()).map({ $0 })
        
        
        var days: [Days] = [Days]()
        for (i, e) in lastMonthDays.suffix(numberOfLastMonthDays).enumerated() {
            days.append(Days(number: "\(e)", date: firstDayOfCurrentMonth!.addDay(-(numberOfLastMonthDays-i)), currentMonth: false))
        }
        for i in 1...currentDate.getNumberOfDaysInMonth() {
            days.append(Days(number: "\(i)", date: firstDayOfCurrentMonth!.addDay(i-1), currentMonth: true))
        }

        var trailingPaddingCount: Int = 0
        if(days.count > (5*7)) {
            trailingPaddingCount = (6*7)-days.count
        } else if (days.count == (5*7)) {
            trailingPaddingCount = 0
        } else {
            trailingPaddingCount = (5*7)-days.count
        }
        for (i, e) in nextMonthDays.prefix(trailingPaddingCount).enumerated() {
            days.append(Days(number: "\(e)", date: firstDayOfCurrentMonth!.addDay(currentDate.getNumberOfDaysInMonth() + i), currentMonth: false))
        }
        return days
    }

}

fileprivate struct CalendarHeader: View {
    var start: Date
    var end: Date
    var editing: Bool
    
    var body: some View {
        HStack {
            VStack {
                Text("Depart")
                Text("\(self.start, formatter: CalendarView.displayDateFormatter)")
                    .bold()
                    .font(.title2)
            }.padding()
            
            Spacer()
            
            VStack {
                Text("Return")
                if(self.editing) {
                    Text("           ?          ")
                        .bold()
                        .font(.title2)
                } else {
                    Text("\(self.end, formatter: CalendarView.displayDateFormatter)")
                        .bold()
                        .font(.title2)

                }
            }.padding()
        }.padding()
        .overlay(Rectangle().frame(width: 1).background(Color.gray).opacity(0.2))
        .overlay(Rectangle().frame(height: 1).background(Color.gray).opacity(0.2), alignment: .bottomLeading)
    }
}

fileprivate struct NumberCellStart: View {
    var day: Days
    var editing: Bool
    
    var body: some View {
        ZStack {
            if(editing) {
                Rectangle()
                    .fill(Color.white)
                    .padding(.top, 12)
                    .padding(.bottom, 12)
            } else {
                Rectangle()
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    .background(Color.accentColor)
                    .offset(x: 25)
            }
            Circle()
                .fill(Color.accentColor)
                .overlay(Circle().stroke(lineWidth: 3).fill(Color.white))
                .shadow(color: Color("shadowGray"), radius: 12, x: -8)
            
            
            Text("\(day.number)")
                .background(Color.accentColor)
                .foregroundColor(.white)
                .opacity(day.currentMonth ? 1.0 : 0.2)
        }.frame(height: 35)
    }
}


fileprivate struct NumberCellMiddle: View {
    var day: Days
    var editing: Bool
    
    var body: some View {
        ZStack {
            if(editing) {
                Rectangle()
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    .background(Color.clear)

                Text("\(day.number)")
                    .opacity(day.currentMonth ? 1.0 : 0.2)
            } else {
                Rectangle()
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    .background(Color.accentColor)

                Text("\(day.number)")
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .opacity(day.currentMonth ? 1.0 : 0.2)
            }
        }.frame(height: 35)
    }
}

fileprivate struct NumberCellEnd: View {
    var day: Days
    var editing: Bool
    
    var body: some View {
        ZStack {
            if(!self.editing) {
                Color.accentColor
                    .offset(x: -20)
                    .frame(width: 30)

                Circle()
                    .fill(Color.accentColor)
                    .overlay(Circle().stroke(lineWidth: 3).fill(Color.white))
                    .shadow(color: Color("shadowGray"), radius: 12, x: 8)
                
                
                Text("\(day.number)")
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .opacity(day.currentMonth ? 1.0 : 0.2)
            } else {
                Text("\(day.number)")
                    .opacity(day.currentMonth ? 1.0 : 0.2)
            }
        }.frame(height: 35)
    }
}

fileprivate struct NumberCell: View {
    var day: Days
    var editing: Bool
    
    var body: some View {
        Text("\(day.number)")
            .opacity(day.currentMonth ? 1.0 : 0.2)
            .frame(height: 35)
    }
}

struct CalendarView_Previews: PreviewProvider {
    @State static var start: Date = Date().addDay(4)
    @State static var end: Date = Date().addDay(5)
    
    static var previews: some View {
        CalendarView(startDate: $start, endDate: $end, isShowing: .constant(true))
    }
}
