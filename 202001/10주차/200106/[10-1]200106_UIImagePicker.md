# UIImagePickerController

- `UIImagePickerController`를 사용해서 앨범에서 사진 및 동영상을 선택해서 가져오거나 촬영하는 등 기능을 구현할 수 있다

## Usage

- `present()`로 화면에 띄움

- `sourceType` : `UIImagePickerController`를 사용할 방법 선택

  - `.camera` : 사진 및 동영상을 촬영할 수 있는 카메라
  - `.photoLibrary` : 기본값. 앨범별로 나타나는 화면
  - `.savedPhotoAlbum` : 특별한 순간 눌러서 날짜별로 나오는 화면

- `mediaType` : `UIImagePickerController`에서 접근할 수 있는 타입 선택

  - `"public.image"`, `"public.movie"`, `"public.video"` 등의 값을 collection으로 전달
  - `video`는 비디오만, `movie`는 마이크까지 사용해서 촬영
  -  `MobileCoreServices`를 `import`하여 literal `String` 대신 `kUTType`변수 사용. `String` 타입으로 캐스팅해서 사용해야함.
    - `kUTTypeImage` = `public.image`
    - `kUTTypeMovie` = `public.movie`
    - `kUTTypeVideo` = `public.video`

  ```swift
  @IBAction private func pickImage(_ sender: Any) {
    imagePicker.sourceType = .photoLibrary						// default
    imagePicker.mediaType = ["public.image"]					// default
    imagePicker.mediaType = [kUTTypeImage as String]	// default
    present(imagePicker, animated: true)
  }
  ```

  - `UIImagePickerController.availableMediaTypes(for:)`를 사용하면 `sourceType`에 맞는 `mediaType`을 반환해줌. 디바이스에 따라 다른 collection을 반환함. 일반적인 아이폰에서는 모두 `[public.image, public.media]`로 반환됨

- `cameraCaptureMode` : `sourceType`이 `.camera`일 때, 첫 화면에 어떤 모드로 실행될 지 결정

  - `.video`, `.photo`

- `takePicture()` : 사진 촬영

- `startVideoCapture`, `stopVideoCapture` : 비디오 촬영 시작/종료

## 권한 설정(authorization)

- `info.plist`에서 관련 key를 추가해서 권한을 설정하도록 해야함
- 카메라 권한 설정 : `Privacy - Camera Usage Description`
- 비디오 권한 설정 : `Privacy - Microphone Usage Description`
- 앨범 접근(저장) 권한 설정 : `Privacy - Photo Library Additions Usage Description`

## Delegation

- `delegate`를 설정해서 앨범 또는 촬영한 사진 및 비디오를 선택하거나 `UIImagePickerController`를 종료했을 때 동작을 구현할 수 있음
- `UIImagePickerControllerDelegate`와 `UINavigationControllerDelegate` 모두 채택해야함
- `imagePickerController(_:didFinishPickingMediaWithInfo:)` : 앨범에서 이미지를 선택했을 때 동작을 구현. 기본 시스템 동작으로 `dismiss()`가 사용되었었지만, 해당 method를 구현하게 되면 직접 `dismiss()`를 구현해야함
- `imagePickerControllerDidCancel(_:)` : Cancel 버튼을 눌렀을 때 호출. 직접 구현할 때 화면을 닫으려면 직접 `dismiss()`를 호출해야함

### UIImagePickerController.InfoKey

- `UIImagePickerController`에서 사진 및 비디오가 선택(pick)되었을 때, 해당 미디어에 대한 정보가 담겨있는 dictionary의 key.
  - `originalImage` : 선택한 원본 이미지의  key. `UIImage` 타입
  - `editedImage` : 편집된 이미지의 key. `UIImage` 타입
  - `mediaType` : 선택된 미디어의 타입. image, movie, video
  - `mediaURL` : `movie` 타입 미디어의 filesystem URL. `NSURL` 타입
  - `livePhoto`, `imageURL`, `mediaMetaData` etc..
- `UTTypeEqual(_:_:)` : 두 `mediaType`이 같은지 확인. 사진(`kUTTypeImage`)인지 비디오(`kUTTypeMovie`)인지에 따라 처리를 다르게 할 수 있음

### 미디어 저장하기

- `UIImageWriteToSavedPhotosAlbum(_:_:_:_:)` : 이미지 저장하기. 특별한 경우가 아니면 `UIImage`만 인자로 전달
- `UISaveVideoAtPathToSavedPhotosAlbum(_:_:_:_:)` : 비디오 저장하기. `.mediaURL` 키로부터 `mediaPath`를 얻고, `UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(_:)`로 저장 가능한지 판단해야함.

## Image Pick

- `UIImagePickerController.InfoKey`를 통해 선택한 이미지를 `UIImageView`에 나타낼 수 있음

- Key에 따라 어떤 타입의 값이 들어있는지 확인 후 캐스팅해서 사용

  ```swift
  @IBAction private func pickImage(_ sender: Any) {
    imagePickerController.sourceType = .photoLibrary
    present(imagePickerController, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {    
    let image = info[.originalImage] as! UIImage
  	imageView.image = image
    dismiss(animated: true)
  }
  ```

