//
//  Communities.swift
//  Skilliket
//
//  Created by Will on 29/09/24.
//


//ESTE ARCHIVO FUE CREADO PARA PROBAR LAS FUNCIONALIDADES DE ADMIN

import Foundation

//Info para la tabla
struct Communities {
    let name:String
    let location:String
    let image:String
    let projects:[Projects] //Cada comunidad puede tener un arreglo de proyectos
}

struct Projects{
    let projectName:String
    let projectDescription:String
    let projImage:String
}

//Arreglo vacio de Communities
let communitiesArr:[Communities] = [
    Communities(
        name: "Bosque de chapultepec",
        location: "CDMX - Norte",
        image: "Chapultepec",
        projects: projectsArr
    )
]


//Areglo  de errores
let projectsArr:[Projects] = [
    Projects(projectName: "Proyecto A",
             projectDescription: "Este es un proyecto de prueba que no tiene fines informativos y que tampoco aporta ninguna funcionalidad más que mostrar un montón de texto cuya única función es acaparar espacio para que se muestren ‘…’ en el preview de la info; se tendrá que revisar cuantas lineas se deben mostrar como máximo en cada parte.",
            projImage: "CinetecaChapultepec")
]
