//
//  GameScene.swift


import SnapKit
import SpriteKit
import GameplayKit

struct GameBoard: Codable {
    let boards: [[Int]]
}

enum GameState {
    case back
    case updateScoreBackEnd
    case noCoints
    case gameBack
}

class GameScene: SKScene {
    
    private var gameBoards: GameBoard?
    private var coints: Int = 0
    private var popupActive: Bool = false
    private var firstSelectedNode: SKSpriteNode?
    private var secondSelectedNode: SKSpriteNode?
    private var winBoard: [[Int]]?
    private var boardsTwo: [[Int]]?
    
    private var dropButton = CustomSKButton(texture: SKTexture(imageNamed: "playBtn"))
    
    private let storage = Memory.shared

    public var resultTransfer: ((GameState) -> Void)?

    
    
    override func didMove(to view: SKView) {
        loadGameBoards()
        loadWinBoard()
        addSettingsScene()
        setupGameSubviews()
        setupButtons()
        
        guard let boardsOne = gameBoards?.boards else {
                   print("Failed to load game boards.")

                   return
               }
        boardsTwo = boardsOne

               // Допустим, мы хотим загрузить первое игровое поле
//        let firstBoard = boardsTwo![0]
               loadBoard(boardsTwo!)
    }

    
    
    private func loadGameBoards() {
           guard let url = Bundle.main.url(forResource: "gameBoards", withExtension: "json") else {
               print("JSON file not found.")
               return
           }
           
           do {
               let data = try Data(contentsOf: url)
               gameBoards = try JSONDecoder().decode(GameBoard.self, from: data)
           } catch {
               print("Error loading or decoding JSON: \(error)")
           }
       }
       
