# 💛 YELLO-iOS
## 📃 프로젝트 설명
~~~
투표로 관계의 재미를 찾아가는 서비스, YELL:O
~~~

## 🍎 iOS Developers
| 👑 정채은 | 변희주 | 이지희 |
| :--------: | :--------: | :--------: |
| <img src="https://github.com/team-yello/YELLO-iOS/assets/109775321/502ca850-21e9-48a4-b43e-4c42d71e582f" width="200px"/> | <img src ="https://github.com/team-yello/YELLO-iOS/assets/109775321/9b8df80b-90fa-49c6-98e6-b87cec4daabc" width = "200px"/> | <img src ="https://github.com/team-yello/YELLO-iOS/assets/109775321/e16d7266-efec-423c-872a-7a07c53275db" width = "200px"/> |
| [chaentopia](https://github.com/chaentopia)  | [Heyjooo](https://github.com/Heyjooo) | [Zoe0929](https://github.com/Zoe0929) |
|  추천친구, 내 옐로, 프로필    |     투표 (옐로하기)      |    온보딩    |
|   아 옐로💛를 위해 <br>코드짜고 있었는데 미치겠다   |   히주가 ??? 개발하고 싶대 <br> 답 : 옐로 💛   |   행복한 노란색 개발자 💛   |

## 📚 Library
~~~
1. Alamofire
    - 서버 통신을 위한 관련 라이브러리
    
2. KakaoOpenSDK
    - 카카오 소셜 로그인을 위한 라이브러리

3. KingFisher
    - 서버 통신의 이미지를 가져오기 위한 라이브러리
    
4. Lottie
    - 애니메이션 효과를 가진 뷰를 구현하기 위한 라이브러리
    
5. SnapKit
    - Code base 개발을 원활하게 도와주는 라이브러리

6. SwiftKeychainWrapper
    - Keychain을 관리해주는 라이브러리

7. Then
    - Code base 개발을 원활하게 도와주는 라이브러리
~~~

## 💻 Code Convention
[YELL:O iOS 코드 컨벤션](https://yell0.notion.site/Code-Convention-e3fb634583164b3eb50c6619244e7e06?pvs=4)

## ⛓️ Git Convention & Git Flow 전략
[YELL:O iOS 깃 컨벤션](https://yell0.notion.site/Git-Convention-39827d257d644bb2ace6ffcf16d41031?pvs=4)
~~~ 
1. 내가 구현할 기능이 생겼다면 ?? 일단 이슈를 판다 -> TodoList 작성하자 !
2. 만든 Issue에 해당하는 작업을 수행할 Feat 브랜치를 만든다 (ex: feat/#<이슈번호>)
3. 열심히 작업한다음 Add - Commit - Push를 한다 ! 그러면 remote에 내가 작업한 내용이 올라가겠죠 !
4. main 브랜치로 Pull Request를 날린다 : main브랜치랑 비교해서 내 브랜치에 생긴 변경사항을 봐주세요 ~ 이런느낌이라고 생각하면 되겠죠 ?? 
5. Pull Request가 작성되면 작성자 이외의 다른 팀원이 Code Review를 한다 !!
6. Code Review가 완료되면 내가 작업하던 브랜치에 이어서 수정작업을 거친다. 
7. 수정작업한 것을 push 하면 pull request 밑에 추가됨 !! 
8. Approve를 받은 다음, main branch를 pull 받는다.
	- 왜 ?? pull request 날린 이후에 내가 코드리뷰 반영하고 이것저것 수정하는 동안 누군가 머지를 해서 main이 바꼈을 수도 있기 때문 !! 
	- 안전하게 가장 최신의 main을 가져오기 위해 pull을 해주는겁니당 !! : conflict 해결
9. Pull Request 작성자가 main Branch로 merge ! 끝.. !
**릴리즈 관리를 위해서 develop 브랜치와 main 브랜치를 분리합니다.**
~~~

## 🎁 Project Foldering Convention
```markdown
📦 YELLO-iOS
┣ 📜 .swiftlint
┣ 📂 Storyboard
┃ ┣ 📜 LaunchScreen
┃
┣ 📂 Application
┃ ┣ 📜 Appdelegate
┃ ┣ 📜 SceneDelegate
┃
┣ 📂 Global
┃ ┣ 📂 Extension
┃ ┣ 📂 Literals
┃ ┃ ┣ 📜 Image
┃ ┃ ┣ 📜 String
┃ ┣ 📂 Resources
┃ ┃ ┣ 📂 Font
┃ ┃ ┣ 📜 Font
┃ ┃ ┣ 📜 Color
┃ ┃ ┣ 📜 Assets
┃ ┃ ┣ 📜 Info.plist
┃ ┣ 📂 Protocols
┃
┣ 📂 Presentation
┃ ┣ 📂 Base
┃ ┣ 📂 Splash
┃ ┣ 📂 Onboarding
┃ ┃ ┃ ┣ 📂 ViewController
┃ ┃ ┃ ┣ 📂 Views
┃ ┃ ┃ ┣ 📂 Cells
┃ ┣ 📂 Tabbar
┃ ┣ 📂 Inviting
┃ ┣ 📂 Voting
┃ ┣ 📂 Recommending
┃ ┣ 📂 Around
┃ ┣ 📂 MyYello
┃ ┣ 📂 Profile
┃
┣ 📂 Network
┃ ┣ 📂 Base
┃ ┣ 📂 Onboarding
┃ ┃ ┃ ┣ 📂 DTO
┃ ┃ ┃ ┃ ┣ 📂 Request
┃ ┃ ┃ ┃ ┣ 📂 Response
┃ ┃ ┃ ┣ 📂 Router
┃ ┃ ┃ ┣ 📂 Service
┃ ┣ 📂 Recommending
┃ ┣ 📂 Voting
┃ ┣ 📂 MyYello
┃ ┣ 📂 Profile
```

## 📱 뷰 및 기능 설명
### 🎐 정채은
| 이름 | 스크린샷 | 설명 |
| :--------: | :--------: | :--------: |
| 추천친구 | ![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 20 14 18](https://github.com/team-yello/YELLO-iOS/assets/109775321/b3fc229a-d41b-4c9a-a43f-afba7446f30c) |  친구추가를 할 수 있도록 카톡 친구와 학교 친구를 확인할 수 있는 화면입니다. </br> Segment Control를 이용해 카톡 친구와 학교 친구를 구분하였습니다. 카톡 친구 부분에서는 온보딩 과정에서 카카오톡 친구 연결을 통해 받아온 데이터로 카카오톡 친구 중 옐로에 가입한 사람이 뜹니다. 학교 친구에서는 유저와 동일한 학과의 친구들이 뜹니다. </br></br> 서버 통신으로 테이블뷰에 들어갈 값을 배열에 넣어 로드해주었습니다. 무한 스크롤을 위해서 테이블뷰 바닥에 닿았을 때 서버 통신에서 page 수를 하나씩 증가시켜 배열에 추가해주었습니다. 최신화 시키기 위해서 UIRefreshControl을 이용해 새로고침이 가능하도록 했습니다. 친구가 없을 때는 친구 초대 alert view를 볼 수 있는 버튼이 생깁니다. 분기 처리를 통해서 해당 버튼이 있는 셀이 보입니다. |
| 둘러보기 | ![Simulator Screenshot - iPhone 13 mini - 2023-07-21 at 20 14 22](https://github.com/team-yello/YELLO-iOS/assets/109775321/5b0910c2-56f5-47ef-b61d-8f35dc9bfeac) | 친구가 받은 쪽지를 볼 수 있는 화면입니다. 2차 스프린트에서 구현할 화면입니다.|
| 내 쪽지 | ![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 20 14 49](https://github.com/team-yello/YELLO-iOS/assets/109775321/87cc9e35-519d-4d59-8762-8ba746c3df98) | 내가 받은 쪽지를 볼 수 있는 화면입니다. 쪽지 확인 유무와 힌트 사용 유무에 따라서 다르게 보입니다. UITableView에 Cell을 3개 register하여 힌트 사용 유무에 따라 다른 셀이 사용되도록 처리하였습니다.</br></br> 내 쪽지도 마찬가지로 무한 스크롤을 구현하였고, 쪽지가 없을 때는 쪽지가 없다는 뷰가 셀에 생겨납니다. UIRefreshControl로 새로고침이 가능합니다. </br></br> 셀을 선택하면 해당하는 쪽지를 확인할 수 있습니다. 포인트를 이용해 키워드를 확인할 수 있고, 키워드를 확인하면 포인트를 써서 보낸 사람의 초성을 확인할 수 있습니다. 보낸 사람의 초성은 서버에서 보여줄 초성의 이름 인덱스를 보내주고, 이름을 초성으로 바꾸어주었습니다. 보낸 사람을 확인하려면 결제 안내 화면으로 넘어갑니다. 인스타그램 공유하기 버튼을 누르면 화면이 캡쳐되어 인스타그램 스토리로 공유됩니다.|
| 내 프로필 | ![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 20 15 35](https://github.com/team-yello/YELLO-iOS/assets/109775321/8d84a364-6693-4282-bd02-2bd88e273314) | 내 정보와 내 친구들을 확인할 수 있는 화면입니다.</br>그룹 추가 버튼을 누르면 그룹을 추가할 수 있는 구글폼으로 이동합니다. 내 친구들의 정보를 바텀 시트로 확인할 수 있고, 친구 끊기도 가능합니다. 내 친구들도 UITableView와 무한 스크롤, UIRefreshControl 을 적용했습니다. 모두 스크롤이 가능하도록 상단의 내 프로필과 내 친구들 총 명수가 적힌 부분은 테이블뷰의 Header로 설정했습니다.</br></br>관리 버튼을 누르면 고객센터, 개인정보 처리방침, 이용약관이 있고 각각 외부 링크로 연결됩니다. 로그아웃을 하면 로그아웃과 동시에 로그인 초기 화면으로 돌아갑니다.</br>회원 탈퇴 버튼을 누르면 회원 탈퇴에 대한 정보를 볼 수 있고 탈퇴가 가능합니다. |

### 🐰 이지희
| 이름 | 스크린샷 | 설명 |
| :--------: | :--------: | :--------: |
|Splash| ![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 21 45 03](https://github.com/team-yello/YELLO-iOS/assets/68178395/6966c51b-306d-4123-873d-1c57eb832efd) | `DispatchQeue`를 이용해서 스플래쉬가 2.3초 재생 후에 로그인 화면으로 이동하도록 구현했습니다. 로고 부분의 애니메이션은 Lottie 파일을 이용해서 한번만 재생되도록 설정했습니다.  ( 참고: [SceneDelegate.swift](https://github.com/team-yello/YELLO-iOS/blob/71485b1ba6c3f9b8cd863d9d8b09717db24623a2/YELLO-iOS/YELLO-iOS/Application/SceneDelegate.swift#L22))  |
|카카오로그인| ![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 21 45 43](https://github.com/team-yello/YELLO-iOS/assets/68178395/e518ad31-dfca-4a2f-80b8-26a3f33d8469)| 카카오 로그인 API를 이용해서 소셜 로그인을 구현했습니다. 카카오톡 설치 여부를 확인해서 카카오톡이 설치되어있지 않다면 카카오 계정으로 로그인하도록 분기처리를 했습니다. 소셜 로그인에 성공한다면 카카오톡 유저의 정보를 자체 API를 통해 서버에 전달합니다. `UserDefault`를 이용해서 로그인 여부를 저장하여 자동로그인을 구현합니다.|
|카카오 친구 연결|![Simulator Screenshot - iPhone 13 mini - 2023-07-21 at 21 45 48](https://github.com/team-yello/YELLO-iOS/assets/68178395/4542f39e-3900-4397-9ee3-6f3ec9070dec)|카카오 소셜 API를 연결하여 User의 친구 정보를 전달받아 자체 서버로 전송합니다. (현재 카카오에서 API 이용 관련 인가를 해주지 않아서 Team Member만 친구 연결이 가능합니다.)|
|학교 입력| ![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 21 46 10](https://github.com/team-yello/YELLO-iOS/assets/68178395/75987bae-74fc-488f-bd0b-228c8b23bd3f)|학교 정보를 입력합니다. `UITextFieldDelegate`를 이용해서 텍스트 필드에 입력(focusing)이 감지되면 새로운 모달뷰를 띄워 학교 검색을 진행합니다. 현재 학교가 추가되어 있지 않다면 `helperButton`을 통해 구글 폼으로 연결됩니다.</br><br>학교 검색을 하는 새로운 모달뷰에서는 `TextField`에 `addTarget`을 통해 `textFieldDidChange`을 연결합니다. 이 때 이벤트는 'editingChanged'를 감지시켜서 변화하는 값을 실시간으로 사용할 수 있도록 구현했습니다. 이를 이용해서 입력에 대한 실시간 검색을 진행합니다. 학과 검색에 대한 결과는 테이블뷰로 표시되며 한 페이지당 10개씩 전달을 받아 무한 스크롤을 구현했습니다. 자세한 구현 사항은 [트러블슈팅](https://www.notion.so/yell0/30fc729b46e44ecda487e29b8b7068d2?pvs=4)에 기록하였습니다. </br><br> 그 후 테이블 셀을 선택하면 `tableViewDelegate`를 이용해서 선택한 셀에 대한 정보를 저장하고 delegate에 의해 이전뷰에 정보가 전달됩니다.텍스트 필드에 값이 입력되게 되면 custom TextField인 YelloTextField의 상태가 변화하게 되고 변화된 UI가 적용됩니다.|
|학과, 학번 정보 입력| ![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 21 46 36](https://github.com/team-yello/YELLO-iOS/assets/68178395/5b14b1a7-ab4e-4b50-8039-9537b85fffd6)|학과 검색은 학교 검색과 같은 뷰와 기능을 가지고 있습니다. 따라서 `BaseSearchViewController`를 이용해서 컴포넌트와 기능 구현을 재사용하도록 작성했습니다. 학과 검색 뷰에서 해당하는 학과를 선택하면 `tableViewDelegate`를 이용해서 선택한 셀에 대한 정보를 저장하고 delegate에 의해 이전뷰에 정보가 전달됩니다. 이 때는 그룹에 대한 아이디가 함께 전달되어 추후 학교 친구를 찾을 때 사용하게 됩니다.</br><br>학번에 대한 정보를 저장할 때는 `iOS 16` 이상의 기기에서는 `sheetPresentationController`을 이용해서 하프 모달 뷰를 present하도록 구현했고 그 이하의 기기에서는 커스텀된 하프 모달뷰를 사용했습니다.|
|이름, 아이디 입력 부분|![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 21 47 09](https://github.com/team-yello/YELLO-iOS/assets/68178395/b6ccf293-11ca-4869-b308-d92299eb61b2)|이름과 아이디를 입력합니다. 정규식을 통해 이름은 한글만 입력할 수 있도록, 아이디는 소문자와 숫자,온점(.), 밑줄(_)만 입력이 가능하도록 제한했습니다. `UITextFieldDelegate`를 이용해서 텍스트필드의 입력이 끝났음을 감지하고 이외의 입력이 입력되었을 때는 TextField의 UI를 업데이트합니다. 서버 통신을 통해 아이디 중복성을 검사하여 아이디가 중복될 경우에는 에러 UI를 업데이트합니다. |
|카톡 친구 추가|![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 21 47 39](https://github.com/team-yello/YELLO-iOS/assets/68178395/50bf741e-4620-4fb9-b3cc-289e2c3d7c8d)|카카오 소셜 연결로 가져온 친구 목록 중 옐로에 가입한 친구들만 보이도록 API를 이용해서 검색하고 테이블 뷰를 이용해서 사용자에게 보여줍니다. 이때, 학교검색과 학과 검색에 사용한 무한 스크롤 방식을 이용해서 무한 스크롤을 구현했습니다.|
|추천인 코드|![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 21 47 59](https://github.com/team-yello/YELLO-iOS/assets/68178395/771f7593-fccc-45bc-ac0a-e18aeb736698)|추천인 코드를 입력하는 뷰입니다. 이전에 사용했던 ID 중복성 API를 이용해서 추천인 코드에 해당하는 ID가 존재하는지에 대해 검색하고 존재하는 아이디가 아닌 경우에는 에러 TextField UI로 업데이트합니다. 건너뛰기를 하게 되면 추천인 코드에는 빈 문장(””)아 입력되게 됩니다.|
|온보딩 완료 뷰|![Simulator Screen Recording - iPhone 13 mini - 2023-07-21 at 21 48 09](https://github.com/team-yello/YELLO-iOS/assets/68178395/5a9a7523-0335-4707-bf57-393e4660e8a9)|온보딩 완료 안내 화면입니다. Lottie를 이용해서 애니메이션을 구현하였습니다. 이전에 입력한 정보들은 User라는 싱글톤 객체에 저장이 되어 옐로하러가기 버튼을 클릭 시 서버에 POST로 전송됩니다. |

### 🍀 변희주
| 이름 | 스크린샷 | 설명 |
| :--------: | :--------: | :--------: |
| 뷰 부분 | 사진이나 gif 넣어주세요 | 뷰에 대한 설명 넣어주세요 |
| 뷰 부분 | 사진이나 gif 넣어주세요 | 뷰에 대한 설명 넣어주세요 |
| 뷰 부분 | 사진이나 gif 넣어주세요 | 뷰에 대한 설명 넣어주세요 |


## 🌠 Trouble Shooting
~~~
프로젝트를 진행하며 어려웠던 점에 대해 트러블 슈팅을 작성했습니다. 
~~~
[YELL:O iOS 트러블 슈팅](https://yell0.notion.site/YELL-O-iOS-564c1cd6e14547cb8ab742d5356fe142?pvs=4)

## 📸 합숙 중 사진
![81214B9F-DBF5-418C-8118-A973DB0EAC91_1_105_c](https://github.com/team-yello/YELLO-iOS/assets/109775321/8ee71661-a1dd-4d21-b7e0-ab9314dfbc70)

