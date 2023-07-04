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
<<<<<<< HEAD
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
    
6. Then
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
┃ ┃
┃ ┣ 📂 Resources
┃ ┃ ┣ 📂 Font
┃ ┃ ┣ 📜 Font
┃ ┃ ┣ 📜 Color
┃ ┃ ┣ 📜 Assets
┃ ┃ ┣ 📜 Info.plist
┃ ┃
┃ ┣ 📂 Protocols
┃
┣ 📂 Presentation
┃ ┣ 📂 Base
┃ ┣ 📂 Onboarding
┃ ┃ ┃ ┣ 📜 ViewController
┃ ┃ ┃ ┣ 📜 Views
┃ ┃ ┃ ┣ 📜 Cells
┃ ┣ 📂 Recommending
┃ ┣ 📂 Voting
┃ ┣ 📂 MyYello
┃ ┣ 📂 Profile
┃
┣ 📂 Network
┃ ┣ 📂 Base
┃ ┣ 📂 Onboarding
┃ ┃ ┃ ┣ 📜 DTO
┃ ┃ ┃ ┣ 📜 Router
┃ ┃ ┃ ┣ 📜 Service
┃ ┣ 📂 Recommending
┃ ┣ 📂 Voting
┃ ┣ 📂 MyYello
┃ ┣ 📂 Profile
```

