//
//  CarbonHesap8.swift
//  uygulama2
//
//  Created by Eda Gencay on 15.05.2024.
//

import SwiftUI

struct VehicleOwnershipQuestion: View {
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var evet = false
    @State private var hayır = false
    var body: some View {
        VStack{
            GroupBox{
            
                Text("Şahsi/kiralık otomobile sahip misiniz?")
                    .frame(width: 300,height: 100)
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
                    VehicleFuelTypeSelection(viewModel: CarbonFootprintViewModel())
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
                    PublicTransportMileageInput(viewModel: CarbonFootprintViewModel())
                    
                }
              
                }
                
               
                 
               
            }.frame( height: 500)
            
            GroupBox{
                
                Text("Araba kullanmak yerine kısa mesafeler için yürüyün, bisiklete binin, scooter veya toplu taşıma araçlarını kullanın.").frame(width: 300, height: 100).font(.custom("RobotoSlab-Regular", size: 18))
                   
            } .foregroundColor(.color2)
                
          
                
            }
            
        }


#Preview {
    VehicleOwnershipQuestion(viewModel: CarbonFootprintViewModel())
}
