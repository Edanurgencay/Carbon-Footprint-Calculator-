import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore

struct CarbonFootprintResultsView: View {
    @ObservedObject var viewModel = CarbonFootprintViewModel()
    @State private var anasayfa = false
    @State private var userCarbonFootprint: Double = 0.0
    
    @State private var kullanıcıSuEmisyonu: Double = 0.0
    @State private var kullanıcıElektrikEmisyonu: Double = 0.0
    @State private var kullanıcıDogalgazEmisyonu: Double = 0.0
    @State private var kullanıcıKömürEmisyonu: Double = 0.0
    @State private var evEmisyonları: Double = 0.0
    @State private var kullanıcıBenzinEmisyonu: Double = 0.0
    @State private var kullanıcıLpgEmisyonu: Double = 0.0
    @State private var kullanıcıMotorinEmisyonu: Double = 0.0
    @State private var kullanıcıOtobüsEmisyonu: Double = 0.0
    @State private var kullanıcıMetroEmisyonu: Double = 0.0
    @State private var kullanıcıTrenEmisyonu: Double = 0.0
    @State private var kullanıcıTramvayEmisyonu: Double = 0.0
    @State private var ulaşımEmisyonları: Double = 0.0
    @State private var kullanıcıKırmızıEtEmisyonu: Double = 0.0
    @State private var kullanıcıBeyazEtEmisyonu: Double = 0.0
    @State private var kullanıcıSütEmisyonu: Double = 0.0
    @State private var kullanıcıSebzeEmisyonu: Double = 0.0
    @State private var kullanıcıMeyveEmisyonu: Double = 0.0
    @State private var beslenmeEmisyonları: Double = 0.0
    @State private var diğerEmisyonlar: Double = 0.0
  
    
    @State private var kullanıcıYıllıkElektrikTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkSuTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkDogalgazTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkKömürTüketimi: Double = 0.0
    
    @State private var kullanıcıYıllıkBenzinTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkLpgTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkMotorinTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkOtobüsKullanımı: Double = 0.0
    @State private var kullanıcıkYıllıkMetroKullanımı: Double = 0.0
    @State private var kullanıcıYıllıkTrenKullanımı: Double = 0.0
    @State private var kullanıcıYıllıkTramvayKullanımı: Double = 0.0
    
    @State private var kullanıcıYıllıkKırmızıEtTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkBeyazEtTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkSütTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkSebzeTüketimi: Double = 0.0
    @State private var kullanıcıYıllıkMeyveTüketimi: Double = 0.0


    @State private var kullanıcıKiyafetPamukEmisyon: Double = 0.0
    @State private var kullanıcıKiyafetPolyesterEmisyon: Double = 0.0
  
    
    //ev kaynalı emisyon değerleri
    private let elektrikEmisyon : Double =  0.43 //kg CO2/kWh
    private let suEmisyon: Double = 0.36 //kg CO2/m³
    private let dogalgazEmisyon: Double = 2.1857 //kg CO2/m³
    private let kömürEmisyon: Double = 2.93 //kg CO2/kg
    
    //ulaşım kaynaklı emisyon değerleri
    private let benzinEmisyon: Double = 2.33 //kg CO2/litre
    private let lpgEmisyon: Double = 1.69 //kg CO2/litre
    private let motorinEmisyon: Double = 2.77 //kg CO2/litre
    private let otobüsEmisyon: Double = 0.089 //kg CO2/km
    private let metroEmisyon: Double = 0.065 //kg CO2/km
    private let trenEmisyon: Double = 0.06 //kg CO2/km
    private let tramvayEmisyon: Double = 0.053 //kg CO2/km
    
