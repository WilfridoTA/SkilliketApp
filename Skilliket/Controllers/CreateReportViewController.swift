//
//  CreateReportViewController.swift
//  Skilliket
//
//  Created by Nicole  on 08/10/24.
//

import Foundation
import UIKit

class CreateReportViewController: UIViewController{
    private lazy var formContentBuilder = CreateReport()
    private lazy var formCompLayout = FormCompositionalLayout()
    private lazy var dataSource = makeDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: formCompLayout.layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.cellId)
        cv.register(FormButtonCollectionViewCell.self, forCellWithReuseIdentifier: FormButtonCollectionViewCell.cellId)
        cv.register(FormTextCollectionViewCell.self, forCellWithReuseIdentifier: FormTextCollectionViewCell.cellId)
        cv.register(FormDateCollectionViewCell.self, forCellWithReuseIdentifier: FormDateCollectionViewCell.cellId)
        cv.register(FormTextBoxCollectionViewCell.self, forCellWithReuseIdentifier: FormTextBoxCollectionViewCell.cellId)
        cv.register(FormLabelCollectionViewCell.self, forCellWithReuseIdentifier: FormLabelCollectionViewCell.cellId)
        cv.register(FormTimeCollectionViewCell.self, forCellWithReuseIdentifier: FormTimeCollectionViewCell.cellId)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        updateDateSource()
    }
}

private extension CreateReportViewController {
    func setup(){
        
        view.backgroundColor = .white
        collectionView.dataSource = dataSource
        
        //Layout
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<FormSectionComponent, FormComponent> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case is TextFormComponent:
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormTextCollectionViewCell.cellId,
                                                              for: indexPath) as! FormTextCollectionViewCell
                cell.bind(item)
                return cell
                
            case is DateFormComponent:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormDateCollectionViewCell.cellId,
                                                              for: indexPath) as! FormDateCollectionViewCell
                cell.bind(item)
                return cell
                
            case is ButtonFormComponent:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormButtonCollectionViewCell.cellId,
                                                              for: indexPath) as! FormButtonCollectionViewCell
                cell.bind(item)
                return cell
            
            case is TextBoxFormComponent:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormTextBoxCollectionViewCell.cellId,
                                                              for: indexPath) as! FormTextBoxCollectionViewCell
                cell.bind(item)
                return cell
                
            case is LabelFormComponent:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormLabelCollectionViewCell.cellId,
                                                              for: indexPath) as! FormLabelCollectionViewCell
                cell.bind(item)
                return cell
                
            case is TimeFormComponent:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FormTimeCollectionViewCell.cellId,
                                                              for: indexPath) as! FormTimeCollectionViewCell
                cell.bind(item)
                return cell
                
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.cellId, for: indexPath)
                return cell
            }
            
            
        }
    }
    func updateDateSource(animated: Bool = false){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            var snapshot = NSDiffableDataSourceSnapshot<FormSectionComponent, FormComponent>()
            let formSections = self.formContentBuilder.content
            snapshot.appendSections(formSections)
            formSections.forEach{snapshot.appendItems($0.items, toSection: $0)}
            self.dataSource.apply(snapshot, animatingDifferences: animated)
        }
    }
}

final class CreateReport{
    
    var content: [FormSectionComponent]{
        return [
            FormSectionComponent(items: [ //the dynamic array
                LabelFormComponent(text: "Type of Content", font: UIFont.systemFont(ofSize: 18, weight: .bold), textColor: .black),
                TextFormComponent(placeholder: "Report", fontColor: .black),
                DateFormComponent(mode: .date),
                TimeFormComponent(mode: .time),
                TextBoxFormComponent(placeholder: "Insert Text", keyboardType: .default),
                ButtonFormComponent(title: "Post", top: 250)
                
            ])
        ]
    }
}

