//
//  MainChartsFile.swift
//  Skilliket
//
//  Created by Nicole  on 12/10/24.
//

import SwiftUI

//@main Establece como pantalla inicial al abrir la app

struct MainChartsFile: App {
    var body: some Scene {
        WindowGroup{
            //Revisar la plataforma en la que se esta ejecutando la aplicación
            #if os(iOS)
            ContentView()
            #else
            MacContentView()
            #endif
        }
    }
    
}