    private func loadWinBoard() {
        guard let url = Bundle.main.url(forResource: "winGame", withExtension: "json") else {
            print("JSON file not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let boards1 = json["boards1"] as? [[[Int]]],
               let firstBoard = boards1.first {
                
                winBoard = firstBoard
                // Mark:winBoard! - Warning
                
                for (rowIndex, row) in winBoard!.enumerated() {
                    for (colIndex, cell) in row.enumerated() {
                        print("winBoard ---- [row - \(rowIndex)], [coll - \(colIndex)] - \(cell)")
                        
                    }
                }
                
            }
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }

    
    private func loadBoard(_ board: [[Int]]) {
        let cellSize = CGSize(width: 50, height: 50)
        let numberOfRows = board.count
        let numberOfColumns = board[0].count
        
        let boardWidth = CGFloat(numberOfColumns) * cellSize.width
        let boardHeight = CGFloat(numberOfRows) * cellSize.height
        
        let startX = (size.width - boardWidth) / 2
        let startY = (size.height - boardHeight) / 2
        
        for (rowIndex, row) in board.enumerated() {
            for (colIndex, cell) in row.enumerated() {
//                print("[row - \(rowIndex)], [coll - \(colIndex)] - \(cell)")

                let position = CGPoint(
                    x: startX + CGFloat(colIndex) * cellSize.width,
                    y: startY + CGFloat(rowIndex) * cellSize.height
                )
                createNode(for: cell, at: position, size: cellSize, row: rowIndex, col: colIndex)
            }
        }
    }

    private func pront() {
        guard let boards = boardsTwo else {
                   print("Failed to load game boards.")
                   return
               }
        print("boardsTwo -- ")

        for (rowIndex, row) in boards.enumerated() {
            for (colIndex, cell) in row.enumerated() {
                print("[row - \(rowIndex)], [coll - \(colIndex)] - \(cell)")
                
            }
        }
    }
//    private func loadBoard(_ board: [[Int]]) {
//          let cellSize = CGSize(width: 50, height: 50)
//          let numberOfRows = board.count
//          let numberOfColumns = board[0].count
//          
//          // Вычисляем размеры игрового поля
//          let boardWidth = CGFloat(numberOfColumns) * cellSize.width
//          let boardHeight = CGFloat(numberOfRows) * cellSize.height
//          
//          // Вычисляем начальную позицию для центровки
//          let startX = (size.width - boardWidth) / 2
//          let startY = (size.height - boardHeight) / 2
//          
//          for (rowIndex, row) in board.enumerated() {
//              for (colIndex, cell) in row.enumerated() {
//                  let position = CGPoint(
//                      x: startX + CGFloat(colIndex) * cellSize.width,
//                      y: startY + CGFloat(rowIndex) * cellSize.height
//                  )
//                  createNode(for: cell, at: position, size: cellSize)
//              }
//          }
//      }
    
    private func createNode(for value: Int, at position: CGPoint, size: CGSize, row: Int, col: Int) {
        let node: SKSpriteNode
        
        switch value {
        case 0:
            node = SKSpriteNode(imageNamed: "node_0")
        case 1:
            node = SKSpriteNode(imageNamed: "node_1")
        case 2:
            node = SKSpriteNode(imageNamed: "node_2")
        case 3:
            node = SKSpriteNode(imageNamed: "node_3")
        case 4:
            node = SKSpriteNode(color: .blue, size: size)
        case 5:
            node = SKSpriteNode(color: .yellow, size: size)
        case 6:
            node = SKSpriteNode(color: .purple, size: size)
        default:
            node = SKSpriteNode(color: .clear, size: size)
        }
        
        node.position = position
        node.anchorPoint = CGPoint(x: 0, y: 0)
        node.name = "draggable"
        addChild(node)
    }

      
//      private func createNode(for value: Int, at position: CGPoint, size: CGSize) {
//          let node: SKSpriteNode
//          
//          switch value {
//          case 0:
//              node = SKSpriteNode(imageNamed: "node_0")
//          case 1:
//              node = SKSpriteNode(imageNamed: "node_1")
//          case 2:
//              node = SKSpriteNode(imageNamed: "node_2")
//          case 3:
//              node = SKSpriteNode(imageNamed: "node_3")
//          case 4:
//              node = SKSpriteNode(color: .blue, size: size)
//          case 5:
//              node = SKSpriteNode(color: .yellow, size: size)
//          case 6:
//              node = SKSpriteNode(color: .purple, size: size)
//
//          default:
//              // По умолчанию пустая ячейка
//              node = SKSpriteNode(color: .clear, size: size)
//          }
//          
//          node.position = position
//          node.anchorPoint = CGPoint(x: 0, y: 0) // Устанавливаем якорную точку в левый нижний угол
//          node.name = "draggable"
//          addChild(node)
//      }
      
    
    private func addSettingsScene() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    }
    
    
    private func setupGameSubviews() {
        setupBackground()
        setupNavigation()
    }
    
    func updateCoinsBalance() {
        
    }
    
    private func setupButtons() {
        
    }
    
    private func setupBackground() {
        let hpNode = SKSpriteNode(imageNamed: "bgStart")
        hpNode.anchorPoint = .init(x: 0, y: 0)
        hpNode.size = .init(width: size.width, height: size.height)
        hpNode.position = CGPoint(x: 0, y: 0)
        hpNode.zPosition = -1
        addChild(hpNode)
    }
    
    
    private func setupNavigation() {
        let backBtn = CustomSKButton(texture: SKTexture(imageNamed: "btnBack"))
        backBtn.size = .init(width: 44, height: 44)
        backBtn.anchorPoint = .init(x: 0, y: 1.0)
        backBtn.position = CGPoint(x: 24, y: size.height - 58.autoSize)
        backBtn.normal = UIImage(named: "btnBack")
        backBtn.zPosition = 50
        backBtn.action = { self.backButtonAction() }
        addChild(backBtn)
        
        let restartBtn = CustomSKButton(texture: SKTexture(imageNamed: "btnRestart"))
        restartBtn.size = .init(width: 44, height: 44)
        restartBtn.anchorPoint = .init(x: 0, y: 1.0)
        restartBtn.position = CGPoint(x: (size.width / 2) - 24, y: size.height - 58.autoSize)
        restartBtn.normal = UIImage(named: "btnRestart")
        restartBtn.zPosition = 50
        restartBtn.action = { self.backButtonAction() }
        addChild(restartBtn)
        
        let rulesBtn = CustomSKButton(texture: SKTexture(imageNamed: "btnRuls"))
        rulesBtn.size = .init(width: 44, height: 44)
        rulesBtn.anchorPoint = .init(x: 0, y: 1.0)
        rulesBtn.position = CGPoint(x: (size.width / 2) + 112, y: size.height - 58.autoSize)
        rulesBtn.normal = UIImage(named: "btnRuls")
        rulesBtn.zPosition = 50
        rulesBtn.action = { self.backButtonAction() }
        addChild(rulesBtn)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        for node in touchedNodes {
            if node.name == "draggable" {
                if firstSelectedNode == nil {
                    firstSelectedNode = node as? SKSpriteNode
                } else {
                    secondSelectedNode = node as? SKSpriteNode
                    swapSelectedNodes()
                    break
                }
            }
        }
    }

    private func swapSelectedNodes() {
        guard let firstNode = firstSelectedNode, let secondNode = secondSelectedNode else { return }

        // Swap positions
        let firstPosition = firstNode.position
        firstNode.position = secondNode.position
        secondNode.position = firstPosition
        
        
        // Reset selection state
        firstSelectedNode = nil
        secondSelectedNode = nil
        
        // Check for win condition
        checkForWin()
        pront()
    }

    
//    private func swapSelectedNodes() {
//        guard let firstNode = firstSelectedNode, let secondNode = secondSelectedNode else { return }
//
//        let firstPosition = firstNode.position
//        firstNode.position = secondNode.position
//        secondNode.position = firstPosition
//        
//        // Сбросим состояние
//        firstSelectedNode = nil
//        secondSelectedNode = nil
//        checkForWin()
//    }


    private func checkForWin() {
        guard let winBoard = winBoard else { return }
        
        var currentBoard = [[Int]]()
        
        // Сканирование текущего состояния игрового поля
        self.enumerateChildNodes(withName: "draggable") { (node, _) in
            if let node = node as? SKSpriteNode,
               let value = node.userData?["value"] as? Int,
               let row = node.userData?["row"] as? Int,
               let col = node.userData?["col"] as? Int {
                if currentBoard.count <= row {
                    currentBoard.append([Int]())
                }
//                currentBoard[row].insert(value, at: col)
            }
        }
        
        if currentBoard == winBoard {
            print("Ты победил!")
        } else {
            print("Пробуй ещё!")
        }
    }

    
}
extension GameScene {
    
 
//    private func showGameOverViewScore() {
//        storage.scoreCoints += coints
//        storage.scorePoints += points
//        
//        let gameOverNode = SKSpriteNode(color: .cDarkBlue.withAlphaComponent(0.6), size: self.size)
//        gameOverNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        gameOverNode.zPosition = 100
//        gameOverNode.name = "gameOverNode"
//        
//        let square = SKSpriteNode(imageNamed: "scoreContImg")
//        square.size = CGSize(width: 346.autoSize, height: 674.autoSize)
//        square.position = CGPoint(x: 0, y: -80.autoSize)
//        square.zPosition = 101
//        gameOverNode.addChild(square)
//        
//        let titleLabel = SKLabelNode()
//          let titleText = "Well done!".uppercased()
//          let titleAttributes: [NSAttributedString.Key: Any] = [
//              .font: UIFont(name: "Unbounded-Bold", size: 24)!,
//              .foregroundColor: UIColor.cYellow,
//              .kern: 1.2
//          ]
//          let attributedTitle = NSAttributedString(string: titleText, attributes: titleAttributes)
//          titleLabel.attributedText = attributedTitle
//          titleLabel.position = CGPoint(x: 0, y: 280.autoSize)
//          titleLabel.zPosition = 102
//          square.addChild(titleLabel)
//          
//          let subTitleLabel = SKLabelNode()
//          let subTitleText = "Your response is excellent\n            You've earned"
//          let subTitleAttributes: [NSAttributedString.Key: Any] = [
//              .font: UIFont(name: "Unbounded-Regular", size: 12)!,
//              .foregroundColor: UIColor.white,
//              .kern: 1.2
//          ]
//          let attributedSubTitle = NSAttributedString(string: subTitleText, attributes: subTitleAttributes)
//          subTitleLabel.attributedText = attributedSubTitle
//          subTitleLabel.horizontalAlignmentMode = .center
//          subTitleLabel.verticalAlignmentMode = .center
//          subTitleLabel.numberOfLines = 0
//          subTitleLabel.position = CGPoint(x: 0, y: 246.autoSize)
//          subTitleLabel.zPosition = 102
//        square.addChild(subTitleLabel)
//
//        
//        let scoreImg = SKSpriteNode(imageNamed: "scoreImg")
//        scoreImg.size = CGSize(width: 200.autoSize, height: 50.autoSize)
//        scoreImg.position = CGPoint(x: 0, y: 184.autoSize)
//        scoreImg.zPosition = 102
//        square.addChild(scoreImg)
//        
//        let pointsLabel = SKLabelNode()
//            let pointsText = "\(points)"
//            let pointsAttributes: [NSAttributedString.Key: Any] = [
//                .font: UIFont(name: "Unbounded-Bold", size: 20)!,
//                .foregroundColor: UIColor.white,
//                .kern: 5.0
//            ]
//            let attributedPoints = NSAttributedString(string: pointsText, attributes: pointsAttributes)
//            pointsLabel.attributedText = attributedPoints
//            pointsLabel.position = CGPoint(x: 64.autoSize, y: -8.autoSize)
//            pointsLabel.zPosition = 102
//            scoreImg.addChild(pointsLabel)
//            
//            let cointsLabel = SKLabelNode()
//            let cointsText = "\(coints)"
//            let cointsAttributes: [NSAttributedString.Key: Any] = [
//                .font: UIFont(name: "Unbounded-Bold", size: 20)!,
//                .foregroundColor: UIColor.white,
//                .kern: 5.0
//            ]
//            let attributedCoints = NSAttributedString(string: cointsText, attributes: cointsAttributes)
//            cointsLabel.attributedText = attributedCoints
//            cointsLabel.position = CGPoint(x: -30.autoSize, y: -8.autoSize)
//            cointsLabel.zPosition = 102
//            scoreImg.addChild(cointsLabel)
//        
//        let imgYouWin = SKSpriteNode(imageNamed: "scoreCenterImg")
//        imgYouWin.size = CGSize(width: 250.autoSize, height: 250.autoSize)
//        imgYouWin.position = CGPoint(x: -4, y: 24.autoSize)
//        imgYouWin.zPosition = 101
//        square.addChild(imgYouWin)
//                
//        let thanksBtn = CustomSKButton(texture: SKTexture(imageNamed: "thanksBtn"))
//        thanksBtn.size = .init(width: 250.autoSize, height: 84.autoSize)
//        thanksBtn.position =  CGPoint(x: 0, y: -142.autoSize)
//        thanksBtn.zPosition = 40
//        thanksBtn.normal = UIImage(named: "thanksBtn")
//        thanksBtn.action = { self.backHomeAction() }
//        square.addChild(thanksBtn)
//        
//        self.addChild(gameOverNode)
//        self.enumerateChildNodes(withName: "\(playItems)") { (node, _) in
//            node.removeFromParent()
//        }
//    }
//    
//


 
 
    @objc private func settingsButtonAction() {
        guard popupActive == false else { return }
        resultTransfer?(.updateScoreBackEnd)
    }
    
    @objc private func backHomeAction() {
        guard popupActive == false else { return }
        resultTransfer?(.gameBack)
    }
    
    @objc private func backButtonAction() {
        guard popupActive == false else { return }
        resultTransfer?(.back)
    }
    
    @objc private func dropButtonButtonAction() {
        guard popupActive == false else { return }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        
    }
}
