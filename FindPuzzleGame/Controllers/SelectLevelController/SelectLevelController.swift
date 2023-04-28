

import UIKit



class SelectLevelController: UIViewController {
  
    
    static let id = String(describing: SelectLevelController.self)
    
    @IBOutlet weak var selectLevelLabel: UILabel!
    @IBOutlet weak var levelCollectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private let meriendaFont = UIFont(name: "MeriendaOne-Regular", size: 40)
    
    var userLevel = DefaultsManager.levelCompleted
    var level = 1
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addStrokeToString()
        
        registerCell()
        
        levelCollectionView.delegate = self
        levelCollectionView.dataSource = self
        
        levelCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func addStrokeToString() {
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor().hexStringToUIColor(hex: "511834"),
            .foregroundColor: UIColor.white,
            .strokeWidth: -4.5
        ]
        let text = NSAttributedString(string: "SELECT LEVEL", attributes: strokeTextAttributes)
        selectLevelLabel.font = meriendaFont
        selectLevelLabel.attributedText = text
    }
    
    private func registerCell() {
        let nib = UINib(nibName: SelectLevelCollectionViewCell.id, bundle: nil)
        levelCollectionView.register(nib, forCellWithReuseIdentifier: SelectLevelCollectionViewCell.id)
    }
    
   
    
    @IBAction func closeButtonDidTap(_ sender: UIButton) {
        closeButton.alpha = 0.5
        navigationController?.popViewController(animated: true)
        _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
            self.closeButton.alpha = 1
        }
    }
    
    @IBAction func nextButtonDidTap(_ sender: UIButton) {
        nextButton.alpha = 0.5
        let gameVC = GameScreenController(nibName: GameScreenController.id, bundle: nil)
        gameVC.level = DefaultsManager.levelCompleted
        gameVC.closure = {
            self.levelCollectionView.reloadData()
        }
        navigationController?.pushViewController(gameVC, animated: true)
        _ = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { _ in
            self.nextButton.alpha = 1
        }
    }
    
    
    
    
}

extension SelectLevelController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectLevelCollectionViewCell.id, for: indexPath)
        guard let levelCell = cell as? SelectLevelCollectionViewCell else { return cell }
        if DefaultsManager.levelCompleted! >= level {
            let model = MyCellModel(number: String(level), isSelected: true)
            levelCell.set(model: model)
        } else {
            let model = MyCellModel(number: String(level), isSelected: false)
            levelCell.set(model: model)
        }
        self.level += 1
        if level == 16 {
            level = 1
        }
        return levelCell
    }
    
    
}

extension SelectLevelController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let level = indexPath.row + 1
        guard let userLevel = DefaultsManager.levelCompleted else { return }
        if level <= userLevel {
            let gameVC = GameScreenController(nibName: GameScreenController.id, bundle: nil)
            gameVC.closure = {
                self.userLevel = DefaultsManager.levelCompleted
                self.levelCollectionView.reloadData()
            }
            gameVC.level = level
            navigationController?.pushViewController(gameVC, animated: true)
        }
    }
}

extension SelectLevelController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 12.0
        guard let screen = view.window?.windowScene?.screen else { return .zero }
        let cellCount = 4.0
        let width = (screen.bounds.width - (inset * (cellCount + 1)))  / cellCount
        return CGSize(width: width, height: width)
    }
}
