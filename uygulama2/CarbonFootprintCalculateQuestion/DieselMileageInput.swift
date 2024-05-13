import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct DieselMileageInput : View {
    @State private var carbonHesap3 = false
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var currentUserUID: String? // Kullanıcının UID'sini tutacak state
    let firebaseManager = FirebaseManager() // FirebaseManager örneği

    var body: some View {
        VStack {
            calculatePeopleView()
            
        }
        .navigationDestination(isPresented: $carbonHesap3) {
            PublicTransportMileageInput(viewModel: CarbonFootprintViewModel())
        }
    }

    func calculatePeopleView() -> some View {
        GroupBox {
            Text("Aylık ortalama kilometrenizi giriniz.")
                .font(.custom("RobotoSlab-Regular", size: 20))
                .frame(width: 300,height: 60)
            
            Text("(Lütfen km cinsinden giriniz.)")
                .opacity(0.5)
                .frame(width: 300,height: 30)
                .font(.custom("RobotoSlab-Regular", size: 15))
         
            TextField("km", text: $viewModel.motorin)
                .frame(width: 300, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("RobotoSlab-Regular", size: 16))
            
            Button(action: {
                guard let motorin = Int(viewModel.motorin) else {
                    print("Hata: benzin değeri tamsayıya dönüştürülemedi")
                    return
                }
                
                if let uid = currentUserUID {
                    firebaseManager.saveUserDataaMotorin(uid: uid, data: ["motorin": motorin]) { error in
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

struct DieselMileageInput_Previews: PreviewProvider {
    static var previews: some View {
        DieselMileageInput(viewModel: CarbonFootprintViewModel())
    }
}
