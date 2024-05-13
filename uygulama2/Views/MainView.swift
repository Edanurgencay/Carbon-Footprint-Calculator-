//
//  SwiftUIView.swift
//  uygulama2
//
//  Created by Eda Gencay on 27.07.2024.
//

import SwiftUI

struct MainView: View {
    @State private var bütünYazilar = false
    
    init(){
        let appearance = UINavigationBarAppearance()
             
       
                // Başlık stilini ve boyutunu özelleştiriyoruz
                appearance.titleTextAttributes = [
                    .foregroundColor: UIColor.black,
                    .font: UIFont(name: "RobotoSlab-Regular", size: 20)! // Font adını ve boyutunu burada ayarlayabilirsiniz
                ]
        UINavigationBar.appearance().standardAppearance = appearance
               
             
          
            
    }

    
    var body: some View {
        
    
            
            ScrollView {
                //kaydırılabilir sayfa tasarımı yapıyoruz.
                VStack{
                    
                    ZStack(alignment: .bottom) {// burada görsel ve buton üst üste gelicek şekilde tasarlanıyor.
                        
                        Image("home-page")
                            .resizable()
                            .scaledToFill()
                        
                        
                        NavigationLink(destination: StartScreen()){
                            Text("Karbon Ayak İzi Hesaplayıcı") .foregroundColor(.white)
                                .font(.custom("RobotoSlab-Regular_Bold", size: 16))
                                .frame(width: 350, height: 50)
                                .background(Color.color2)
                                .cornerRadius(10)
                                .padding()
                        }
                       
                    }
                        
                        Spacer()
                        
                        HStack{
                            
                            Text("Blog Yazıları")
                                .font(.custom("RobotoSlab-Regular_Bold", size: 25)).padding()
                            Spacer()
                            
                            NavigationLink(destination: AllPosts()){
                                Text("Hepsini Gör")
                                    .foregroundColor(.black)
                                    .underline()
                                    .font(.custom("RobotoSlab-Regular", size: 14)).padding()
                            }
                           
                            
                        }
                        
                        LazyVStack {
                            ForEach(featuredpost) { post in
                                NavigationLink(destination: BlogPostView(blogPost: post)) {
                                    BlogPostCardMain(blogPost: post)
                                }
                            }
                        }
                        
                        
                        
                        
                        
                        
                    }
                }.edgesIgnoringSafeArea(.top)
                //güvenli alanın üstünü yok saydık
                .navigationBarTitle("Hoşgeldiniz", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
            }
        }
    

#Preview {
    MainView()
}
