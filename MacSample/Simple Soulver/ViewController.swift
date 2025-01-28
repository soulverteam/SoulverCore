//
//  ViewController.swift
//  Simple Soulver
//
//  Created by Zac Cohan on 7/1/2025.
//  Copyright © 2025 Zac Cohan. All rights reserved.
//

import Cocoa
import SoulverCore

class ViewController: NSViewController {
    
    /// Model
    var lineCollection: LineCollection!
    
    /// Views
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var tableView: NSTableView!
    
    /// Controller
    var helper: LineCollectionEditingHelper!
    
    /// Other
    private let scrollViewSynchronizer = ScrollViewSynchronization()
    
    /// View Controller Events
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setup()
        
    }
    
    // MARK: -  Set up the view
    
    /// - Set up our model object (``LineCollection``), and have it match the dummy data
    /// - Set up the helper object (``LineCollectionEditingHelper``) that will update the model whenever the view changes
    /// - Style our view (``NSTextView`` and (``NSTableView``) with spacing, & populate with dummy data
    
    private func setup() {
        
        /// Some default text to start with
        let startingText =
        """
        123 + 456
        789 * 442.5
        """
                                
        /// Set up the model (line collection) with the contents of the text view
        self.lineCollection = LineCollection(multiLineText: startingText, customization: .soulver)
                
        /// Evaluate lines
        self.lineCollection.evaluateAll()
        
        /// Set up the views
        self.setupTableView()
        self.setupTextViewWith(text: startingText)
        
        scrollViewSynchronizer.add(scrollView: self.tableView.enclosingScrollView!)
        
        /// Set up the controller (an object that syncs changes from the text view to the line collection, and reports back which lines have been changed)
        self.helper = LineCollectionEditingHelper(lineCollection: self.lineCollection, textView: self.textView)
    
        /// Apply syntax highlighting to the starting text
        self.syntaxHighlightLinesAt(indexes: self.lineCollection.allIndexes)
        
    }
    
    /// Add some nice vertical spacing between table cells
    private func setupTableView() {
        
        /// Add vertical spacing between cells
        self.tableView.intercellSpacing = NSSize(width: 0.0, height: 7.0)
        
        /// Make sure the table synchonizes scrolling with the text view
        scrollViewSynchronizer.add(scrollView: self.textView.enclosingScrollView!)

    }
    
    /// We style the text view with some nice insets, paragraph spacing and a 12pt system font
    private func setupTextViewWith(text: String) {
        
        /// Looks better with the text container inset from the outer edges
        self.textView.textContainerInset = NSSize(width: 12.0, height: 12.0)
        
        // Create a mutable paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        
        // Set the desired paragraph spacing (in points)
        paragraphStyle.paragraphSpacing = 6.0 // Adjust this value as needed
        
        // Create a font with the desired size
        let font = NSFont.systemFont(ofSize: 15.0)
        
        // Create a dictionary of attributes with the paragraph style and font
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font
        ]
        
        // Apply attributes to the text view's entire string
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        textView.textStorage?.setAttributedString(attributedString)
        
        /// So that newly added text has the same attributes
        textView.typingAttributes = attributes
        
        /// Make sure the text view synchonizes scrolling with the table view
        scrollViewSynchronizer.add(scrollView: self.textView.enclosingScrollView!)
        
    }
    
    // MARK: -  Updating the View
        
    func redrawAllLines() {
        self.tableView.reloadData()
        self.syntaxHighlightLinesAt(indexes: lineCollection.allIndexes)
    }
    
    func redrawLinesAt(indexes: IndexSet) {
        
        /// In other cases we can efficiently update just the indexes that have been evaluated
        self.tableView.reloadData(forRowIndexes: indexes, columnIndexes: IndexSet(integer: 0))

        /// Indexes evaluated is a union of any added lines, and any edited lines
        /// These are incidentaly the indexes that now need to be re-syntax highlighted in the text view
        self.syntaxHighlightLinesAt(indexes: indexes)
    }

}

/// Conform NSTextView to the CalculationTextView protocol by simply returning its string property
/// - Text is fetched from your text view when required by the ``LineCollectionEditingHelper``
extension NSTextView: @retroactive CalculationTextView {
    
    public var text: String {
        return self.string
    }
        
}

// MARK: - Data flow

/// These 4 tasks are the essence of a Soulver-like calcuation view:

/// 1. Capture a proposed edits to the text view and let the helper know which part of the text is changing

/// 2. Allow the edit to happen (and the underlying text to change) and let the helper know. The helper will update the model efficiently, and report back what indexes need reloading in the view

/// 3. Syntax color indexes that changed, and refresh corresponding cells in the table with the new results

/// 4. (Optional) Asynchronously update results in the model of any "dependent" lines (if you support variables), and refresh the cells of those lines too

extension ViewController: NSTextViewDelegate, NSTextDelegate {
    
    func textView(_ textView: NSTextView, shouldChangeTextIn affectedCharRange: NSRange, replacementString: String?) -> Bool {
        
        /// Convert the NSRange to a swift range
        guard let range = Range(affectedCharRange, in: textView.string) else {
            return false
        }
    
        /// Create an edit proposal
        let proposedChange = TextViewEditProposal(ranges: [range], replacements: [replacementString ?? ""])
        
        /// Inform the helper of the pending text content change
        self.helper.beginEdit(with: proposedChange)
        
        /// Permit the change to proceed
        return true
        
    }
    
