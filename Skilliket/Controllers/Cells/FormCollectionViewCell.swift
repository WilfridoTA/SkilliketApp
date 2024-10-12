//
//  FormCollectionViewCell.swift
//  Skilliket
//
//  Created by Nicole  on 06/10/24.
//

import UIKit

final class DropDownCollectionViewCell: UICollectionViewCell {
    
    // MARK: DropDownButton
    private lazy var dropdownButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        btn.layer.borderColor = UIColor.systemGray5.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(showDropdown), for: .touchUpInside)
        return btn
    }()
    
    private var dropdownItems: [String] = []
    var onItemSelected: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func bind(_ item: FormComponent) {
        guard let item = item as? DropDownFormComponent else { return }
        setup(item: item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
    }
}

private extension DropDownCollectionViewCell {
    
    func setupUI() {
        contentView.addSubview(dropdownButton)
        
        NSLayoutConstraint.activate([
            dropdownButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dropdownButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dropdownButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dropdownButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func setup(item: DropDownFormComponent) {
        dropdownItems = item.items
        dropdownButton.setTitle(item.selectedItem ?? "Select an option", for: .normal)
    }
    
    @objc func showDropdown() {
        guard let viewController = findViewController() else { return }
        
        let dropdownVC = DropdownViewController(items: dropdownItems, anchor: dropdownButton)
        dropdownVC.onItemSelected = { [weak self] selectedItem in
            DispatchQueue.main.async {
                self?.dropdownButton.setTitle(selectedItem, for: .normal)
                self?.onItemSelected?(selectedItem)
            }
        }
        
        viewController.presentDropdown(dropdownVC)
    }
    
    func findViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while let responder = nextResponder {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            nextResponder = responder.next
        }
        return nil
    }
}

final class DropdownViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var dropdownItems: [String]
    private var anchorView: UIView
    
    var onItemSelected: ((String) -> Void)?
    
    private lazy var dropdownMenu: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.borderColor = UIColor.systemGray5.cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 8
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownCell")
        return tableView
    }()
    
    // Initialize with items and the view that anchors it
    init(items: [String], anchor: UIView) {
        self.dropdownItems = items
        self.anchorView = anchor
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3) // semi-transparent background
        
        // Add tap gesture to dismiss when tapping outside the dropdown
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDropdown))
        view.addGestureRecognizer(tapGesture)
        
        setupDropdownMenu()
    }
    
    private func setupDropdownMenu() {
        view.addSubview(dropdownMenu)
        
        // Get the frame of the anchor view (dropdown button) in the window
        let anchorFrame = anchorView.convert(anchorView.bounds, to: view)
        
        NSLayoutConstraint.activate([
            dropdownMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: anchorFrame.maxY + 5),
            dropdownMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: anchorFrame.minX),
            dropdownMenu.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: anchorFrame.maxX),
            dropdownMenu.heightAnchor.constraint(equalToConstant: CGFloat(dropdownItems.count) * 44) // Adjust based on number of items
        ])
    }
    
    @objc private func dismissDropdown() {
        dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
        })
    }
    
    // MARK: - TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropdownItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath)
        cell.textLabel?.text = dropdownItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = dropdownItems[indexPath.row]
        onItemSelected?(selectedItem)  // Notify that an item was selected
        dismissDropdown()  // Dismiss the dropdown after selection
    }
}

private extension UIViewController {
    func presentDropdown(_ dropdownVC: DropdownViewController) {
        self.present(dropdownVC, animated: true, completion: nil)
    }
}


final class FormButtonCollectionViewCell: UICollectionViewCell {
    
    // MARK: BUTTON DESIGN
    
    private lazy var actionButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.layer.cornerRadius = 20
        btn.layer.cornerCurve = .circular
        return btn
    } ()
    
    func bind(_ item: FormComponent){
        guard let item = item as? ButtonFormComponent else { return }
        setup(item: item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
    }
}
        

private extension FormButtonCollectionViewCell{
    func setup(item: ButtonFormComponent){
        
        actionButton.setTitle(item.title, for: .normal)
        
        contentView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: 40),
            actionButton.widthAnchor.constraint(equalToConstant: 150),
            actionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            //actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            //actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actionButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: item.top),  // Adjust the constant to move it further down
            //actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
    }
}

final class FormSmallButtonCollectionViewCell: UICollectionViewCell{
    private lazy var actionButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 20 // Small and round button
        btn.layer.cornerCurve = .circular
        return btn
    } ()
    
    private lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    func bind(_ item: FormComponent){
        guard let item = item as? SmallButtonFormComponent else { return }
        setup(item: item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
    }
}

