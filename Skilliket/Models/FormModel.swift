//
//  FormModel.swift
//  Skilliket
//
//  Created by Nicole  on 06/10/24.
//

import Foundation
import UIKit

protocol FormItem {
    var id: UUID { get }
}

protocol FormSectionItem{
    var id: UUID { get }
    var items: [FormComponent] {get }
    init(items: [FormComponent])
}

//Section Component
final class FormSectionComponent: FormSectionItem, Hashable{ //final because we don't want to subclass this
    var id: UUID = UUID()
    var items: [FormComponent] //so that it can be dynamic and change it whenever needed
    
    init(items: [FormComponent]) {
        self.items = items
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    static func == (left: FormSectionComponent, right: FormSectionComponent) -> Bool{
        left.id == right.id
    }
    
}

//Form Component

class FormComponent: FormItem, Hashable{
    var id: UUID = UUID()
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    static func == (left: FormComponent, right: FormComponent) -> Bool{
        left.id == right.id
    }
    
}

//Text Component

final class TextFormComponent: FormComponent{
    let placeholder: String
    let keyboardType: UIKeyboardType
    let fontColor: UIColor
    
    init(placeholder: String, keyboardType: UIKeyboardType = .default, fontColor: UIColor) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.fontColor = fontColor
    }
}

//Time Component

final class TimeFormComponent: FormComponent{
    let mode: UIDatePicker.Mode
    
    init(mode: UIDatePicker.Mode) {
        self.mode = mode
    }
}

//Date Component

final class DateFormComponent: FormComponent{
    let mode: UIDatePicker.Mode //the mode we want for our date
    
    init(mode: UIDatePicker.Mode) {
        self.mode = mode
    }
}

//Button Component

final class ButtonFormComponent: FormComponent{
    let title: String
    let top: CGFloat
    
    init(title: String, top: CGFloat) {
        self.title = title
        self.top = top
    }
}

//TexBox Component

final class TextBoxFormComponent: FormComponent{
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    
    init(placeholder: String, keyboardType: UIKeyboardType) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
}

//Label Component

final class LabelFormComponent: FormComponent{
    let text: String
    let font: UIFont
    let textColor: UIColor
    
    init(text: String, font: UIFont, textColor: UIColor = .black) {
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}

//Drop Down
final class DropDownFormComponent: FormComponent{
    let items: [String]
    var selectedItem: String?
    init(items: [String], selectedItem: String? = nil) {
        self.items = items
        self.selectedItem = selectedItem
    }
}

//Small Button

final class SmallButtonFormComponent: FormComponent{
    let title: String
    init(title: String) {
        self.title = title
    }
    
}
                                    
extension UICollectionViewCell{
    static var cellId: String{
        String(describing: self)
    }
        
    func removeViews(){
        contentView.subviews.forEach {$0.removeFromSuperview()}
    }
}


