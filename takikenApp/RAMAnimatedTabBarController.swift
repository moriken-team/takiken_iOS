//  AnimationTabBarController.swift
//
// Copyright (c) 11/10/14 Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class RAMAnimatedTabBarItem: UITabBarItem {

    @IBOutlet weak var animation: RAMItemAnimation!
    @IBInspectable var textColor: UIColor = UIColor.blackColor()

    func playAnimation(icon: UIImageView, textLabel: UILabel) {

        assert(animation != nil, "add animation in UITabBarItem")
        if animation != nil {
            animation.playAnimation(icon, textLabel: textLabel)
        }
    }

    func deselectAnimation(icon: UIImageView, textLabel: UILabel) {
        if animation != nil {
            animation.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
        }
    }

    func selectedState(icon: UIImageView, textLabel: UILabel) {
        if animation != nil {
            animation.selectedState(icon, textLabel: textLabel)
        }
    }
}

class RAMAnimatedTabBarController: UITabBarController {

    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = Array()

// MARK: life circle

    override func viewDidLoad() {
        super.viewDidLoad()

        let containers = createViewContainers()

        createCustomIcons(containers)

        //let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        self.view.layer.shadowOpacity = 0.5
        self.view.layer.shadowRadius = 5.0
        self.view.layer.shadowColor = UIColor.grayColor().CGColor
        
        
    }

// MARK: create methods

    func createCustomIcons(containers : NSDictionary) {

        if let items = tabBar.items {
            let itemsCount = tabBar.items!.count as Int - 1
            var index = 0
            for item in self.tabBar.items as! [RAMAnimatedTabBarItem] {

                assert(item.image != nil, "add image icon in UITabBarItem")

                let container : UIView = containers["container\(itemsCount-index)"] as! UIView
                container.tag = index

                let icon = UIImageView(image: item.image)
                icon.translatesAutoresizingMaskIntoConstraints = false
                icon.tintColor = UIColor.clearColor()

                // text
                let textLabel = UILabel()
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clearColor()
                textLabel.textColor = item.textColor
                textLabel.font = UIFont.systemFontOfSize(10)
                textLabel.textAlignment = NSTextAlignment.Center
                textLabel.translatesAutoresizingMaskIntoConstraints = false

                container.addSubview(icon)
                createConstraints(icon, container: container, size: item.image!.size, yOffset: -5)

                container.addSubview(textLabel)
                let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBar.items!.count) - 5.0
                createConstraints(textLabel, container: container, size: CGSize(width: textLabelWidth , height: 10), yOffset: 16)

                let iconsAndLabels = (icon:icon, textLabel:textLabel)
                iconsView.append(iconsAndLabels)

                if 0 == index { // selected first elemet
                    item.selectedState(icon, textLabel: textLabel)
                }

                item.image = nil
                item.title = ""
                index++
            }
        }
    }

    func createConstraints(view:UIView, container:UIView, size:CGSize, yOffset:CGFloat) {

        let constX = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1,
            constant: 0)
        container.addConstraint(constX)

        let constY = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1,
            constant: yOffset)
        container.addConstraint(constY)

        let constW = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.width)
        view.addConstraint(constW)

        let constH = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.height)
        view.addConstraint(constH)
    }

    func createViewContainers() -> NSDictionary {

        var containersDict = NSMutableDictionary()
        //tabBarの数の取得が上手くいかない。as Int　を消したら上手く行った
        //let itemsCount : Int = tabBar.items!.count as Int - 1
        let itemsCount : Int = tabBar.items!.count - 1

        for index in 0...itemsCount {
            var viewContainer = createViewContainer()
            containersDict.setValue(viewContainer, forKey: "container\(index)")
        }

        var keys = containersDict.allKeys

        var formatString = "H:|-(0)-[container0]"
        for index in 1...itemsCount {
            formatString += "-(0)-[container\(index)(==container0)]"
        }
        formatString += "-(0)-|"
        var  constranints = NSLayoutConstraint.constraintsWithVisualFormat(formatString,
                                                                    options:NSLayoutFormatOptions.DirectionRightToLeft,
                                                                    metrics: nil,
//                                                                  views: containersDict as [NSObject : AnyObject] as [NSObject : AnyObject])
                                                                    views: containersDict as! [String : AnyObject] as [String : AnyObject])


        view.addConstraints(constranints)

        return containersDict
    }

    func createViewContainer() -> UIView {
        let viewContainer = UIView();
        viewContainer.backgroundColor = UIColor.clearColor() // for test
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewContainer)

        // add gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapHeandler:")
        tapGesture.numberOfTouchesRequired = 1
        viewContainer.addGestureRecognizer(tapGesture)

        // add constrains
        let constY = NSLayoutConstraint(item: viewContainer,
                                   attribute: NSLayoutAttribute.Bottom,
                                   relatedBy: NSLayoutRelation.Equal,
                                      toItem: view,
                                   attribute: NSLayoutAttribute.Bottom,
                                  multiplier: 1,
                                    constant: 0)

        view.addConstraint(constY)

        let constH = NSLayoutConstraint(item: viewContainer,
                                   attribute: NSLayoutAttribute.Height,
                                   relatedBy: NSLayoutRelation.Equal,
                                      toItem: nil,
                                   attribute: NSLayoutAttribute.NotAnAttribute,
                                  multiplier: 1,
                                    constant: tabBar.frame.size.height)
        viewContainer.addConstraint(constH)

        return viewContainer
    }

// MARK: actions

    func tapHeandler(gesture:UIGestureRecognizer) {

        let items = tabBar.items as! [RAMAnimatedTabBarItem]

        let currentIndex = gesture.view!.tag
        if selectedIndex != currentIndex {
            let animationItem : RAMAnimatedTabBarItem = items[currentIndex]
            let icon = iconsView[currentIndex].icon
            let textLabel = iconsView[currentIndex].textLabel
            animationItem.playAnimation(icon, textLabel: textLabel)

            let deselelectIcon = iconsView[selectedIndex].icon
            let deselelectTextLabel = iconsView[selectedIndex].textLabel
            let deselectItem = items[selectedIndex]
            deselectItem.deselectAnimation(deselelectIcon, textLabel: deselelectTextLabel)

            selectedIndex = gesture.view!.tag
        }
    }
}


