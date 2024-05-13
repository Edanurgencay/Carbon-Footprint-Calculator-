//
//  Soru8.swift
//  uygulama2
//
//  Created by Eda Gencay on 19.05.2024.
//

import SwiftUI

struct CarbonOffsetInquiry: View {
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var evet = false
    @State private var hayır = false

    var body: some View {
        VStack{
            GroupBox{
                
                Text("Offsetleme çalışması yaptınız mı?")
                    .frame(width: 300 ,height: 100)
                    .font(.custom("RobotoSlab-Regular", size: 20))
                
                Button(action: {
                   evet = true
                }, label: {
                    Text("Evet").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 40)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                }).navigationDestination(isPresented: $evet){
                    CertificateCO2Input(viewModel: CarbonFootprintViewModel())
                }
                
                
                Button(action: {
                 hayır = true
                }, label: {
                    Text("Hayır").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 40)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                }).navigationDestination(isPresented: $hayır){
                    CarbonFootprintResultsView(viewModel: CarbonFootprintViewModel()) }
                
                
                
                
                
            }
            
            GroupBox{
                
                Text("Karbon emisyonlarınız azaltmak için karbon azaltan projeleri finanse etmek offset olarak isimlendirilir. Örneğin ağaçlandırma projelerine katkı sağlayarak karbon emisyonlarınızı offsetleyebilir ve sertifka sahibi olabilirsiniz. ").frame(width: 300, height: 150)
                    .font(.custom("RobotoSlab-Regular", size: 16))
                   
            } .foregroundColor(.color2)
                
           
               
            }.frame( height: 500)
            
    }
}

#Preview {
    CarbonOffsetInquiry(viewModel: CarbonFootprintViewModel())
}