private extension FormSmallButtonCollectionViewCell {
    func setup(item: SmallButtonFormComponent) {
        
        actionButton.setTitle("+", for: .normal)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        actionButton.contentHorizontalAlignment = .center
        actionButton.contentVerticalAlignment = .center
        buttonLabel.text = item.title
        
        
        contentView.addSubview(actionButton)
        contentView.addSubview(buttonLabel)
        
        NSLayoutConstraint.activate([
            // Action Button Constraints
            actionButton.heightAnchor.constraint(equalToConstant: 40),
            actionButton.widthAnchor.constraint(equalToConstant: 40),
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10), // Align button to the left
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), // Center button vertically
            actionButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 260),
            
            // Button Label Constraints
            buttonLabel.leadingAnchor.constraint(equalTo: actionButton.trailingAnchor, constant: 10), // Space between button and label
            buttonLabel.centerYAnchor.constraint(equalTo: actionButton.centerYAnchor), // Align label to the button vertically
            buttonLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}

class CustomHeightTextField: UITextField {
    var customHeight: CGFloat = 300  // Default height
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        return CGSize(width: originalContentSize.width, height: customHeight)
    }
}

final class FormTextBoxCollectionViewCell: UICollectionViewCell{
    // MARK: TEXT BOX
    
    private lazy var textBox: CustomHeightTextField = {
        let textBox = CustomHeightTextField()
        textBox.customHeight = 300
        textBox.translatesAutoresizingMaskIntoConstraints = false
        textBox.layer.cornerRadius = 12
        textBox.layer.borderWidth = 1
        textBox.layer.borderColor = UIColor.systemGray5.cgColor
        return textBox
    }()
    
    func bind(_ item: FormComponent){
        guard let item = item as? TextBoxFormComponent else { return }
        setup(item: item)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
    }
    
}

private extension FormTextBoxCollectionViewCell {
    func setup(item: TextBoxFormComponent){
        textBox.placeholder = " \(item.placeholder)"
        textBox.keyboardType = item.keyboardType
        
        contentView.addSubview(textBox)
        
        NSLayoutConstraint.activate([
            //textBox.heightAnchor.constraint(equalToConstant: 44),
            textBox.topAnchor.constraint(equalTo: contentView.topAnchor),
            //textBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

final class FormTextCollectionViewCell: UICollectionViewCell {
    //MARK: TEXT DESIGN
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        return textField
    }()
    
    func bind(_ item: FormComponent){
        guard let item = item as? TextFormComponent else { return }
        setup (item: item)
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        removeViews()
    }
}

private extension FormTextCollectionViewCell {
    func setup(item: TextFormComponent){
        
        textField.keyboardType = item.keyboardType
        textField.placeholder = ""
        textField.textColor = item.fontColor
                textField.attributedPlaceholder = NSAttributedString(
                    string: " ",
                    attributes: [.foregroundColor: item.fontColor]
                )
        
        textField.placeholder = " \(item.placeholder)"
        
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

    // MARK: DATE PICKER

final class FormDateCollectionViewCell: UICollectionViewCell{
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    func bind(_ item: FormComponent){
        guard let item = item as? DateFormComponent else {return}
        setup(item: item)
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        removeViews()
    }
}

private extension FormDateCollectionViewCell{
    func setup(item: DateFormComponent){
        datePicker.datePickerMode = .date
        contentView.addSubview(datePicker)
        datePicker.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            //datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            datePicker.widthAnchor.constraint(equalToConstant: 103)
        ])
    }
}

// MARK: TIME PICKER

final class FormTimeCollectionViewCell: UICollectionViewCell{
private lazy var timePicker: UIDatePicker = {
    let timePicker = UIDatePicker()
    timePicker.translatesAutoresizingMaskIntoConstraints = false
    return timePicker
}()

func bind(_ item: FormComponent){
    guard let item = item as? TimeFormComponent else {return}
    setup(item: item)
}

override func prepareForReuse(){
    super.prepareForReuse()
    removeViews()
}
}

private extension FormTimeCollectionViewCell{
func setup(item: TimeFormComponent){
    timePicker.datePickerMode = .time
    contentView.addSubview(timePicker)
    timePicker.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    //timePicker.backgroundColor = .black
    
    NSLayoutConstraint.activate([
        timePicker.topAnchor.constraint(equalTo: contentView.topAnchor),
        timePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        timePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //timePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        timePicker.widthAnchor.constraint(equalToConstant: 113)
    ])
}
}

// MARK: LABEL

final class FormLabelCollectionViewCell: UICollectionViewCell{
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    func bind(_ item: FormComponent){
        guard let item = item as? LabelFormComponent else {return}
        setup(item: item)
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        removeViews()
    }
}

private extension FormLabelCollectionViewCell{
    func setup(item: LabelFormComponent){
        label.text = item.text
        label.font = item.font
        label.textColor = item.textColor
        
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
    }
}
    
/*
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


