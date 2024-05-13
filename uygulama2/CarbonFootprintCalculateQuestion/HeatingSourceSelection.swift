import SwiftUI

struct HeatingSourceSelection: View {
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var dogalgaz = false
    @State private var kömür = false
    @State private var CarbonHesap8 = false
    
    var body: some View {
        VStack{
            GroupBox{
                
                Text("Evinizde ısınma kaynaklı kullandığınız temel yakıt nedir?")
                    .frame(width: 300 ,height: 100)
                    .font(.custom("RobotoSlab-Regular", size: 20))
                
                
                
                Button(action: {
                    dogalgaz = true
                }, label: {
                    Text("Doğalgaz").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 40)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                }).navigationDestination(isPresented: $dogalgaz){
                    NaturalGasConsumptionInput(viewModel: CarbonFootprintViewModel())
                }
                
                
                Button(action: {
                    kömür = true
                }, label: {
                    Text("Kömür").foregroundColor(.white)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .frame(width: 300, height: 40)
                        .background(Color.color3).opacity(0.85)
                        .cornerRadius(10)
                }).navigationDestination(isPresented: $kömür){
                    CoalConsumptionInput(viewModel: CarbonFootprintViewModel())
              
                }
            }.frame( height: 500)
            
                
                GroupBox{
                    
                    Text("1 metreküp doğalgazın yakılması ile 2,1857 kg karbondioksit gazı açığa çıkmaktadır. Yani bir metreküp doğalgazın karbon maliyeti 2,1857 kg’dır.").frame(width: 300, height: 120)
                        .font(.custom("RobotoSlab-Regular", size: 18))
                    
                } .foregroundColor(.color2)
                
                
                
            }
            
        }
    }


#Preview {
    HeatingSourceSelection(viewModel: CarbonFootprintViewModel())
}
