import UIKit

class RegistrationMobileViewController: UIViewController, RegistrationSubController {
    
    @IBOutlet var numberTextField: TextField!
    @IBOutlet var confirmButton: ActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let bidDetails = self.navigationController?.fulfilmentNav().bidDetails {
            RAC(bidDetails.newUser, "phoneNumber") <~ numberTextField.rac_textSignal()
            
            let numberIsValidSignal = RACObserve(bidDetails.newUser, "phoneNumber").map(isZeroLengthString)
            RAC(confirmButton, "enabled") <~ numberIsValidSignal.notEach()
        }
    }
    
    let finishedSignal = RACSubject()
    @IBAction func confirmTapped(sender: AnyObject) {
        finishedSignal.sendCompleted()
    }
}