    func textDidChange(_ notification: Notification) {
        
        /// Inform the helper the edit has finished
        /// It gives us back a diff telling us which lines have changed as a result of this edit
        
        let diff = self.helper.finalizeEdit()
        
        switch diff.lineCountDidChange {
        case true:
            /// If we have a new line count, let's reload data completely to add/remove cells
            self.redrawAllLines()

        case false:
            /// (Most cases): efficiently update only the lines that have changed (this will very often be a single edited line)
            self.redrawLinesAt(indexes: diff.indexesEvaluated)
        }
                        
        /// (Optional) update dependent lines (if you support variables)
        /// - Do this off the main thread because We don't want to slow down typing
        /// - Dependency trees can be potentially large (one line can depend on another line, which can depend on another line, etc)

        Task {
            let dependencies = await self.helper.processDependenciesOn(linesInChange: diff)
            self.redrawLinesAt(indexes: dependencies)
        }
        
    }

}

/// Vanilla NSTableViewDelegate & NSTableViewDataSource implementation
/// - Displays calculation results in a table

extension ViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    @MainActor func numberOfRows(in tableView: NSTableView) -> Int {
        return self.lineCollection.lineCount
    }
    
    @MainActor func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: nil) as! NSTableCellView
        cell.textField?.stringValue = self.lineCollection.lines[row].formattedResult
        return cell
    }

}

// MARK: -  Syntax Highlighting

extension ViewController {
    
    func syntaxHighlightLinesAt(indexes: IndexSet) {
        
        guard !indexes.isEmpty else {
            /// No point beginning editing if the indexes array is empty
            return
        }
        
        textView.textStorage?.beginEditing()
        
        indexes.forEach { lineIndex in
            self.syntaxHighlightLineAt(lineIndex: lineIndex)
        }
        
        textView.textStorage?.endEditing()
        
    }
    
    func syntaxHighlightLineAt(lineIndex: Int) {
  
        guard self.lineCollection.isValidIndex(lineIndex) else {
            assertionFailure("Invalid index specified for highlighting")
            return
        }
        
        guard let parsedExpression = self.lineCollection.lines[lineIndex].parsedExpression else {
            assertionFailure("This line index has not been evaluated yet")
            return
        }
        
        guard let lineRange = self.helper.rangeOfLineAtIndex(lineIndex) else {
            assertionFailure("Couldn't get the line range for this index")
            return
        }
        
        /// First apply a base text color to the entire line
        self.textView.apply(color: .textColor, to: lineRange)
        
        /// Enumerate through "semantic tokens" in the expression, and set a foreground text color for particular tokens
        
        /// - For the purposes of this example, we're just coloring 4 types
        parsedExpression.metadata.semantics.enumerate { semanticToken in
            
            let color: NSColor
            
            switch semanticToken.type {
            case .number:
                /// 123, -50, 0xF21, etc
                color = NSColor.systemBlue
                
            case .operator:
                /// +, –, ÷, *
                color = NSColor.systemRed
                
            case .unit:
                /// km, grams, seconds, etc
                color = NSColor.systemIndigo
                
            case .formSpecifier:
                /// the word "timespan" in "3.5 days as timespan"
                color = NSColor.systemPurple
                
            case .functionName, .parenthesis:
                
                color = NSColor.systemTeal
                
            case .variable:
                /// "lemon" in "lemon = 123"
                color = NSColor.darkGray
                
            default:
                /// There are lots of other semantic token types you can color if you wish, but we're just going to do these for now
                return;
            }
            
            /// Convert the "local" range of the semantic token in the expression to a range in the text
            guard let tokenRangeInText = self.helper.convert(localRange: semanticToken.range, toTextRangeOn: lineIndex) else {
                assertionFailure("Could not get the range in text view for this token: \(semanticToken)")
                return
            }
                        
            /// Apply your desired color to that range
            self.textView.apply(color: color, to: tokenRangeInText)
            
        }
                
    }

}

extension NSTextView {

    /// This is a one liner helper to apply a color to a particular string range
    func apply(color: NSColor, to range: Range<String.Index>) {
        self.layoutManager?.addTemporaryAttribute(.foregroundColor, value: color, forCharacterRange: NSRange(range, in: self.string))
    }

}


// MARK: -  Scroll View Synchronization

/// A helper class to synchronize scrolling between multiple NSScrollViews
fileprivate class ScrollViewSynchronization {
    
    private var scrollViews: [NSScrollView] = []
    
    func add(scrollView: NSScrollView) {
        
            
        let clipView = scrollView.contentView
        clipView.postsBoundsChangedNotifications = true
        notificationCenter.addObserver(self,
                                       selector: #selector(scrollViewContentBoundsDidChange(_:)),
                                       name: NSView.boundsDidChangeNotification,
                                       object: clipView)
        
        
        scrollViews.append(scrollView)
    }
    
    
    @objc func scrollViewContentBoundsDidChange(_ notification: Notification) {

        guard let scrolledClipView = notification.object as? NSClipView else { return }

        for scrollView in scrollViews {
            
            
            let viewToScroll = scrollView.contentView
            
            guard viewToScroll !== scrolledClipView else {
                continue
            }

            
            let currentOffset = viewToScroll.bounds.origin
            var newOffset = currentOffset
            newOffset.y = scrolledClipView.documentVisibleRect.origin.y

            guard newOffset != currentOffset else { return }

            viewToScroll.scroll(to: newOffset)
            
            scrollView.reflectScrolledClipView(viewToScroll)

            
        }
        
    }

    
    lazy var notificationCenter: NotificationCenter = NotificationCenter.default
    
    deinit {
        notificationCenter.removeObserver(self)
    }

    
}