    //beslenme kaynaklı emisyon değerleri
    private let kırmızıEtTüketimiEmisyon: Double = 33.1 //kg CO2/kg
    private let beyazEtTüketimiEmisyon: Double = 6.9 //kg CO2/kg
    private let sütTüketimiEmisyon: Double = 7.5 //kg CO2/kg
    private let sebzeTüketimiEmisyon: Double = 2.5 //kg CO2/kg
    private let meyveTüketimiEmisyon: Double = 1.0 //kg CO2/kg
   
    
    //giyim kaynaklı emisyon değerleri
    private let kiyafetAlisverisiPamukEmisyon: Double = 6.5 //kg CO2/kg(parça başı)
    private let kiyafetAlisverisiPolyesterEmisyon: Double = 5.0 //kg CO2/kg(parça başı)
    
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        anasayfa = true
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }.navigationDestination(isPresented: $anasayfa){
                        ContentView()
                    }
                    .padding(.trailing, 20)
                }
                
                Text("Sonuç")
                    .font(.custom("RobotoSlab-Regular", size: 35))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Spacer()
                
                Text("Kişisel karbon ayak iziniz:")
                    .font(.custom("RobotoSlab-Regular", size: 18))
                    .padding(.bottom, 10)
                
                Text(String(format: "%.2f", userCarbonFootprint))
                    .font(.custom("RobotoSlab-Regular_bold", size: 50))
                    .padding(.bottom, 10)
                
                Text("Tons CO2e")
                    .font(.custom("RobotoSlab-Regular", size: 20))
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Nasıl karşılaştırırsın?")
                        .font(.custom("RobotoSlab-Regular_Bold", size: 18))
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text("Sen")
                            .font(.custom("RobotoSlab-Regular", size: 16))
                        Spacer()
                        Text(String(format: "%.1f Tons", userCarbonFootprint))
                            .font(.custom("RobotoSlab-Regular", size: 16))
                    }
                    .padding(.bottom, 5)
                    
                    ProgressView(value: userCarbonFootprint, total: 6.7)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text("Türkiye")
                            .font(.custom("RobotoSlab-Regular", size: 16))
                        Spacer()
                        Text("6.2 Tons")
                            .font(.custom("RobotoSlab-Regular", size: 16))
                    }
                    .padding(.bottom, 5)
                    
                    ProgressView(value: 6.2, total: 6.2)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.bottom, 10)
                    
                    HStack {
                        Text("Dünya")
                            .font(.custom("RobotoSlab-Regular", size: 16))
                        Spacer()
                        Text("4.5 Tons")
                            .font(.custom("RobotoSlab-Regular", size: 16))
                    }
                    .padding(.bottom, 5)
                    
                    ProgressView(value: 4.5, total: 6.2)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                VStack {
                    Button(action: {
                        // Edit footprint action
                    }) {
                        HStack {
                            // Button content
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        // Restart calculator action
                        viewModel.kisiSayisi = ""
                        viewModel.elektrik = ""
                        viewModel.su = ""
                        viewModel.dogalgaz = ""
                        viewModel.kömür = ""
                        viewModel.benzin = ""
                        viewModel.motorin = ""
                        viewModel.lpg = ""
                
                        viewModel.tonCo2 = ""
                        
                        viewModel.carbonFootprint = 0.0 // Hesaplamayı sıfırlamak için
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text("Cevaplarımı sil ve yeniden hesapla")
                                .font(.custom("RobotoSlab-Regular", size: 16))
                        }
                    }
                    .padding(.bottom, 150)
                }
                
                Spacer()
                
                VStack {
                    Text("Footprint calculation powered by")
                        .font(.custom("RobotoSlab-Regular", size: 16))
                    Image("g")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                }
                .padding(.bottom, 20)
            }
            .padding()
            .onAppear{
                fetchUserCarbonFootprint()
            }
        }
    }
    
    func fetchUserCarbonFootprint() {
        // FirebaseManager örneği oluştur
        let firebaseManager = FirebaseManager()
        
        // Auth ile kullanıcı UID'sini al
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            print("Hata: Kullanıcı UID'si alınamadı")
            return
        }
        
        // Firestore'dan kullanıcının verilerini çek
        firebaseManager.firestore.collection("users").document(currentUserUID).getDocument { document, error in
            if let error = error {
                print("Hata: Kullanıcı verileri çekilemedi - \(error.localizedDescription)")
                return
            }
            
            // Kullanıcı verileri başarıyla çekildiyse
            if let document = document, document.exists {
          
                if let userData = document.data() {
                  
                    print("Alınan Kullanıcı Verileri:", userData)
                    
                  
                    if let elektrik = userData["elektrik"] as? Int,
                       let su = userData["su"] as? Int,
                       let dogalgaz = userData["dogalgaz"] as? Int,
                       let komur = userData["komur"] as? Int,
                       let benzin = userData["benzin"] as? Int,
                       
                       let motorin = userData["motorin"] as? Int,
                       let lpg = userData["lpg"] as? Int,
                       let otobus = userData["otobus"] as? Int,
                       let metro = userData["metro"] as? Int,
                       let tren = userData["tren"] as? Int,
                       
                       let tramvay = userData["tramvay"] as? Int,
                       let kırmızıEt = userData["kırmızıEt"] as? Int,
                       let beyazEt = userData["beyazEt"] as? Int,
                       let süt = userData["süt"] as? Int,
                       //let sebze = userData["sebze"] as? Int,
                       //let meyve = userData["meyve"] as? Int,
                       
                    //let kıyafetPamuk = userData["kıyafetPamuk"] as? Int,
                       //let kıyafetPolyester = userData["kıyafetPolyester"] as? Int,
                       let kisiSayisi = userData["kisiSayisi"] as? Int,
                       let tonCo2 = userData["tonCo2"] as? Int{
                   
                       let suDouble = Double(su)
                       let elektrikDouble = Double(elektrik)
                       let dogalgazDouble = Double(dogalgaz)
                       let komurDouble = Double(komur)
                        
                       let benzinDouble = Double(benzin)
                       let motorinDouble = Double(motorin)
                       let lpgDouble = Double(lpg)
                       let otobusDouble = Double(otobus)
                       let metroDouble = Double(metro)
                       let trenDouble = Double(tren)
                       let tramvayDouble = Double(tramvay)
                        
                       let kırmızıEtDouble = Double(kırmızıEt)
                       let beyazEtDouble = Double(beyazEt)
                       let sütDouble = Double(süt)
                        
                       let kisiSayisiDouble = Double(kisiSayisi)
                       let tonCo2Double = Double(tonCo2)
                        print("islem yapildi: ")
                        
                     
                        
                        //aylık hesapları yıllık hesaba çevirme
                        
                        kullanıcıYıllıkSuTüketimi = suDouble * 12.0
                       
                        kullanıcıYıllıkElektrikTüketimi = elektrikDouble * 12.0
                        kullanıcıYıllıkDogalgazTüketimi = dogalgazDouble * 12.0
                        kullanıcıYıllıkKömürTüketimi = komurDouble * 12.0
                        
                        kullanıcıYıllıkBenzinTüketimi = benzinDouble * 12.0
                        kullanıcıYıllıkLpgTüketimi = lpgDouble * 12.0
                        kullanıcıYıllıkMotorinTüketimi = motorinDouble * 12.0
                        
                        //haftalık hesapları yıllık hesaba çevirme
                        kullanıcıYıllıkOtobüsKullanımı = otobusDouble * 52.0
                        kullanıcıkYıllıkMetroKullanımı = metroDouble * 52.0
                        kullanıcıYıllıkTramvayKullanımı = tramvayDouble * 52.0
                        kullanıcıYıllıkTrenKullanımı = trenDouble * 52.0
                        kullanıcıYıllıkKırmızıEtTüketimi = kırmızıEtDouble * 52.0
                        kullanıcıYıllıkBeyazEtTüketimi = beyazEtDouble * 52.0
                        kullanıcıYıllıkSütTüketimi = sütDouble * 52.0
                        //kullanıcıYıllıkMeyveTüketimi = meyveDouble * 52.0
                        //kullanıcıYıllıkSebzeTüketimi = sebzeDouble * 52.0
                        
                        
                        
                        kullanıcıSuEmisyonu = kullanıcıYıllıkSuTüketimi * suEmisyon
                        kullanıcıElektrikEmisyonu = kullanıcıYıllıkElektrikTüketimi * elektrikEmisyon
                        kullanıcıDogalgazEmisyonu = kullanıcıYıllıkDogalgazTüketimi * dogalgazEmisyon
                        kullanıcıKömürEmisyonu = kullanıcıYıllıkKömürTüketimi * kömürEmisyon
                        
                     evEmisyonları = (kullanıcıSuEmisyonu + kullanıcıKömürEmisyonu + kullanıcıDogalgazEmisyonu + kullanıcıElektrikEmisyonu) / kisiSayisiDouble
                        
                    kullanıcıBenzinEmisyonu = kullanıcıYıllıkBenzinTüketimi * benzinEmisyon
                      kullanıcıLpgEmisyonu = kullanıcıYıllıkLpgTüketimi * lpgEmisyon
                      kullanıcıMotorinEmisyonu = kullanıcıYıllıkMotorinTüketimi * motorinEmisyon
                       kullanıcıOtobüsEmisyonu = kullanıcıYıllıkOtobüsKullanımı * otobüsEmisyon
                         kullanıcıMetroEmisyonu = kullanıcıkYıllıkMetroKullanımı * metroEmisyon
                         kullanıcıTrenEmisyonu = kullanıcıYıllıkTrenKullanımı * trenEmisyon
                         kullanıcıTramvayEmisyonu = kullanıcıYıllıkTramvayKullanımı * tramvayEmisyon
                                        
                          ulaşımEmisyonları = kullanıcıBenzinEmisyonu + kullanıcıLpgEmisyonu + kullanıcıMotorinEmisyonu + kullanıcıOtobüsEmisyonu + kullanıcıMetroEmisyonu + kullanıcıTrenEmisyonu + kullanıcıTramvayEmisyonu
                        
                        kullanıcıKırmızıEtEmisyonu = kullanıcıYıllıkKırmızıEtTüketimi * kırmızıEtTüketimiEmisyon
                         kullanıcıBeyazEtEmisyonu = kullanıcıYıllıkBeyazEtTüketimi * beyazEtTüketimiEmisyon
                         kullanıcıSütEmisyonu = kullanıcıYıllıkSütTüketimi * sütTüketimiEmisyon
                         kullanıcıSebzeEmisyonu = kullanıcıYıllıkSebzeTüketimi * sebzeTüketimiEmisyon
                         kullanıcıMeyveEmisyonu = kullanıcıYıllıkMeyveTüketimi * meyveTüketimiEmisyon
                                        
                         beslenmeEmisyonları = kullanıcıKırmızıEtEmisyonu + kullanıcıBeyazEtEmisyonu + kullanıcıSütEmisyonu + kullanıcıSebzeEmisyonu + kullanıcıMeyveEmisyonu
                                        
                          //diğerEmisyonlar =  kıyafetPolyesterDouble * kiyafetAlisverisiPolyesterEmisyon
                      
                        userCarbonFootprint =  (evEmisyonları + ulaşımEmisyonları + beslenmeEmisyonları - tonCo2Double) / 1000
                                        
                        
                        print("Kullanıcı elektrik:", elektrik)
                        print("Kullanıcı Karbon Ayak İzi:", userCarbonFootprint)
                        
                    }
                    
                        print("islem yapildi: Kullanıcı verileri bulunamadı veya yok")
                    
                }
                
                else {
                    print("Hata: Kullanıcı verileri bulunamadı veya yok")
                }
                            }
                        }
                    }

                  
                }

                // Önizleme kodunu buradan kaldırabilirsiniz.

#Preview {
    CarbonFootprintResultsView()
}

