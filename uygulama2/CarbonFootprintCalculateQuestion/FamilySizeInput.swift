import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct FamilySizeInput: View {
    @State private var carbonHesap3 = false
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var currentUserUID: String? // Kullanıcının UID'sini tutacak state
    let firebaseManager = FirebaseManager() // FirebaseManager örneği

    var body: some View {
        VStack {
            calculatePeopleView()
            
            GroupBox {
                Text("Ev kaynaklı emisyonlar kişi sayısına bölünerek kişisel ayak izinizi bulmak için sorulmaktadır.")
                    .frame(width: 300, height: 100)
                    .font(.custom("RobotoSlab-Regular", size: 18))
                    .foregroundColor(.color2)
            }
            .foregroundColor(.gray) // .color2 yerine doğrudan bir renk kullanın
        }
        .navigationDestination(isPresented: $carbonHesap3) {
            ElectricityConsumptionForm(viewModel: CarbonFootprintViewModel())
        }
    }

    func calculatePeopleView() -> some View {
        GroupBox {
            Text("Evde kaç kişi yaşıyorsunuz?")
                .font(.custom("RobotoSlab-Regular", size: 20))
         
            TextField("Kişi sayısını giriniz", text: $viewModel.kisiSayisi)
                .frame(width: 300, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("RobotoSlab-Regular", size: 16))
            
            Button(action: {
                guard let kisiSayisi = Int(viewModel.kisiSayisi) else {
                    print("Hata: kisiSayisi değeri tamsayıya dönüştürülemedi")
                    return
                }
                
                if let uid = currentUserUID {
                    firebaseManager.saveUserDataa(uid: uid, data: ["kisiSayisi": kisiSayisi]) { error in
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

struct Soru1_Previews: PreviewProvider {
    static var previews: some View {
        FamilySizeInput(viewModel: CarbonFootprintViewModel())
    }
}
