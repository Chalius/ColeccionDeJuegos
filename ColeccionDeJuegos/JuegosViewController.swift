
import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate  {
    
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    
    @IBOutlet weak var eliminarBoton: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    
    var juego:Juego? = nil
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil{
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
            
            // category:
            if let nuevo_juego = juego!.categoria {
                juego!.categoria! = categoryInput.text!
            }else{
                juego!.categoria = categoryInput.text
            }
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
            
            // category:
            juego.categoria = categoryInput.text
            
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    // probando combo input
    
    @IBOutlet weak var categoryInput: UITextField!
    @IBOutlet weak var dropDownCategory: UIPickerView!
    var list = ["Acción", "Aventura", "Puzzle","rol","MMORPG"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
   }
       
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

       self.view.endEditing(true)
       return list[row]
   }

   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

       self.categoryInput.text = self.list[row]
       //self.dropDownCategory.isHidden = true
   }

   func textFieldDidBeginEditing(_ textField: UITextField) {

       if textField == self.categoryInput {
           self.dropDownCategory.isHidden = false
           //if you don't want the users to se the keyboard type:

           textField.endEditing(true)
       }
   }
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        if juego != nil{
            JuegoImageView.image = UIImage(data:(juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
        
        
        self.dropDownCategory.delegate = self
        self.dropDownCategory.dataSource = self
        
    }
    

  

}
