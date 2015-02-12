//
//  TableViewController.swift
//  ThunderTable
//
//  Created by Simon Mitchell on 07/02/2015.
//  Copyright (c) 2015 threesidedcube. All rights reserved.
//

import UIKit

/**
`TableViewController` is a subclass of UIViewController that provides convenient methods for quick creation of a `UITableViewController`. This class inherits from `UIViewController` because it provides easier access and cusomisation opportunities than subclassing UITableViewController.

Although a `TableViewController` can be used with the usual delegate and datasource methods of a `UITableViewController` it is recommended that you use the following classes;

- `TableRow` for rows
- `TableSection` for sections

*/

public class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, TableInputViewCellDelegate {
    
    //MARK: - Initialization
    
    ///---------------------------------------------------------------------------------------
    /// @name Initializing a TSCTableView Object
    ///---------------------------------------------------------------------------------------
    
    /**
    Initializes the `tableView`
    @param style The `UITableViewStyle` to initialise the `tableView` with.
    */
    public init(style: UITableViewStyle) {
        
        self.dataSource = []
        self.registeredCellClasses = []
        self.viewHasAppeared = false
        self.dynamicHeightCells = Dictionary()
        self.shouldMakeFirstTextFieldFirstResponder = true
        self.tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: style)
        self.shouldDisplayAlphabeticalSectionIndexTitles = false
        self.shouldDisplaySeparatorsOnCells = true
        self.refreshEnabled = false
        self.refreshing = false
        self.missingRequiredInputRows = []
        self.cellOverrides = Dictionary()
        
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        self.dataSource = []
        self.registeredCellClasses = []
        self.viewHasAppeared = false
        self.dynamicHeightCells = Dictionary()
        self.shouldMakeFirstTextFieldFirstResponder = true
        self.tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Grouped)
        self.shouldDisplayAlphabeticalSectionIndexTitles = false
        self.shouldDisplaySeparatorsOnCells = true
        self.refreshEnabled = false
        self.refreshing = false
        self.missingRequiredInputRows = []
        self.cellOverrides = Dictionary()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //MARK: View Lifecycle
    
    private var standardInsets: UIEdgeInsets?
    
    override public func loadView() {
        
        super.loadView()
        self.view = self.tableView
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = true
        self.tableView.separatorStyle = .None
    }
    
    public override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        if let selectedIndexPath: NSIndexPath = self.tableView.indexPathForSelectedRow() {
            self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }
    
    public override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        if !self.viewHasAppeared && self.shouldMakeFirstTextFieldFirstResponder {
            self.makeFirstTextFieldFirstResponder()
        }
        
        if let title = self .title {
            NSNotificationCenter.defaultCenter().postNotificationName("TSCStatEventNotification", object: self, userInfo: ["type":"screen","name":title])
        }
        
        self.viewHasAppeared = true
    }
    
    public override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.viewHasAppeared = true
        self.resignAnyResponders()
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if let insets = self.standardInsets {
            
            self.tableView.contentInset = insets
            self.tableView.scrollIndicatorInsets = insets
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        
        if !isPad() {
            
            self.standardInsets = self.tableView.contentInset
            
            if let userInfo = notification.userInfo {
                
                if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                    
                    let insets = UIEdgeInsetsMake(self.standardInsets!.top, 0.0, keyboardSize.height, 0.0)
                    self.tableView.contentInset = insets
                    self.tableView.scrollIndicatorInsets = insets
                }
            }
        }
    }

    
    //MARK: - Data Source Configuration

    ///---------------------------------------------------------------------------------------
    /// @name Configuring the Data Source
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract An array of TSCTableSection items to be displayed in the view
    @discussion Setting this property will reload the table view with the given sections
    */
    public var dataSource: [TableSectionDataSource] {
        
        didSet {
            
            self.tableView.dataSource = self
            self.tableView.delegate = self
            if (self.viewHasAppeared) {
                
                self.tableView.reloadData()
            }
        }
    }
    
    private func setDataSource(source:[TableSectionDataSource], animated:Bool) {
        
        self.dataSource = source
    }
    
    public var selectedIndexPath: NSIndexPath?
    
    private var registeredCellClasses: [String]
    
    private var viewHasAppeared: Bool
    
    //MARK: - Table View Configuration

    ///---------------------------------------------------------------------------------------
    /// @name Configuring the Table View
    ///---------------------------------------------------------------------------------------
    
    private var dynamicHeightCells: [String : UITableViewCell!]
    
    /**
    @abstract The current table view
    @discussion Use this property for accessing information about the underlying table view
    */
    public var tableView: UITableView
    
    /**
    @abstract Used to enable Alphabetical index titles down the side of a table view by section
    @discussion Each section should have a title set before enabling this property
    */
    public var shouldDisplayAlphabeticalSectionIndexTitles: Bool
    
    /**
    @abstract Enable or disabled seperators between table cells
    */
    public var shouldDisplaySeparatorsOnCells: Bool
    
    /**
    @abstract A boolean value indicating if the `tableView` should automatically make the first text field in the `dataSource` the first responder upon load
    @discussion The default value of this property is `YES`. When set to `YES` the first responder will be set in `viewDidAppear` the first time the view appears.
    */
    public var shouldMakeFirstTextFieldFirstResponder: Bool
    
    //MARK: - UITableViewDataSource methods
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataSource[section].sectionHeader()
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.dataSource[section].sectionFooter()
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].sectionItems().count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tableViewCellClass: AnyClass = self.tableView(tableView, cellClassForIndexPath: indexPath)
        let reuseIdentifier = NSStringFromClass(tableViewCellClass)
        
        if !contains(self.registeredCellClasses, reuseIdentifier) {
            
            self.tableView.registerClass(tableViewCellClass, forCellReuseIdentifier: reuseIdentifier)
            self.registeredCellClasses.append(reuseIdentifier)
        }
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? UITableViewCell
        
        let section = self.dataSource[indexPath.section]
        let row = section.sectionItems()[indexPath.row]
        if cell == nil {
            
            var style: UITableViewCellStyle? = UITableViewCellStyle.Subtitle
            if let rowStyle = row.rowStyle?() {
                if let overrideStyle = UITableViewCellStyle(rawValue: rowStyle) {
                    style = overrideStyle
                }
            }
            cell = UITableViewCell(style: style!, reuseIdentifier: reuseIdentifier)
        }
        
        cell = self.configureCell(cell!, indexPath: indexPath)
        
        return cell!
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let section = self.dataSource[indexPath.section]
        let row = section.sectionItems()[indexPath.row]
        
        let contentViewSize = CGSizeMake(self.tableView.frame.size.width, 9999999999)
        if let size = row.cellHeightConstrainedBy?(contentViewSize) {
            return CGFloat(size)
        } else {
            return self.dynamicCellHeight(indexPath)
        }
    }
    
    public func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if let estimatedHeight = self.dataSource[indexPath.section].sectionItems()[indexPath.row].estimatedCellHeight?() {
            return estimatedHeight
        } else {
            return self.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    //MARK: UITableViewDataSource Helper Methods
    
    private func tableView(tableView: UITableView, cellClassForIndexPath indexPath: NSIndexPath) -> AnyClass {
        
        if let overrideClass: AnyClass = self.cellOverrides["\(indexPath.section)-\(indexPath.row)"] {
            return overrideClass
        }
        
        if let cellClass: AnyClass = self.dataSource[indexPath.section].sectionItems()[indexPath.row].tableViewCellClass() {
            return cellClass
        } else {
            return TableViewCell.self
        }
    }
    
    private func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = self.dataSource[indexPath.section]
        let row = section.sectionItems()[indexPath.row]
        
        cell.detailTextLabel?.text = nil
        cell.textLabel?.text = nil;
        cell.imageView?.image = nil;
        
        // Basic defaults
        if let textColor = row.rowTextColor?() {
            cell.textLabel?.textColor = textColor
        }
        if let rowTitle = row.rowTitle() {
            cell.textLabel?.text = rowTitle
        }
        if let rowSubtitle = row.rowSubtitle?() {
            cell.detailTextLabel?.text = rowSubtitle
        }
        if let rowImageURL = row.rowImageURL?() {
            cell.imageView?.setImageURL(rowImageURL, placeholderImage: row.rowImagePlaceholder?())
        }
        if let rowImage = row.rowImage?() {
            cell.imageView?.image = rowImage
        }
        if let indentation = row.indentationLevel?() {
            cell.indentationLevel = indentation
        }
        
        if self.isIndexPathSelectable(indexPath) {
            
            cell.accessoryType = row.rowShouldDisplaySelectionIndicator?() != nil ? (row.rowShouldDisplaySelectionIndicator!() ? .DisclosureIndicator : .None) : .None
            cell.selectionStyle = row.shouldDisplaySelectionCell?() != nil ? (row.shouldDisplaySelectionCell!() ? .Default : .None) : .None
        } else {
            
            cell.accessoryType = .None
            cell.selectionStyle = .None
        }
        
        if let inputCell = cell as? TableInputViewCell {
            
            inputCell.inputRow = row as? TableInputRowDataSource
            inputCell.delegate = self
        }
        
        if let accessoryType = row.rowAccessoryType?() {
            cell.accessoryType = accessoryType
        }
        
        if let tableCell = cell as? TableViewCell {
            
            tableCell.parentViewController = self
            tableCell.shouldDisplaySeparators = self.shouldDisplaySeparatorsOnCells
            
            if let displaySeparators = row.shouldDisplaySeperators?() {
                tableCell.shouldDisplaySeparators = displaySeparators
            }
        }
        
        return cell
    }
    
    private func dynamicCellHeight(indexPath: NSIndexPath) -> CGFloat {
        
        var cell = self.dequeueDynamicHeightCellWithIndexPath(indexPath)
        self.configureCell(cell, indexPath: indexPath)
        cell.frame = CGRectMake(0, 0, self.view.bounds.size.width - 8, 44)
        cell.layoutSubviews()
        
        var highestView: UIView = UIView(frame: CGRectMake(0, 0, 0, 0))
        var lowestYValue: CGFloat = 0.0
        
        for view: UIView in cell.contentView.subviews as [UIView] {
            
            if CGRectGetMaxY(view.frame) > CGRectGetMaxY(highestView.frame) {
                highestView = view
            }
            
            if view.frame.origin.y < lowestYValue {
                lowestYValue = view.frame.origin.y
            }
        }
        
        var cellHeight: CGFloat = CGRectGetMaxY(highestView.frame) + abs(lowestYValue) + 10.0
        if let padding = self.dataSource[indexPath.section].sectionItems()[indexPath.row].rowPadding?() {
            cellHeight = cellHeight - 10 + padding.bottom
        }
        return ceil(cellHeight)
    }
    
    private func dequeueDynamicHeightCellWithIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellClass: AnyClass = self.tableView(self.tableView, cellClassForIndexPath: indexPath)
        var cell: UITableViewCell
        if let storedCell = self.dynamicHeightCells[NSStringFromClass(cellClass)] {
            cell = storedCell
        } else {
            
            let row = self.dataSource[indexPath.section].sectionItems()[indexPath.row]
            
            var style: UITableViewCellStyle? = UITableViewCellStyle.Subtitle
            if let rowStyle = row.rowStyle?() {
                if let overrideStyle = UITableViewCellStyle(rawValue: rowStyle) {
                    style = overrideStyle
                }
            }
            cell = UITableViewCell(style: style!, reuseIdentifier: NSStringFromClass(cellClass))
        }
        
        return cell
    }
    
    //MARK: - UITableViewDelegate methods
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.isIndexPathSelectable(indexPath) {
            self.handleTableViewSelection(indexPath)
        }
    }
    
    //MARK: - Refresh Methods

    ///---------------------------------------------------------------------------------------
    /// @name Managing Refreshing
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract The refresh control used for "Pull to refresh" on the `tableView`
    @discussion This property will return nil if `refreshEnabled` is set to NO
    */
    public var refreshControl: UIRefreshControl?
    
    /**
    Called when the `refreshControl` changes it's refresh state
    @discussion Override this method in your own class to perform custom tasks when a pull to refresh action is initiated
    */
    public func handleRefresh() {
        
    }
    
    /**
    @abstract A boolean to enable or disabled the `refreshControl` on the `tableView`
    @discussion Use `isRefreshEnabled` to check the state of this boolean
    */
    public var refreshEnabled: Bool {
        
        didSet {
            
            if (self.refreshEnabled) {
                
                self.refreshControl = UIRefreshControl()
                self.refreshControl?.addTarget(self, action: "handleRefresh", forControlEvents:.ValueChanged)
                self.tableView.addSubview(self.refreshControl!)
            } else {
                
                if self.refreshControl?.superview != nil {
                    
                    self.refreshControl!.removeFromSuperview()
                    self.refreshControl = nil
                }
            }
        }
    }
    
    /**
    @abstract A boolean to set the `refreshControl` into or out of the refreshing state
    @discussion Use `isRefreshing` to check the state of this boolean. Setting this property to YES will cause the refresh control to display an animated loading indicator at the top of the `tableView`
    */
    public var refreshing: Bool {
        
        didSet {
            
            if !self.refreshing {
                self.refreshControl?.endRefreshing()
            } else {
                self.refreshControl?.beginRefreshing()
            }
        }
    }
    
    //MARK: - Accessing Input Information
    
    ///---------------------------------------------------------------------------------------
    /// @name Accessing Input Information
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract A dictionary of keys and values populated from the `tableView` when displaying `TSCTableInputRow`'s.
    @discussion The key of each entry is the `inputId` of each `TSCTableInputRow` where the key is it's corresponding `value`
    */
    public var inputDictionary: [String: AnyObject] {
        
        get {
            
            var dictionary = [String: AnyObject]()
            for section: TableSectionDataSource in self.dataSource {
                for row: TableRowDataSource in section.sectionItems() {
                    
                    if let inputRow = row as? TableInputRowDataSource {
                        
                        if let value: AnyObject = inputRow.rowValue() {
                            dictionary[inputRow.rowInputId()] = value
                        } else {
                            dictionary[inputRow.rowInputId()] = NSNull()
                        }
                    }
                }
            }
            
            return dictionary
        }
        
        set {
            
            for section: TableSectionDataSource in self.dataSource {
                for row: TableRowDataSource in section.sectionItems() {
                    
                    if let inputRow = row as? TableInputRowDataSource {
                        
                        inputRow.setValue(newValue[inputRow.rowInputId()])
                    }
                }
            }
        }
    }
    
    //MARK: - Input Validation
    
    ///---------------------------------------------------------------------------------------
    /// @name Managing Input Validation
    ///---------------------------------------------------------------------------------------
    
    /**
    @abstract An array of `TSCTableInputRow`'s that have the `required` property set to YES but have not yet had their input criteria satisfied
    */
    
    public var missingRequiredInputRows: [AnyObject]
    
    //MARK: - Managing Selections
    
    ///---------------------------------------------------------------------------------------
    /// @name Managing Selections
    ///---------------------------------------------------------------------------------------
    
    /**
    Pass an indexPath to this method to determine whether or not the row can be selected.
    @param indexPath The index path to check is selectable
    @discussion This method will return YES when the row has a selection handler or the section it is a part of has a selection handler
    */
    public func canSelect(indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    //MARK: - Overriding
    
    ///---------------------------------------------------------------------------------------
    /// @name Overriding
    ///---------------------------------------------------------------------------------------
    
    /**
    Called when the return key is pressed on the active UITextField
    @discussion Override this method in your own class to perform custom behaviour on the return key
    */
    public func textFieldDidReturn(textField: UITextField) {
        
    }
    
    /**
    Use this method to register a custom cell type for a particular index path.
    */
    public func overrideCell(indexPath: NSIndexPath, cellClass cClass:AnyClass) {
        self.cellOverrides["\(indexPath.section)-\(indexPath.row)"] = cClass
    }
    
    private var cellOverrides: [String: AnyClass]
    
    //MARK: - Helper Methods (Private)
    //MARK: Inputs
    private func resignAnyResponders() {
        
        if let selectedIndexPath: NSIndexPath = self.selectedIndexPath {
            if let cell: UITableViewCell = self.tableView.cellForRowAtIndexPath(selectedIndexPath) {
                cell.setEditing(false, animated: true)
            }
        }
    }
    
    private func makeFirstTextFieldFirstResponder() {
        
        for (indexSection, section: TableSectionDataSource) in enumerate(self.dataSource) {
            
            for (indexRow, row: TableRowDataSource) in enumerate(section.sectionItems()) {
            
                 if row is TableInputRowDataSource {
                    
                    self.handleTableViewSelection(NSIndexPath(forRow: indexRow, inSection: indexSection))
                    return
                }
            }
        }
    }
    
    //MARK: Selection
    private func handleTableViewSelection(indexPath: NSIndexPath) {
        
        let section = self.dataSource[indexPath.section]
        let selectedRow = section.sectionItems()[indexPath.row]
        var selectedCell: UITableViewCell?
        
        self.selectedIndexPath = indexPath
        if let rowSelectionHandler = selectedRow.rowSelectionHandler?() {
            
            selectedCell = self.tableView.cellForRowAtIndexPath(indexPath)
            rowSelectionHandler(row: selectedRow, cell: selectedCell, indexPath: indexPath)
        } else if let sectionSelectionHandler = section.sectionSelectionHandler() {
            
            selectedCell = self.tableView.cellForRowAtIndexPath(indexPath)
            sectionSelectionHandler(row: selectedRow, cell: selectedCell, indexPath:indexPath)
        }
        
        //TODO: make row inputs become first responders and scroll to them
        
        if let inputRow = selectedRow as? TableInputRowDataSource {
            
            if selectedCell == nil {
                selectedCell = self.tableView.cellForRowAtIndexPath(indexPath)
            }
            
            if let checkCell = selectedCell as? TableInputCheckViewCell {
                checkCell.checkView.setOn(!checkCell.checkView.on, animated: true)
            } else {
                self.resignAnyResponders()
            }
            
            if let textFieldCell = selectedCell as? TableInputTextFieldViewCell {
                
                textFieldCell.setEditing(true, animated: true)
                textFieldCell.textField.becomeFirstResponder()
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Middle, animated: false)
            } else if let textViewCell = selectedCell as? TableInputTextViewViewCell {
                
                textViewCell.setEditing(true, animated: true)
                textViewCell.textView.becomeFirstResponder()
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Middle, animated: false)
            } else if let datePickerCell = selectedCell as? TableInputDatePickerViewCell {
                
                datePickerCell.setEditing(true, animated: true)
                datePickerCell.inputView?.becomeFirstResponder()
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Middle, animated: false)
            } else if let pickerCell = selectedCell as? TableInputPickerViewCell {
                
                pickerCell.setEditing(true, animated: true)
                pickerCell.inputView?.becomeFirstResponder()
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Middle, animated: false)
            }
        }
        
        if let staySelected = selectedRow.shouldRemainSelected?() {
            if !staySelected {
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        } else {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    private func isIndexPathSelectable(indexPath: NSIndexPath) -> Bool {
        
        let section = self.dataSource[indexPath.section]
        let row = section.sectionItems()[indexPath.row]
        
        if let rowSelectionHandler = row.rowSelectionHandler?() {
            //TODO: Also return true if is TSCTableInputRowDataSource protocol
            return true
        }
        
        if let sectionSelectionHandler = section.sectionSelectionHandler() {
            return true
        }
        
        return false
    }
    
    //MARK: - Table view cell input delegate
    
    public func tableInputViewCellDidFinish(cell tableViewCell: TableViewCell) {
        
        let selectedRowIndex = -1
        if let inputCell = tableViewCell as? TableInputTextFieldViewCell {
            self.textFieldDidReturn(inputCell.textField)
        }
        
        
    }
}
