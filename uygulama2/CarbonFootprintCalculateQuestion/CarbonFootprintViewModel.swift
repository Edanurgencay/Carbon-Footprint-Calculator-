import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine




class CarbonFootprintViewModel: ObservableObject {
    @Published var kisiSayisi: String = ""
    @Published var elektrik: String = ""
    @Published var su: String = ""
    @Published var dogalgaz: String = ""
    @Published var kömür: String = ""
    @Published var benzin: String = ""
    @Published var motorin: String = ""
    @Published var lpg: String = ""
    @Published var otobus: String = ""
    @Published var metro: String = ""
    @Published var tren: String = ""
    @Published var tramvay: String = ""
    @Published var kırmızıEt: String = ""
    @Published var beyazEt: String = ""
    @Published var süt: String = ""
    @Published var sebze: String = ""
    @Published var meyve: String = ""
    @Published var kıyafetPamuk: String = ""
    @Published var kıyafetPolyester: String = ""
    @Published var tonCo2: String = ""
    @Published var carbonFootprint: Double = 0.0
  
    
}
