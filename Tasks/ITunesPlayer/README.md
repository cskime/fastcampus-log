# iTunes Player

- iTunes API를 사용한 음악 검색 앱
- 사용 라이브러리 : Alamofire

## UISearchController

 - `UISearchBar`를 가진 검색 창을 제공하는 controller. `searchResultsController`에 검색 결과를 보여주는 화면(ViewController) 설정. `nil`을 전달하면 해당 영역이 어둡게 표시됨

    ```swift
    let searchController = UISearchController(searchResultsController: nil)
    ```

 - `UINavigationBar`에 `searchController`추가

    ```swift
    navigationItem.searchController = searchController
    ```

 - `UITableView`에 `serachBar` 추가

    ```swift
    tableView.tableHeaderView = searchController.searchBar
    ```

- `obscuresBackgroundDuringPresentation` : Search bar 이외 영역을 어둡게 처리함. `false`면 효과 제거

   ```swift
   searchController.obscuresBackgroundDuringPresentation = false
   ```

### DefinesPresentation

- `modalPresentationStyle`을 `currentContext`로 설정한 경우, 화면이 전환될 때 새로 나타날 화면이 차지할 영역을 결정함
- 전환되는 화면은 해당 속성이 `true`인 view controller의 영역에 나타나게 됨. 일반적으로 `UINavigationController`는 해당 속성이 `true`이고, 일반적인 `UIViewController`는 `false`이므로 `present`했을 때 navigation bar를 덮으면서 화면이 전환됨

- `UISearchController`가 추가되어 있는 화면의 view controller에서 해당 속성을 `true`로 설정했다면, `UISearchController`의 어두운 부분의 화면은 `UISearchBar`가 있는 navigation bar를 가리지 않고 view controller 자체의 영역에 나타남.
- 반대로 `false`로 설정한다면 `UINavigationController`의 `definesPresentation`이 `true`이므로 어두운 부분이 navigation bar까지 덮어서 `UISearchBar`가 있는 영역까지 어둡게 처리됨
- **iOS 13 이상부터는 무조건 `true`. iOS 12 이하만 `false` 설정 가능**

### UISearchBar

- `searchBar`를 통해  `UISearchController`에 있는 `UISearchBar`에 접근하여 속성 변경

  ```swift
  let searchBar = searchController.searchBar
  searchBar.tintColor = .red
  searchbar.placeholder = "Search Musics"
  ```

- `scopeButtonTitles` : `UISearchBar` 아래에 scopeButton을 생성함

  ```swift
  let scopeButtonTitles = ["Search", "Swift", "Marron5", "Adel"]
  searchBar.scopeButtonTitles = scopeButtonTitles
  ```

### Delegates

- `UISearchBarDelegate`을 통해 search bar의 특정 시점에서 원하는 작업 가능

  ```swift
  // Cancel 버튼을 눌렀을 때
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
  // Keyboard에서 search 버튼을 눌렀을 때
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
  // Search bar의 scope button을 눌렀을 때
  func searchBar(_ searchBar: UISearchBar, 
                 selectedScopeButtonIndexDidChange selectedScope: Int)
  ```

## AVKit

- 간단하게 미디어 관련 작업을 할 수 있는 framework

- `AVFoundation`에 비해 쉽게 사용할 수 있어서 별도의 customizing이 필요하지 않을 때 사용

- URL을 통한 30초 미리듣기

  ```swift
  let player = AVPlayer()
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    player.pause()
    player.replaceCurrentItem(with: AVPlayerItem(url: previewURL))
    player.play()
  }
  ```

  