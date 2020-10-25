//
//  UIHostingController.swift
//  Kartrider
//
//  Created by 현진 on 2020/10/25.
//

import SwiftUI

class LocalStatusBarStyle { // style proxy to be stored in Environment
    fileprivate var getter: () -> UIStatusBarStyle = { .default }
    fileprivate var setter: (UIStatusBarStyle) -> Void = {_ in}

    var currentStyle: UIStatusBarStyle {
        get { self.getter() }
        set { self.setter(newValue) }
    }
}

// Custom Environment key, as it is set once, it can be accessed from anywhere
// of SwiftUI view hierarchy
struct LocalStatusBarStyleKey: EnvironmentKey {
    static let defaultValue: LocalStatusBarStyle = LocalStatusBarStyle()
}

extension EnvironmentValues { // Environment key path variable
    var localStatusBarStyle: LocalStatusBarStyle {
        get {
            return self[LocalStatusBarStyleKey.self]
        }
    }
}

// Custom hosting controller that update status bar style
class UIHostingController<Content>: SwiftUI.UIHostingController<Content> where Content: View {
    private var internalStyle = UIStatusBarStyle.default

    @objc override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            internalStyle
        }
        set {
            internalStyle = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    override init(rootView: Content) {
        super.init(rootView:rootView)

        LocalStatusBarStyleKey.defaultValue.getter = { self.preferredStatusBarStyle }
        LocalStatusBarStyleKey.defaultValue.setter = { self.preferredStatusBarStyle = $0 }
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
