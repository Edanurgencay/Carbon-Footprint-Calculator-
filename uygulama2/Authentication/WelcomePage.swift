//
//  SwiftUIView.swift
//  uygulama2
//
//  Created by Eda Gencay on 13.05.2024.
//

import SwiftUI
import AVKit
  
struct WelcomePage: View {
    @State private var signUpPage = false
    @State private var loginPage = false
    
    var body: some View {
        NavigationStack{
            
            ZStack{
            
                Image("welcome-page-background").resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    Image(.appLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150 , height: 170)
                        .opacity(0.7)
                        .padding(100)
                     
                    NavigationLink(destination: SignUpPage()){Text("Kayıt Ol")
                            .foregroundColor(.white)
                            .font(.custom("RobotoSlab-Regular_Bold", size: 20))
                            .frame(width: 380, height: 50)
                            .background(Color.color1.opacity(0.7))
                            .cornerRadius(10)}
                   
                   
                    Text("Bir hesabın var mı?")
                        .font(.custom("RobotoSlab-Regular", size: 16))
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: LoginPage()){
                        Text("Giriş Yap")
                            .font(.custom("RobotoSlab-Regular", size: 18))
                            .underline()
                            .foregroundColor(Color.white)
                        
                    }
                   
                  
                }
            }
            
            
        }.navigationBarBackButtonHidden(true)
    }
    
    
    
}


#Preview {
    WelcomePage()
}
