import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct DragRelocateDelegate: DropDelegate {
    @Binding var listData: [Ball]
    @Binding var current: Ball?
    @Binding var isDragging: Bool
    
    let item: Ball
    
    var onDrop: (Int, Int) -> ()
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        if !isDragging { isDragging = true }
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        if item.id != current?.id {
            let from = listData.firstIndex(where: { current?.id == $0.id})!
            let to = listData.firstIndex(where: { item.id == $0.id})!
            
            if listData[to].id != current!.id {
                onDrop(from, to)
            }
        }
        current = nil
        isDragging = false
        return true
    }
}
