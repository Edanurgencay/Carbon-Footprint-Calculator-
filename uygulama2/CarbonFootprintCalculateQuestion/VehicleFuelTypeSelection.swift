//
//  Soru5Evet.swift
//  uygulama2
//
//  Created by Eda Gencay on 19.05.2024.
//

import SwiftUI

struct VehicleFuelTypeSelection: View {
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var benzin = false
    @State private var motorin = false
    @State private var lpg = false
    var body: some View {
        VStack{
            GroupBox{
            
                Text("Otomobilinizin yakıt türünü seçiniz.")
                    .frame(width: 300,height: 100)
                    .font(.custom("RobotoSlab-Regular", size: 20))
               
                
                Button(action: {
                  benzin = true
                }, label: {
                    Text("Benzin").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 40)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                }).navigationDestination(isPresented: $benzin){
                    GasolineMileageInput(viewModel: CarbonFootprintViewModel())
                }
                
                
                
                Button(action: {
                   motorin = true
                }, label: {
                    Text("Motorin/Dizel").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 40)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                }).navigationDestination(isPresented: $motorin){
                    DieselMileageInput(viewModel: CarbonFootprintViewModel())
                }
                
                Button(action: {
                   lpg = true
                }, label: {
                    Text("Lpg").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 40)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                }).navigationDestination(isPresented: $lpg){
                    LpgMileageInput(viewModel: CarbonFootprintViewModel())
                }
               

              
                }
                
               
                 
               
            }.frame( height: 500)
            
            
                
          
                
            }
            
        }

#Preview {
    VehicleFuelTypeSelection(viewModel: CarbonFootprintViewModel())
}
