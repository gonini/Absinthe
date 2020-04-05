# Absinthe
사진의 메타데이터를 편집하거나 제거할 수 있는 IOS 앱입니다.


# 구조
<img width="1186" alt="map" src="https://user-images.githubusercontent.com/24851448/78468953-5929e780-7757-11ea-8bf7-611e895c26f3.png">

### Main Module(Absinthe Module)
객체의 조립, 생명주기, 설정 값 등을 관리합니다.

### AbsintheUI Module
화면에 보여질 View에 대한 집합입니다. ViewModel에 의존적이며 이를 교체하여 테스트 하는 것은 고려 대상이 아닙니다.

### ViewModel Module
비즈니스 로직의 집합입니다. 이 모듈에서 작성되는 Reactor는 모두 테스트 가능한 형태로 작성되어야 합니다.

### Service Module
특정 프레임 워크나 API 등 저수준 구현에 대한 집합입니다. 해당 모듈을 주로 사용하는 것은 ViewModel이며, 실제 ViewModel에서 정의한 인터페이스를 구현합니다.
ViewModel이 아닌 곳에서 해당 Service 모듈의 기능을 필요로 한다면 신중히 고려해보아야합니다.
