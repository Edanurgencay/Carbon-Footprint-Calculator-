//
//  CarbonHesap1.swift
//  uygulama2
//
//  Created by Eda Gencay on 14.05.2024.
//

import SwiftUI


struct StartScreen: View {
    @State private var carbonHesap1 = false
    
    
    var body: some View {
        NavigationView{
            ZStack{
                
                
                Image("carbon-footprint")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Karbon Ayak İzi Hesaplama Sistemine Hoşgeldiniz") .font(.custom("RobotoSlab-Regular", size: 22))
                      
                    
                    Button(action: {
                        carbonHesap1 = true
                    }, label: {
                        Text("BAŞLA")
                            .foregroundColor(.white)
                            .font(.custom("RobotoSlab-Regular_Bold", size: 20))
                            .frame(width: 370, height: 40)
                            .background(Color.color).opacity(0.85)
                            .cornerRadius(10)
                    }).navigationDestination(isPresented: $carbonHesap1){
                        FamilySizeInput(viewModel: CarbonFootprintViewModel())
                    }
                }
            }
            
        }}}

#Preview {
    StartScreen()
}
