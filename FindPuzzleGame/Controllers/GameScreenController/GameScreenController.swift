//
//  GameScreenController.swift
//  FindPuzzleGame
//
//  Created by Nikita on 16.04.23.
//

import UIKit

class GameScreenController: UIViewController {
    static let id = String(describing: GameScreenController.self)

    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinsCountLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelCountLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deskImage: UIImageView!
    @IBOutlet weak var winStarsImage: UIImageView!
    @IBOutlet weak var winLeprechaunImage: UIImageView!
    @IBOutlet weak var youWinLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    ///передавать левел в эту переменную
    var level: Int?
    ///для удержания первой нажатой карты
    private var firstFlippedCardIndex:IndexPath?
    private var coinsCount = 0
    private var myLevel: Level?
    
    private let meriendaFont = UIFont(name: "MeriendaOne-Regular", size: 32)
    ///хранит массив карточек
    private var arrayOfCards = [Card]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var closure: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(skipWinnerLeprechaun))
        
        winLeprechaunImage.isUserInteractionEnabled = true
        winLeprechaunImage.addGestureRecognizer(gesture)
        
        winStarsImage.alpha = 0
        winLeprechaunImage.alpha = 0
        youWinLabel.alpha = 0
        
        addStrokeToStringToCoins()
        addStrokeToStringToLevel()
        addStrokeToStringToWinLabel()
        
        registerCell()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        guard let level = level else { return }
        levelCountLabel.text = String(level)
        ///создаем объект уровня по переданному левелу
        myLevel = Level(numberOfLevel: level)
        
        guard let myLevel = myLevel else { return }
        ///создаем объект cardModel и прокидываем туда количество карт с помощью объекта Level
        arrayOfCards = CardModel().getCards(myLevel.numberOfCards)
        
        navigationController?.isNavigationBarHidden = true

    }
    ///при победе для нажатия на леприкона
    @objc func skipWinnerLeprechaun() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func registerCell() {
        let nib = UINib(nibName: GameScreenCollectionViewCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: GameScreenCollectionViewCell.id)
    }
    
    private func addStrokeToStringToCoins() {
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor().hexStringToUIColor(hex: "#8C0000"),
            .foregroundColor: UIColor.white,
            .strokeWidth: -2
        ]
        guard let coins = coinsCountLabel.text else { return }
        let text = NSAttributedString(string: coins, attributes: strokeTextAttributes)
        coinsCountLabel.font = meriendaFont
        coinsCountLabel.attributedText = text
        coinsCountLabel.alpha = 0.9
    }
    
    private func addStrokeToStringToLevel() {
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor().hexStringToUIColor(hex: "#82008C"),
            .foregroundColor: UIColor.white,
            .strokeWidth: -2
        ]
        guard let level = levelLabel.text,
        let levelCount = levelCountLabel.text else { return }
        
        let text = NSAttributedString(string: level, attributes: strokeTextAttributes)
        
        levelLabel.font = meriendaFont?.withSize(24)
        levelLabel.attributedText = text
        levelLabel.alpha = 0.9
        
        let text2 = NSMutableAttributedString(string: levelCount, attributes: strokeTextAttributes)
        text2.addAttribute(.baselineOffset, value: 2, range: NSRange(location: 0, length: text2.length))
        levelCountLabel.font = meriendaFont
        levelCountLabel.attributedText = text2
        levelCountLabel.alpha = 0.9
        
    }
    
    private func addStrokeToStringToWinLabel() {
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor().hexStringToUIColor(hex: "511834"),
            .foregroundColor: UIColor.white,
            .strokeWidth: -4.5
        ]
        guard let text = youWinLabel.text else { return }
        let attrText = NSAttributedString(string: text, attributes: strokeTextAttributes)
        youWinLabel.font = meriendaFont?.withSize(40)
        youWinLabel.attributedText = attrText
    }
    
    func checkForMatch(_ secondFlippedCardIndex: IndexPath) {
        guard let firstFlippedCardIndex = firstFlippedCardIndex else { return }
        
        let cardOne = arrayOfCards[firstFlippedCardIndex.row]
        let cardTwo = arrayOfCards[secondFlippedCardIndex.row]
        
        // Get the two collection view cells that represent card one and two
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex) as? GameScreenCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? GameScreenCollectionViewCell
        ///сравниваем карты из массива
        if cardOne.imageName == cardTwo.imageName && firstFlippedCardIndex.row != secondFlippedCardIndex.row {
          
            coinsCount += 10
            UIView.animate(withDuration: 0.3, delay: 0.1) {
                self.coinsCountLabel.text = String(self.coinsCount)
            }
            
            ///помечаем их
            cardOne.isMatched = true
            cardTwo.isMatched = true
            ///вызываем метод remove и скрываем их с экрана
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            ///вызываем проверку на последнюю пару
            checkForGameEnd()
        }
        ///если совпадения не найденты возвращаем отбратно  и переводим firstFlippedCardIndex в nil
        else {
                        
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        self.firstFlippedCardIndex = nil
    }
    
    ///проверка на последнего
    private func checkForGameEnd() {
        
        var hasWon = true
        
        for card in arrayOfCards {
            
            if card.isMatched == false {
                ///если еще карты остались-false
                hasWon = false
                break
            }
        }
        //в случае если последняя выполняем действия
        if hasWon == true {
            if DefaultsManager.levelCompleted == level {
                coinImage.isHidden = true
                coinsCountLabel.isHidden = true
                levelLabel.isHidden = true
                closeButton.isHidden = true
                levelCountLabel.isHidden = true
                
                UIView.animate(withDuration: 0.3, delay: 0.5) {
                    self.winStarsImage.alpha = 1
                    self.winLeprechaunImage.alpha = 1
                    self.youWinLabel.alpha = 1
                }
                guard let level = DefaultsManager.levelCompleted else { return }
                if level < 15 {
                    DefaultsManager.levelCompleted = level + 1
                    closure?()
                }
            } else {
                coinImage.isHidden = true
                coinsCountLabel.isHidden = true
                levelLabel.isHidden = true
                closeButton.isHidden = true
                levelCountLabel.isHidden = true
                
                UIView.animate(withDuration: 0.3, delay: 0.5) {
                    self.winStarsImage.alpha = 1
                    self.winLeprechaunImage.alpha = 1
                    self.youWinLabel.alpha = 1
                }
            }
        }
        else {
            
          
        }
        
       
        
    }
    
    @IBAction func closeButtonDidTap(_ sender: UIButton) {
        self.closeButton.alpha = 0.5
        navigationController?.popViewController(animated: true)
        _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
            self.closeButton.alpha = 1
        }
    }
    
}

