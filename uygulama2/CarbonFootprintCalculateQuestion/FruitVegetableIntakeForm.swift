import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct FruitVegetableIntakeForm : View {
    @State private var carbonHesap3 = false
    @ObservedObject var viewModel: CarbonFootprintViewModel
    @State private var currentUserUID: String? // Kullanıcının UID'sini tutacak state
    let firebaseManager = FirebaseManager() // FirebaseManager örneği

    var body: some View {
        VStack {
            calculatePeopleView()
            
        }
        .navigationDestination(isPresented: $carbonHesap3) {
            ClothingFabricChoice(viewModel: CarbonFootprintViewModel())
        }
    }

    func calculatePeopleView() -> some View {
        GroupBox {
            Text("Lütfen haftada kaç kg sebze ve meyve tükettiğinizi giriniz.")
                .font(.custom("RobotoSlab-Regular", size: 20))
                .frame(width: 300,height: 100)
            
            Text("(Lütfen kg cinsinden giriniz.)")
                .opacity(0.5)
                .frame(width: 300,height: 30)
                .font(.custom("RobotoSlab-Regular", size: 15))
         
            TextField("Sebze tüketim miktarınız", text: $viewModel.sebze)
                .frame(width: 300, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("RobotoSlab-Regular", size: 16))
            
            TextField("Meyve tüketim miktarınız", text: $viewModel.meyve)
                .frame(width: 300, height: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.custom("RobotoSlab-Regular", size: 16))
            
          
            
            Button(action: {
                guard let sebze = Int(viewModel.sebze) else {
                    print("Hata: otobüs değeri tamsayıya dönüştürülemedi")
                    return
                }
                
                guard let meyve = Int(viewModel.meyve) else {
                    print("Hata: metro değeri tamsayıya dönüştürülemedi")
                    return
                }
                
            
                if let uid = currentUserUID {
                    firebaseManager.saveUserDataa(uid: uid, data: ["sebze": sebze, "meyve": meyve]) { error in
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

struct FruitVegetableIntakeForm_Previews: PreviewProvider {
    static var previews: some View {
        FruitVegetableIntakeForm(viewModel: CarbonFootprintViewModel())
    }
}
