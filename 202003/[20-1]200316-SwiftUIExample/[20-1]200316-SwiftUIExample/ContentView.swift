//
//  ContentView.swift
//  [20-1]200316-SwiftUIExample
//
//  Created by cskim on 2020/03/16.
//  Copyright © 2020 cskim. All rights reserved.
//

import SwiftUI

struct MyRow: View {
  let someNumber: Int
  var body: some View {
    HStack {
      Image("SwiftUI")
      Text("SwiftUI \(someNumber)")
    }
  }
}

struct ContentView: View {
  // some : View protocol을 만족하는 어떤 타입이든 body가 될 수 있음
  // associatedType과 관련한 protocol에서 some을 사용할 수 있다
  
  // State : Property Wrapperr를 사용해서 만든 것.
  // view에서 값을 저장하고 변형ㅇ하기 위해 사용하는 것
  // View의 상태를 저장하기 위한 property wrapper 사용해서 mutating 문제 해결
  @State var count = 0
  
  // State가 변경될 때 body를 다시 호출해서 State가 명시된 property의 변경된 값을 다시 화면에 그려준다
  var body: some View {
    
    /* View Layout */
    // VStack : 세로 , HStack : 가로, ZStack : View Hierarchy 생성. addSubview
    // UIStackView와 비슷하지만 UIStackView를 이용한 것은 아님. 새로 만들어진것?
    // - spacing 안주면 기본값
    // - alignment : HStack에서 세로 방향, VStack에서 가로 방향 정렬 방법 설정
    print("Count Up")
    
    return NavigationView {
      VStack(spacing: 30) {
        NavigationLink(destination: Text("First Detail")) {
          Image("SwiftUI")
        }
        NavigationLink(destination: Text("Second Detail")) {
          Image("SwiftUI")
        }
        Text("\(self.count)")
        Button("Count UP") {
          self.count += 1
        }.foregroundColor(.black)
      }
      .font(.largeTitle)
      .navigationBarTitle(Text("Navi Title"), displayMode: .inline)
      .navigationBarItems(trailing: Image(systemName: "bell") )
    }
    
//    List {
//      ForEach(0..<100) { i in
//        Section(header: Text("Header").font(.title).background(Color.gray),
//                footer: Text("Footer").font(.body)) {
//          MyRow(someNumber: i)
//        }
//      }
//    }
//  .listStyle(GroupedListStyle())
    
    
//    print("Show when Debug Preview")  // Preview rendering 과정에서 두번 호출되지만 실제 실행하면 한 번만 호출된다
//    return List(0..<100) { i in
//      Text("\(i)")
////      Text("Text")
////      Image("SwiftUI")
////      Circle().fill(Color.red).frame(width: 100, height: 100)
////      Rectangle().fill(Color.blue).frame(width: 100, height: 100)
//    }
    
    
//    Rectangle()
//      .fill(Color.green)
//      .frame(width: 200, height: 400)
//      .overlay(Text("Text"))    // 앞으로 추가
//      .background(              // 뒤로 추가
//        RoundedRectangle(cornerRadius: 8).fill(Color.yellow).offset(x: 10, y: 10)
//      )
//    // ZStack은 형제 뷰 같은 느낌, overlay, background는 직접 subview로 추가
    
//    VStack {
//      HStack {
//        Text("제목").font(.largeTitle)
//        Text("부제목").foregroundColor(Color.gray)
//      }.fixedSize()
//
//
//      Spacer()      // Spacer가 1/3 차지
//
//      Text("본문 내용")
//
//      Spacer()      // Spacer가 2/3 차지
//      Spacer()
//
//      Text("각주").font(.body)
//    }
//    .frame(width: 200, height: 350)
//    .padding()
//    .border(Color.blue, width: 2)
    
    
//    ZStack {
//      Spacer().background(Color.orange)   // Spacer 공간이 뒤로 배치
//      Text("Spacer")
//        .font(.title)
//        .background(Color.green)
//    }
//    .background(Color.orange)
    
//    HStack {
//      Text("Spacer MinLength")
//        .font(.title)
//        .background(Color.blue)
////      Spacer().frame(width: 100)
//      Spacer(minLength: 150)
//      Text("Spacer")
//        .font(.title)
//        .background(Color.green)
//    }
//    .background(Color.orange)
    
    //    HStack {
    //      Text("HStack")
    //        .font(.title)
    //        .foregroundColor(.blue)
    //      Text("은 뷰를 가로로 배치합니다")
    //      Text("!")
    //    }
    //    .padding()
    //    .border(Color.black)
    //    .font(.largeTitle)    // 이미 안에서 지정한 것을 우선적으로 적용하기 때문에 "HStack" Text에는 적용되지 않았다
    
    //    ZStack {
    //      Rectangle()
    //        .fill(Color.red)
    //        .frame(width: 150, height: 150)
    //        .offset(x: -40, y: -40)
    //
    //      Rectangle()
    //        .fill(Color.green)
    //        .frame(width: 150, height: 150)
    //        .zIndex(1)
    //
    //      Rectangle()
    //        .fill(Color.yellow)
    //        .frame(width: 150, height: 150)
    //        .offset(x: 40, y: 40)
    //      .zIndex(-1)
    //    }
    
    //    HStack(alignment: .top) {
    //      Rectangle()
    //        .fill(Color.green)
    //        .frame(width: 150, height: 150)
    //
    //      Rectangle()
    //        .fill(Color.yellow)
    //      .frame(width: 150, height: 150)
    //    }
    
    /* Image Scaling */
    //    HStack {
    //      Image(systemName: "book.fill")
    //        .imageScale(.small)
    //        .foregroundColor(.red)
    //      Image(systemName: "book.fill")
    //        .imageScale(.medium)
    //        .foregroundColor(.green)
    //        .font(.title)
    //      Image(systemName: "book.fill")
    //        .imageScale(.large)
    //        .foregroundColor(.blue)
    //        .font(.largeTitle)
    //    }
    
    //    VStack {
    //      Image("SwiftUI")
    //      Image("SwiftUI")
    //        .renderingMode(.original)
    //      Image("SwiftUI")
    //        .renderingMode(.template)
    //
    //      Image(systemName: "person")
    //        .renderingMode(.original)     // SFSymbol은 기본 rendering mode가 template, original로 바꾸면 색 안밖뀜
    //        .font(.largeTitle)
    //
    //      Image(systemName: "person")
    //        .renderingMode(.template)
    //        .font(.largeTitle)
    //
    //    }.foregroundColor(.red)
    
    
    //    VStack(spacing: 16) {
    //
    //      Image("SwiftUI")
    //      Image("SwiftUI").clipShape(Circle())
    //      Image("SwiftUI").clipShape(Rectangle().inset(by: 10))
    //      Image("SwiftUI").clipShape(Ellipse().path(in: CGRect(x: 0, y: 0, width: 80, height: 100)))
    //
    //    }
    
    //    HStack(spacing: 30) {
    
    //      Image("SwiftUI")
    //      .resizable()          // 이미지를 원본 크기에서 변형할 때
    //        // Image 기본값 ScaleToFill
    //      .scaledToFit()        // UIKit -> Aspect Fit
    //      .scaledToFill()       // UIKit -> Aspect Fill
    //      .frame(width: 200, height: 400)
    //      .clipped()            // UIKit -> clipsToBounds
    
    
    
    //      Image("SwiftUI")  // Image Origin Size 100 x 100
    ////        .resizable(resizingMode: .tile)     // 하나를 늘리거나 격자방식으로 채우거나
    //        .resizable(capInsets: .init(top: 0, leading: 50, bottom: 0, trailing: 0),   // CapInset : 이미지 특정 영역을 선택해서 늘림
    //                   resizingMode: .stretch)
    
    //      // Swift에서 이미지는 항상 고정값
    //      // 이미지를 변경하기 위해 resizing 명시해야함
    //      Image("SwiftUI")
    //        .resizable()
    //        .frame(width: 50, height: 50)
    //
    //      Image("SwiftUI")
    //        .resizable()
    //        .frame(width: 200, height: 200)
    //    }
    
    //    VStack {
    //      Text("SwiftUI")
    //        .font(.title)
    //        .bold()
    //        .padding()
    //
    //      Text("SwiftUI")
    //        .foregroundColor(.white)
    //        .padding()
    //        .background(Color.blue)
    //
    //      Text("Custom Font, Boldd, Italic, Underline, Cancel")
    //        .font(.custom("Menlo", size: 16))
    //        .bold()
    //        .italic()
    //        .underline()
    //        .strikethrough()
    //
    //      Text("Line Limit\nText Alignment\nNot Showing This Line")
    //        .lineLimit(5)
    //        .multilineTextAlignment(.trailing)
    //
    //      (Text("자간, 기준선").kerning(8) +
    //        Text(" 추가된 텍스트").baselineOffset(16))
    //        .font(.system(size: 20))    // 둘다 적용
    //      // 원래방식
    ////      let label = UILabel()
    ////      let attr = [NSAttributedString.Key] = [NSAttributedString.Key.kern: 8]
    ////      label.attributedText = NSAttributedString(string: "자간", attributes: attr)
    //    }
    
    
    // 하나의 View는 struct이므로 매번 새로운 view가 만들어지고
    // method 하나씩 추가할 때 마다 새로운 속성이 입혀진 또 다른 View가 만들어 지는 것
    
    //
    //    return Text("Hello, World!")  // 하나의 객체만 반환할 때 return 생략할 수 있다
    //      .font(.largeTitle)          // Text
    //      .fontWeight(.semibold)      // Text
    //      .foregroundColor(.red)      // Text
    //      .colorInvert()              // View
    
  }
}

// Preview 여러개 보기

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
//    ForEach(["iPhone 8", "iPhone 8 Plus", "iPhone 11 Pro", "iPhone 11 Pro Max"], id: \.self) { device in
//      Group {
//        ContentView()
//          .previewDevice(PreviewDevice(rawValue: device))
//          .previewDisplayName(device)
//
//        ContentView()
//          .flipsForRightToLeftLayoutDirection(true)
//          .environment(\.layoutDirection, .rightToLeft)
//      }
//    }
    
    
//    Group {
//      ContentView()
//        .previewLayout(.sizeThatFits)   // View 크기만큼만
//        .background(Color.red)
//        .previewDisplayName("SwiftUI")
//      ContentView()
//        .previewLayout(.fixed(width: 300, height: 300)) // 지정한 크기로 보여줌
//        .background(Color.blue)
//        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))     // 안하면 target에서 선택한 simulator 적용
//        .previewDisplayName("SwiftUI Preview")
//    }
  }
}

//struct ContentView_Previews1: PreviewProvider {
//  static var previews: some View {
//    ContentView().background(Color.red)
//  }
//}
//
//struct ContentView_Previews2: PreviewProvider {
//  static var previews: some View {
//    ContentView().background(Color.blue)
//  }
//}