extension GameScreenController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameScreenCollectionViewCell.id, for: indexPath)
        guard let cardCell = cell as? GameScreenCollectionViewCell else { return cell }
        cardCell.set(model: arrayOfCards[indexPath.row])
        return cardCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let cardCell = cell as? GameScreenCollectionViewCell
            let card = arrayOfCards[indexPath.row]
            cardCell?.set(model: card)
        }
    
}

extension GameScreenController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? GameScreenCollectionViewCell
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            cell?.flipUp()
        }
        ///если первый перевертыш, то он сетается в firstFlippedCardIndex, в противном случае вызывается метод checkForMatch
        if firstFlippedCardIndex == nil {
            firstFlippedCardIndex = indexPath
        }  else {
                checkForMatch(indexPath)
            }
        
    }
}

extension GameScreenController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: 80, height: 80)
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        switch arrayOfCards.count {
        case 1...12:
            return CGSize(width: collectionView.bounds.width / 3 , height: collectionView.bounds.height / 4)
        case 13...29:
            return CGSize(width: collectionView.bounds.width / 4, height: collectionView.bounds.height / 5)
        case 30...50:
            return CGSize(width: collectionView.bounds.width / 5, height: collectionView.bounds.height / 6)
        default:
            return CGSize(width: collectionView.bounds.width / 3, height: collectionView.bounds.height / 4)
            
        }
    }
}

