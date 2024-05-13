import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CertificateCO2Input: View {
    @State private var carbonHesap3 = false
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var currentUserUID: String? // Kullanıcının UID'sini tutacak state
    let firebaseManager = FirebaseManager() // FirebaseManager örneği

    var body: some View {
        
        VStack {
            calculatePeopleView()
            GroupBox{
                
                Text("Sertifikanız üzerinden ton CO2 miktarını öğrenebilirsiniz.").frame(width: 300, height: 50)
                    .font(.custom("RobotoSlab-Regular", size: 16))
                   
            } .foregroundColor(.color2)
            
        }
        .navigationDestination(isPresented: $carbonHesap3) {
            CarbonFootprintResultsView(viewModel: CarbonFootprintViewModel())
        }
    }

    func calculatePeopleView() -> some View {
        GroupBox {
            Text("CO2 miktarını giriniz.")
                .font(.custom("RobotoSlab-Regular", size: 20))
                .frame(width: 300,height: 60)
            
           
         
            TextField("ton CO2", text: $viewModel.tonCo2)
                .frame(width: 300, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("RobotoSlab-Regular", size: 16))
            
            Button(action: {
                carbonHesap3 = true
                guard let tonCo2 = Int(viewModel.tonCo2) else {
                    print("Hata: tonCo2 değeri tamsayıya dönüştürülemedi")
                    return
                }
                
                
                if let uid = currentUserUID {
                    firebaseManager.saveUserDataa(uid: uid, data: ["tonCo2": tonCo2]) { error in
                        if let error = error {
                            print("Hata: Kullanıcı yanıtları kaydedilemedi - \(error.localizedDescription)")
                        } else {
                            print("tonCo2 Kullanıcı yanıtları başarıyla kaydedildi")
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


struct CertificateCO2Input_Previews: PreviewProvider {
    static var previews: some View {
        CertificateCO2Input(viewModel: CarbonFootprintViewModel())
    }
}
