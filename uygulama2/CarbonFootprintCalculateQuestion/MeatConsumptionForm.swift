import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MeatConsumptionForm : View {
    @State private var carbonHesap3 = false
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var currentUserUID: String? // Kullanıcının UID'sini tutacak state
    let firebaseManager = FirebaseManager() // FirebaseManager örneği

    var body: some View {
        VStack {
            calculatePeopleView()
            
        }
        .navigationDestination(isPresented: $carbonHesap3) {
            MilkConsumptionForm(viewModel: CarbonFootprintViewModel())
        }
    }

    func calculatePeopleView() -> some View {
        GroupBox {
            Text("Lütfen haftada kaç kg kırmızı et ve beyaz et tükettiğinizi giriniz.")
                .font(.custom("RobotoSlab-Regular", size: 20))
                .frame(width: 300,height: 100)
            
            Text("(Lütfen kg cinsinden giriniz.)")
                .opacity(0.5)
                .frame(width: 300,height: 30)
                .font(.custom("RobotoSlab-Regular", size: 15))
         
            TextField("Kırmızı et tüketim miktarı", text: $viewModel.kırmızıEt)
                .frame(width: 300, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("RobotoSlab-Regular", size: 16))
            
            TextField("Beyaz et tüketim miktarı", text: $viewModel.beyazEt)
                .frame(width: 300, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("RobotoSlab-Regular", size: 16))
            
          
            
            Button(action: {
                guard let kırmızıEt = Int(viewModel.kırmızıEt) else {
                    print("Hata: otobüs değeri tamsayıya dönüştürülemedi")
                    return
                }
                
                guard let beyazEt = Int(viewModel.beyazEt) else {
                    print("Hata: metro değeri tamsayıya dönüştürülemedi")
                    return
                }
                
            
                if let uid = currentUserUID {
                    firebaseManager.saveUserDataa(uid: uid, data: ["kırmızıEt": kırmızıEt]) { error in
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
                
                if let uid = currentUserUID {
                    firebaseManager.saveUserDataa(uid: uid, data: ["beyazEt": beyazEt]) { error in
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

struct MeatConsumptionForm_Previews: PreviewProvider {
    static var previews: some View {
        MeatConsumptionForm(viewModel: CarbonFootprintViewModel())
    }
}