## Take Picture

- `sourceType`을 반드시 `.camera`로 바꿔야함. `photoLibrary`로 되어있으면 앱이 죽는다

- 카메라를 사용할 때는 **권한** 문제 때문에 `info.plist`에서 `Privacy - Camera Usage Description` 키를 활성화해야함

- 앨범에서 비디오를 선택하는 경우는 제외하고 이미지를 선택했을 때만 어떤 동작을 하도록 할 수 있다.

  ```swift
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {    
    // 영상인 경우는 제외하고 이미지인 경우에만 동작하도록
  	let mediaType = info[.mediaType] as! NSString
    if UTTypeEqual(mediaType, kUTTypeImage) {
    	imageView.image = (info[.originalImage] as! UIImage)
    }
    dismiss(animated: true)
  }
  ```

## Editing Image

- `imagePicker.allowsEditing`을 토글시켜서 사진을 선택하면 편집 화면이 나타나도록 설정할 수 있음

- 편집된 사진을 사용할 때는 `UIImagePickerController.InfoKey`에서 `.editedImage`로 가져와야함. 편집하지 않았을 경우에는 `nil`이니까 옵셔널 타입으로 받아야함

  ```swift
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {    
    let originalImage = info[.originalImage] as! UIImage
    let editedImage info[.editiedImage] as? UIImage
    let selectedImage = editedImage ?? originalImage
  	imageView.image = selectedImage
    dismiss(animated: true)
  }
  ```

## Delay Picture

- `DispatchQueue.main.asyncAfter(deadline:execute:)`를 사용해서 특정 시간이 지난 뒤에 사진을 촬영

  ```swift
  @IBAction private func takePictureWithDelay(_ sender: Any) {
    imagePickerController.sourceType = .camera
    imagePickerController.mediaTypes = [kUTTypeImage as String]
    // 촬영 화면이 나타난 후 2초 뒤에 사진 찍기
    present(imagePickerController, animated: true) {
    	DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    		self.imagePickerController.takePicture()
    	}
    }
  }
  ```

- 딜레이 촬영은 `UIImagePicker`가 아니라 별도로 촬영하는 기능을 만들어서 사용하게 됨. `UIImagePickerController`는 직접 촬영할 수 있는 기능을 계속 제공하므로 적절하지 않다.

## Recording Video

- 비디오 촬영에는 마이크가 사용되므로 **마이크 사용 권한**을 별도로 설정해야함. `info.plist`에서 `Privacy - Microphone Usage Description` 키를 활성화해야함

- `imagePicker.mediaTypes`

  - 기본 미디어 타입은 `public.image` 

  - `public.video`는 영상만 촬영, `public.movie`는 소리까지 녹음됨. `public.movie`가 설정될 경우에 마이크 사용 권한 필요

  - `.availableMediaTypes(for:)`를 이용해서 `.camera` 타입을 추가하면 `[public.image, public.media`로 설정되고, 비디오까지 촬영할 수 있게 됨

  - `MobileCoreServices` 프레임워크를 import하면 쉽게 사용할 수 있다. `kUTType`을 사용

    ```swift
    import MobileCoreServices
    ...
    // equal to ["public.image", "public.movie"]
    imagePickerController.mediaType = [kUTTypeImage, kUTTypeMovie] as [String]
    ```

- `imagePicker.cameraCaptureMode` : `.video`와 `.photo` 둘 중 어떤 것을 먼저 보여줄 것인지 설정함

- `startVideoCapture()`, `stopVideoCapture()` 등을 사용해서 원하는 타이밍에 촬영을 시작하고 종료할 수 있다.

- `imagePickerController.videoQuality`로 화질을 설정할 수 있음. 기본은 낮게 되어 있으므로 `.typeHigh` 등으로 설정해서 화질을 높일 수 있다.

## Save Captured Image & Media

- 앨범에 사진 및 비디오를 저장하기 위한 권한 필요. `info.plist`에서 `Privacy - Photo Library Additions Usage Description` 키를 활성화해야함

- `UIImageWriteToSavedPhotosAlbum()`을 사용해서 최종 **이미지 저장**

  ```swift
  if picker.sourceType == .camera {
  	UIImageWriteToSavedPhotosAlbum(selectedImage!, nil, nil, nil) 
  }
  ```

- `UISaveVideoAtPathToSavedPhotosAlbum()`을 사용해서 촬영된 **비디오 저장**

  ```swift
  // mediaType이 public.movie일 때
  if UTTypeEqual(mediaType, kUTTypeMovie) {
    // mediaPath를 가져와서 mediaPath를 저장해야함
  	if let mediaPath = (info[.mediaURL] as? NSURL)?.path, 
    	UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaPath) {
  		UISaveVideoAtPathToSavedPhotosAlbum(mediaPath, nil, nil, nil)
  	}
  }
  ```