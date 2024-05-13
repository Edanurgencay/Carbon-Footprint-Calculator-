import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct NaturalGasConsumptionInput: View {
    @State private var carbonHesap3 = false
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var currentUserUID: String? // Kullanıcının UID'sini tutacak state
    let firebaseManager = FirebaseManager() // FirebaseManager örneği

    var body: some View {
        VStack {
            calculatePeopleView()
            
          
        
            
        }
        .navigationDestination(isPresented: $carbonHesap3) {
            VehicleOwnershipQuestion(viewModel: CarbonFootprintViewModel())
        }
    }

    func calculatePeopleView() -> some View {
        GroupBox {
            Text("Aylık doğalgaz tüketiminiz nedir? ")
                .font(.custom("RobotoSlab-Regular", size: 20))
                .frame(width: 300,height: 30)
            
            Text("(Lütfen metreküp cinsinden giriniz.)")
                .opacity(0.5)
                .frame(width: 300,height: 30)
                .font(.custom("RobotoSlab-Regular", size: 15))
         
            TextField("m³", text: $viewModel.dogalgaz)
                .frame(width: 300, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("RobotoSlab-Regular", size: 16))
            
            Button(action: {
                guard let dogalgaz = Int(viewModel.dogalgaz) else {
                    print("Hata: kömür değeri tamsayıya dönüştürülemedi")
                    return
                }
                
                if let uid = currentUserUID {
                    firebaseManager.saveUserDataaDogalgaz(uid: uid, data: ["dogalgaz": dogalgaz]) { error in
                        if let error = error {
                            print("Hata: Kullanıcı yanıtları kaydedilemedi - \(error.localizedDescription)")
                        } else {
                            print("Kullanıcı yanıtları başarıyla kaydedildi")
                            carbonHesap3 = true
                        }
                    }
                } else {
                    print("Hata: Geçerli kullanıcı UID'si yok")
                }
            }) {
                Text("Kaydet")
                    .foregroundColor(.black)
                    .font(.custom("RobotoSlab-Regular", size: 18))
            }
        }
        .onAppear {
            if let currentUser = Auth.auth().currentUser {
                currentUserUID = currentUser.uid
            } else {
                print("Hata: Oturum açmış kullanıcı bulunamadı")
            }
        }
    }
}

struct Soru4Dogalgaz_Previews: PreviewProvider {
    static var previews: some View {
        NaturalGasConsumptionInput(viewModel: CarbonFootprintViewModel())
    }
}
