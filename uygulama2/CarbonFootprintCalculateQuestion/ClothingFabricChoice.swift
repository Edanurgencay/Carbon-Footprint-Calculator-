//
//  Soru8.swift
//  uygulama2
//
//  Created by Eda Gencay on 19.05.2024.
//

import SwiftUI

struct ClothingFabricChoice: View {
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var pamuk = false
    @State private var polyester = false
    
    var body: some View {
        VStack{
            GroupBox{
                
                Text("Satın aldığınız kıyafetlerde genellikle hangi tür kumaş tercih edersiniz?")
                    .frame(width: 300 ,height: 100)
                    .font(.custom("RobotoSlab-Regular", size: 20))
                
                Button(action: {
                  
                   pamuk = true
                }, label: {
                    Text("Pamuklu,keten,deri vb. organik temelli kıyafetler").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 60)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                }).navigationDestination(isPresented: $pamuk){
                    CottonClothingEntry(viewModel: CarbonFootprintViewModel())}
                
                
                Button(action: {
                   
                    polyester = true
                    
                }, label: {
                    Text("Polyester vb. yapay malzemeli kıyafetler").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 60)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                }).navigationDestination(isPresented: $polyester){
                    PolyesterClothingEntry(viewModel: CarbonFootprintViewModel())
                }
                
                
                
                
                
            }
            }
            
            GroupBox{
                
                Text("Her yıl moda sektörüne kaynak üretmek için 159 milyon ağaç kesilirken üretim için harcanan yıllık 93 milyar metreküp suyun küresel su kullanımının yüzde 4’üne tekabül ettiğini biliyor muydunuz? ").frame(width: 300, height: 150)
                    .font(.custom("RobotoSlab-Regular", size: 16))
                   
            } .foregroundColor(.color2)
                
           
               
    }
            
    }
   
       
    


#Preview {
    ClothingFabricChoice(viewModel: CarbonFootprintViewModel())
}
