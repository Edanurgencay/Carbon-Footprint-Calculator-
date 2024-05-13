//
//  Soru7.swift
//  uygulama2
//
//  Created by Eda Gencay on 19.05.2024.
//

import SwiftUI
import FirebaseAuth

struct DietTypeSelection: View {
    @ObservedObject var viewModel: CarbonFootprintViewModel
    
    @State private var etTüketimi = false
    @State private var sütTüketimi = false
    @State private var sebzeMeyveTüketimi = false
    
    var body: some View {
        VStack{
            GroupBox{
                
                Text("Beslenme tipiniz nedir?")
                    .frame(width: 300 ,height: 100)
                    .font(.custom("RobotoSlab-Regular", size: 20))
                
                Button(action: {
                    etTüketimi = true
                }, label: {
                    Text("Her şeyi tüketirim.").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 40)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                })   .navigationDestination(isPresented: $etTüketimi){
                    uygulama2.MeatConsumptionForm(viewModel: CarbonFootprintViewModel())
                }
                
                Button(action: {
                    sebzeMeyveTüketimi = true
                }, label: {
                    Text("Veganım.").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 40)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                })  .navigationDestination(isPresented: $sebzeMeyveTüketimi){
                    uygulama2.FruitVegetableIntakeForm(viewModel: CarbonFootprintViewModel()) }
                    
                    
                    Button(action: {
                        sütTüketimi = true
                    }, label: {
                        Text("Vejeteryanım.").foregroundColor(.white)
                            .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                            .frame(width: 300, height: 40)
                            .background(Color.color3).opacity(0.85)
                            .cornerRadius(10)
                    })  .navigationDestination(isPresented: $sütTüketimi){
                        uygulama2.MilkConsumptionForm(viewModel: CarbonFootprintViewModel()) }
                        
                        
                    }
                    
                    GroupBox{
                        
                        Text("Mevsiminde sebze, meyve ve doğal ürün tüketirsek, yerel ürünlere dönersek karbon ayak izimizi ciddi ölçüde azaltmış oluruz").frame(width: 300, height: 100)
                            .font(.custom("RobotoSlab-Regular", size: 18))
                        
                    } .foregroundColor(.color2)
                    
                    
                    
                }
                
       
                
                
            }
        }
    
        
    

#Preview {
    DietTypeSelection(viewModel: CarbonFootprintViewModel())
}


