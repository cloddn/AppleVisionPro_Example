//
//  MainView.swift
//  basicUI
//
//  Created by 고희정 on 3/15/24.
//

import SwiftUI


//Struct View type : Layout(배치 신경써줘야함!)이 생기지 않음
struct MainView: View { // view - 생성하기위해 구조
    //Data handle
    //type : Array
    //var : 변수(항상 소문자로 시작) , let : 상수
    var hoonieImage = ["image1"
                       ,"image2"
                       ,"image3"
                       ,"image4"
                       ,"image5"
                       ,"image6"
                       ,"image7"
                       ,"image8"
                       ,"image9"
                       ,"image10"
    ]//parameter 선언시 body 밖에서 하면 됨

    var body: some View { // 모든 content는 body안에 넣어줘야함.
        NavigationSplitView {
            //Side Bar
            List {
                HStack {
                    Image(systemName: "house.fill" )
                    Text("Hello")
                }
                HStack {
                    Image(systemName: "keyboard.fill" )
                    Text("Hello")
                }
                HStack {
                    Image(systemName: "moon.stars.fill" )
                    Text("Hello")
                }
                HStack {
                    Image(systemName: "moon.stars" )
                    Text("Hello")
                }
                HStack {
                    Image(systemName: "house.fill" )
                    Text("Hello")
                }
                HStack {
                    Image(systemName: "keyboard.fill" )
                    Text("Hello")
                }
                HStack {
                    Image(systemName: "moon.stars.fill" )
                    Text("Hello")
                }
                HStack {
                    Image(systemName: "moon.stars" )
                    Text("Hello")
                }
                .navigationTitle("Augmented Interaction")
                
            }
        } content: {
            //MainView
            Text("Hello")
        
        }
        detail: {
       
        }.navigationTitle("Test")

        
    
    }
}

struct PostImageView : View{
    var body : some View{
        VStack {
            HStack(spacing : 20) {
                //Text
                
                Image("profile_image")//Assets에 image가져올 수 있음
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300,height: 200)
                    .clipShape(Circle())
                
                Text("Sanghoon Moon")
                // .font(.largeTitle)
                // .fontWeight(.heavy)
                    .font(.system(size: 40, weight:
                            .semibold))
                    .foregroundStyle(.white) //웬만하면~ white
                //                .background(Color.blue)
                //.background(Color.blue)
                //.frame(width: 400, height: 100) //약간 div 느낌쓰
                //순서가 중요함: 기본적으로 8point
                //보여줄 수 있는 크기를 한정
                    .padding(10)
                
                
            }
            .frame(width: 800,height: 200,alignment:
                    .leading)//depth : 볼륨
            
            //Image()
            Image("sanghoon")//Assets에 image가져올 수 있음
                .resizable()
                .scaledToFill()
                .frame(width: 800,height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding(30)
            
        }
    }

}


#Preview {
    MainView()
}
