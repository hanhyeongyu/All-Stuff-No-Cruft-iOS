//
//  MapView.swift
//  
//
//  Created by 한현규 on 8/26/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
            
    var coordinate : CLLocationCoordinate2D
        
    @AppStorage("MapView.zoom")
    private var zoom: Zoom = .near
    
    enum Zoom: String, CaseIterable, Identifiable {
         case near = "Near"
         case medium = "Medium"
         case far = "Far"


         var id: Zoom {
             return self
         }
     }
    
    var delta: CLLocationDegrees {
           switch zoom {
           case .near: return 0.02
           case .medium: return 0.2
           case .far: return 2
           }
       }
    
    var body: some View {
        Map(position: .constant(.region(region))){
            Marker("", coordinate: coordinate)
        }

    }
    



    
    var region : MKCoordinateRegion{
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        )
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        
    
        let coordinate = CLLocationCoordinate2D(
            latitude: 37.49699460099485,
            longitude: 127.07202388832731
        )
        MapView(coordinate: coordinate)
    }
}
