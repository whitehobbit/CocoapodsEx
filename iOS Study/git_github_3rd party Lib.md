---
layout: post
title: git / github / Xcode Package Manager
tags: ios swift whitehobit git github Xcode_Package_Manager cocoapods Swift_Package_Manager
---
> 이 문서는 Xcode에서 git, github, Xcode Package Manager를 사용하는 방법을 다루고 있다.
>
> 작성자: *임하빈, 마지막 수정: 2017.01.11*

# git / github / Xcode Package Manager

**index**

{:toc}

## 1. Xcode에서 git과 github 사용하기 

> Xcode에서`git`과 `github`를 이용해 버전 컨트롤을 하는 방법을 알아본다.

### 1.1 Xcode에서 git 사용하기

Xcode에서 프로젝트 생성시 아래 그림과 같이 git에 체크해준다.

![Xcode에서 git 생성](https://github.com/whitehobbit/CocoapodsEx/blob/master/iOS%20Study/git.png?raw=true)

프로젝트 생성과 동시에 로컬 저장소를 이용하는 git과 바로 연동이 된다.

연동이 된 이후에는 Xcode 상단에 존재하는 메뉴바의 `Source Control` 탭에서 push, pull, commit 등이 가능하다.



### 1.2 Xcode의 로컬 git을 github로 옮기기

**github와 Xcode를 사용해 옮기기**

Xcode에서 프로젝트를 생성하고 로컬 git을 생성한 이후, github에 프로젝트명으로 새로운 리파지토리를 생성한다. 

생성된 원격 저장소의 http 주소를 복사하여 Xcode의 `preperence > account`에 새 저장소 추가로 추가한다.

이렇게 한 후, 로컬 git 사용과 동일하게 사용하면된다.

**SourceTree 어플리케이션 사용**

`SourceTree`는 `Atlassian`사의 git Client로 로컬 저장소와 원격 저장소를 사용하는 git을 관리할 수 있게 해주는 프로그램이다. 다운로드는  [SourceTree 공식 홈페이지][2] 여기서 받을 수 있다.

Xcode에서 프로젝트를 생성하고 로컬 git을 생성한 이후, `SouceTree`를 이용해 로컬 git을 불러오고 `Publish to remote`를 하고 github를 선택하면 된다. 



## 2. Xcode Package Manager

### 2.1 cocoapods

cocoapods은 `Podfile`에 추가하고자 하는 라이브러리의 목록을 작성하면, `Podfile`을 읽어 라이브러리를 추가한 `.xcworkspace` 파일을 생성해준다. 그 후 기존의 `.xcodeporj` 파일 대신 `.xcworkspace` 파일을 프로젝트 파일로 사용하면 된다.

**cocoapods 설치**

```shell
$ sudo gem install cocoapods
```

ruby가 설치되어 있지 않은 경우에는 cocoapods이 설치되지 않는다.

**cocoapods 사용**

먼저 Xcode 프로젝트를 생성하고, 터미널을 열어 프로젝트의 폴더로 들어가 `init` 명령어로 `Podfile`을 생성한다.

```shell
$ pod init
```

그 후, 생성된 `Podfile`을 열어 사용하고자 하는 라이브러리를 추가한다.

```
# 플랫폼 설정 ios, osx 등을 설정하고 뒷부분에는 버전을 쓴다. 
platform :ios, '10.0' 

#'프로젝트명' 부분에 자신의 프로젝트명 기입. pod setup을 했을 경우 자동 생성
target 'CocoapodsEx' do 
use_frameworks!
  # 추가하고자 하는 라이브러리를 다음과 같은 규칙을 적용해 작성한다.
  # 참고: https://guides.cocoapods.org/using/the-podfile.html
  # 로컬/네트워크 깃을 통해 라이브러리 추가: pod '라이브러리명', :git => '깃위치'
  # github를 사용해 라이브러리 추가: pod '라이브러리명', :git => '해당 라이브러리 깃허브 주소'
  # cocoapods에 등록된 라이브러리인 경우: pod '라이브러리명', '버전'
  pod 'Alamofire', '~> 4.0'
  pod 'SwiftyJSON', '~> 3.1'

  target 'CocoapodsExTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CocoapodsExUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

# swift 2.3 이상 추가 필요
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0.1'
        end
    end
end
```

`Podfile`을 작성한 후 `pod install` 명령어를 통해 라이브러리를 추가한다.

``` shell
$ pod insatll
```

라이브러리를 추가하는 작업은 꽤나 오래 걸리므로 기다리자. 라이브러리를 성공적으로 생성했다면 `.xcworkpace` 파일이 생성된다. 앞으로는 `.xcworkspace` 파일을 xcode 프로젝트 파일로 사용하면된다.

라이브러리가 업데이트 되었을 경우에는 `pod update` 명령어를 사용해 라이브러리를 업데이트 할 수 있다.

```shell
$ pod update
```



**참고 사이트**

[Cocoapods 공식 홈페이지][3]



### 2.2 Swift Package Manager

스위프트 패키지 매니저는 Apple이 공식적으로 지원하는 라이브러리 관리 툴로, 스위프트로 작성해서 사용한다.

(아직까지는 Mac용으로만 사용이 가능하며, iOS는 사용불가)

**스위프트 패키지 매니저 설치**

맥을 사용하는 경우, Xcode를 설치하게 되면 따로 설치할 필요는 없다.

**스위프트 패키지 매니저 사용법**

스위프트 패키지 매니저는 기본적으로 터미널을 통해 사용한다.(현재까지는 Xcode로 사용이 불가능하다.)

(1) Xcode로 프로젝트를 생성한 후, 해당 프로젝트 폴더에서 `swift pakage init` 명령어를 사용해 스위프트 패키지 매니저를 세팅한다.

``` shell
$ swift pakage init
```

정상적으로 init이 된 경우, 아래와 같이 `Package.swift`와 `Sources`와 `Tests`가 생성된 것을 볼 수 있다.

``` shell
Creating library package: Addrbook
Creating Package.swift
Creating .gitignore
Creating Sources/
Creating Sources/Addrbook.swift
Creating Tests/
Creating Tests/LinuxMain.swift
Creating Tests/AddrbookTests/
Creating Tests/AddrbookTests/AddrbookTests.swift
```

(2) 생성된 `Package.swift` 파일을 아래와 같이 수정한다.

``` swift
import PackageDescription

let package = Package(
	name: "Addrbook", // 프로젝트명 기입
	dependencies: [ // 프로젝트에 추가하고자 하는 라이브러리를 아래와 같은 형식으로 추가
      .Package(url: "https://github.com/Alamofire/Alamofire.git", majorVersion: 4, minor: 2),
      .Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", majorVersion: 3, minor: 1)
	]
)
```

`Package.swift` 파일을 작성했다면 build 명령어를 통해 해당 디펜던시를 다운로드 한다.

``` shell
$ swift build
```

정상적으로 디펜던시를 다운로드 했다면 아래와 같은 결과를 볼 수 있다.

```shell
Cloning https://github.com/Alamofire/Alamofire.git
HEAD is now at 7a17b1d Added release notes to the CHANGELOG and bumped the version to 4.2.0.
Resolved version: 4.2.0
Cloning https://github.com/SwiftyJSON/SwiftyJSON.git
HEAD is now at b85a064 Merge pull request #764 from lbrndnr/master
Resolved version: 3.1.4
Compile Swift Module 'SwiftyJSON' (1 sources)
Compile Swift Module 'Alamofire' (17 sources)
Compile Swift Module 'Addrbook' (1 sources)
```

(3) Xcode에서 개발할 수 있도록 `swift package generate-xcodeproj` 명령어를 사용해 `.xcodeproj` 파일을 생성한다.

``` shell
$ swift package generate-xcodeproj
```

제대로 생성되었다면 아래와 같은 결과가 나오며, `Addrbook.xcodeproj` 파일이 생성된다.

``` shell
generated: ./Addrbook.xcodeproj
```

(4) 생성된 `Addrbook.xcodeproj` 파일을 열어 `build setting`의 `Library Search Paths`에 `${PROJECT_DIR}` `recursive` 설정을 추가한다.

디펜던시가 업데이트되거나 디펜던시를 추가해야할 경우, `swift pakage update` 명령어를 사용한다.

**참고 사이트**

[Swift Package Manager 공식 홈페이지][4]

[Swift Package Manager 깃허브][5]

[1]:http://github.com/whitehobbit/cocoapodsEx	"소스 코드"
[2]:https://www.sourcetreeapp.com/	"SourceTree 공식 홈페이지"
[3]:https://cocoapods.org	"Cocoapods 공식 홈페이지"
[4]: https://swift.org/package-manager/	"Swift Package Manager 공식 홈페이지"
[5]:https://github.com/apple/swift-package-manager	"Swift Package Manager github"



