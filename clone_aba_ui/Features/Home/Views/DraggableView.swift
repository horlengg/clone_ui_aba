//
//  DraggableView.swift
//  clone_aba_ui
//
//  Created by Houleng Ly on 21/12/25.
//

import SwiftUI
import Combine


struct DraggableView<T, Content: View>: View {
    
    let config: MenuGridDisplayerConfig
    @State var draggableMenuList: [DraggableMenuItem<T>]
    @State var draggableMenu : DraggableMenuItem<T>?
    @State var screenSize : CGSize = CGSize(width: 0, height: 0)
    @State var firstTimeRender = true
    let transitionInSecond : Double
    @State var avoidSwipeItem = false

    let content: (T) -> Content
    
    init(
        menuList: [T],
        config: MenuGridDisplayerConfig,
        transitionInSecond: Double,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.config = config
        self._draggableMenuList = State(initialValue: Self.getDraggableMenuList(menuList))
        self.content = content
        self.transitionInSecond = transitionInSecond
    }
    
    var body: some View {

        print("MenuGridItemBuilder build...")

        return GeometryReader {geometry in

            ZStack {

                ForEach(draggableMenuList) { menu in
                    buildMenuItemView(menu: menu,isDisableAnimation: firstTimeRender)
                    .opacity(draggableMenu?.id == menu.id ? 0 : 1)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if draggableMenu == nil {
                                    draggableMenu = menu
                                }else {
                                    draggableMenu!.position = value.location
                                    setSwipeMenuPosition()
                                }
                            }
                            .onEnded {value in
                                draggableMenu = nil
                            }
                    )
                        
                }

                if draggableMenu != nil {
                    buildMenuItemView(menu: draggableMenu!,isDisableAnimation : true)
                }

                
            }
            .task {
                screenSize = geometry.size
                if !draggableMenuList.isEmpty {
                    setMenuPosition()
                }
            }

        }
        .frame(maxWidth: .infinity, maxHeight: calculateTotalMenuHeight())
    }
    
    @ViewBuilder
    func buildMenuItemView(menu: DraggableMenuItem<T>,isDisableAnimation : Bool = false) -> some View {
        
            VStack {
                content(menu.data)
            }
            .frame(width: menu.size.width, height: menu.size.height)
            .position(menu.position)
            .animation(isDisableAnimation ? nil : .linear(duration: transitionInSecond),value: menu.position)
    }
    
    static func getDraggableMenuList(_ menuList: [T]) -> [DraggableMenuItem<T>] {
        var index = 0
        var result: [DraggableMenuItem<T>] = []
        for menu in menuList {
            result.append(
                DraggableMenuItem(
                    id: index,
                    data: menu,
                    position: CGPoint(x: 0, y: 0),
                    size: CGSize(width: 0, height: 0)
                )
            )
            index = index + 1
        }
        return result
    }
    
    func calculateTotalMenuHeight() -> CGFloat {
        guard let lastMenu = draggableMenuList.last else {
            return 0
        }
        return CGFloat( lastMenu.position.y + lastMenu.size.height / 2 + 5 )
    }


    func setMenuPosition() {

        print("setMenuPosition()...");

        var rowCount: Int = 0
        var colCount: Int = 0
        let totalSpacing = config.columnSpacing * (config.columns - 1)
        let availableWidth = Int(screenSize.width) - totalSpacing
        let calculatedMenuWidth = availableWidth / config.columns
        let itemHeight = Int(Double(calculatedMenuWidth) / config.aspectRatio)
        
        print("screenSize : \(screenSize.width)")
        print("totalSpacing : \(totalSpacing)")
        print("availableWidth : \(availableWidth)")
        print("calculatedMenuWidth : \(calculatedMenuWidth)")
        print("Item Aspect Ratio : \(calculatedMenuWidth)/\(itemHeight)")
        
    
        

        for i in 0..<draggableMenuList.count {
            if colCount >= config.columns {
                colCount = 0
                rowCount += 1
            }
            
            let colRemain = (i % config.columns)
            let x = colRemain * config.columnSpacing + colRemain * calculatedMenuWidth + (calculatedMenuWidth / 2)
            
            let y = (rowCount * config.rowSpacing ) + (rowCount * itemHeight) + (itemHeight / 2)

            draggableMenuList[i].position = CGPoint(x: x, y: y + 5)
            draggableMenuList[i].size = CGSize(width: calculatedMenuWidth, height: itemHeight)

            colCount += 1
        }

        if firstTimeRender {

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                firstTimeRender = false
            }

        }
    }
    
    func isPositionMatch(searchMenu : DraggableMenuItem<T>,referenceMenu : DraggableMenuItem<T>) -> Bool {

        let threshold:CGFloat = 0.3

        let dx = abs(searchMenu.position.x - referenceMenu.position.x) / referenceMenu.position.x
        let dy = abs(searchMenu.position.y - referenceMenu.position.y) / referenceMenu.position.y

        let isMatch = dx < threshold && dy < threshold

        return isMatch
    }

    func setSwipeMenuPosition() {
        
        if avoidSwipeItem {
            return
        }
            
        guard let draggableMenu = draggableMenu else { return }

        guard let targetIndex = draggableMenuList.firstIndex(
            where: {
                $0.id != draggableMenu.id && isPositionMatch(searchMenu: draggableMenu, referenceMenu: $0)
            }
        ) else { return }

        guard let currentIndex = draggableMenuList.firstIndex(
            where: { $0.id == draggableMenu.id }
        ) else { return }

        guard targetIndex != currentIndex else { return }
        
        avoidSwipeItem = true

        let item = draggableMenuList.remove(at: currentIndex)
        draggableMenuList.insert(item, at: targetIndex)

        setMenuPosition()
        requestHapticDeviceFeedback()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + transitionInSecond + 0.1) {
            avoidSwipeItem = false
        }
        
        
    }
    func requestHapticDeviceFeedback() {
        if #available(iOS 10.0, *) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
}

struct DraggableMenuItem<T> : Identifiable {
    var id : Int
    var data : T
    var position: CGPoint
    var size: CGSize
}

struct MenuGridDisplayerConfig {
    let columns : Int
    let columnSpacing : Int
    let rowSpacing : Int
    let aspectRatio : Double
}
