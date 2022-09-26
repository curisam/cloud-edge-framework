# PoC of cloud-edge-framework

- 본 문서에서는 개발한 cloud-edge-framework 를 기반으로 PoC 수행 내용을 기술합니다.
- 한국전자기술연구원 (Korea Electronics Technology Institude)


## 목적 및 목표 
- 이기종의 에지 디바이스 연동 플랫폼 성능을 검증하는 것을 목적으로 합니다.
- AI hub의 개방 데이터셋을 활용하여 개발한 플랫폼을 시험합니다.

## 목표 일정
- 9월 22일 : 데이터 수집
- 9월 26일 : 데이터 수집 및 정제



## 2.4.2 사전 준비 : AI Hub 개방 데이터셋 다운로드

- AI Hub에 회원가입합니다.

```url
    https://aihub.or.kr/
```

- 가입 정보로 AI Hub에 로그인하고, "차로 위반 영상" 개방 데이터셋을 다운로드 합니다.
- 상기 데이터는 2021년 구축되었고, 본 PoC에서는 2022-07월 갱신된 버전을 사용했습니다.
- 상기 데이터의 규모는 286.69G입니다.
- 상기 데이터는 PoC의 목적에 맞게 차로 위반과 관련된 사진들과 pytorch model, docker file을 제공합니다.

<center>
<img src="img4doc/aihub_car.png">
</center>

## PoC 범위 (Scope)
- 전체 서비스 중에서 검토가 필요한 대상의 범위는 다음과 같습니다.

- [ ] 그룹별 에지노드 접속성 확인 기능

- 


## 제3장 PoC 결과


### 3.1 PoC 결과 요약




## 3.2 PoC 결과 상세

### 3.2.1 그룹별 에지노드 접속성 확인 기능

- 제어노드의 접속성 확인
<center>
<img src="img4doc/01.png">
</center>

- 다종의 라즈베리파이 에지노드의 접속성 확인
<center>
<img src="img4doc/02.png">
</center>

- 다종의 서버급(GPU 탑재) 에지노드의 접속성 확인
<center>
<img src="img4doc/03.png">
</center>

- 다종의 서버급(GPU 탑재) 및 라즈베리파이 에지노드의 운영체제 정보 확인
<center>
<img src="img4doc/03.png">
</center>



### 3.2.2 그룹별 에지노드 패키지 업데이트 및 업그레이드 수행 기능

- 다종의 라즈베리파이 에지노드의 패키지 업데이트 및 업그레이드 수행 확인
<center>
<img src="img4doc/11.png">
</center>

- 다종의 서버급(GPU 탑재) 에지노드의 패키지 업데이트 및 업그레이드 수행 확인
<center>
<img src="img4doc/12.png">
</center>


### 3.2.3 그룹별 에지노드 시간 동기화 기능

- 다종의 라즈베리파이 에지노드의 시간동기화 수행 확인
<center>
<img src="img4doc/21a.png">
</center>

<center>
<img src="img4doc/21b.png">
</center>

- 다종의 서버급(GPU 탑재) 에지노드의 시간동기화 수행 확인

<center>
<img src="img4doc/22a.png">
</center>

<center>
<img src="img4doc/22b.png">
</center>


### 3.2.4 모니터링 기능

- 다종의 라즈베리파이 및 다종의 서버급(GPU 탑재) 에지노드의 CPU 온도 측정 기능 확인
<center>
<img src="img4doc/31.png">
</center>

- 다종의 라즈베리파이 및 다종의 서버급(GPU 탑재) 에지노드의 CPU 정보 수집 기능 확인
<center>
<img src="img4doc/32.png">
</center>

- 다종의 라즈베리파이 및 다종의 서버급(GPU 탑재) 에지노드의 Memory 정보 수집 기능 확인
<center>
<img src="img4doc/33.png">
</center>

- 다종의 라즈베리파이 에지노드의 네트워크 업링크/다운링크 속도 측정 기능 확인
<center>
<img src="img4doc/34.png">
</center>

- 다종의 서버급(GPU 탑재) 에지노드의 네트워크 업링크/다운링크 속도 측정 기능 확인
<center>
<img src="img4doc/35.png">
</center>

- CUDA 지원 GPU 탑재된 에지노드의 GPU 정보 수집 (아래 이미지에서 w01은 GPU SW 환경이 구축된 경우이고, p01은 GPU 사용을 위한 SW환경이 구축되지 않은 경우임)
<center>
<img src="img4doc/36.png">
</center>



### 3.2.5 모델 다운로드 및 docker 빌드 기능

- AI Hub에서 다운로드 받은 모델을 모델 리포지토리에 탑재

<center>
<img src="img4doc/40.png">
</center>


- 에지노드에 모델 리포지토리의 aihub_model.zip을 배포

<center>
<img src="img4doc/41.png">
</center>



- 에지노드에 docker 설치를 위한 파일 전송

<center>
<img src="img4doc/42.png">
</center>

















## PoC 실시 내용
- 구체적으로 검증할 내용은 다음과 같습니다.

1. 상기 Scope 섹션에서 결정한 AI Hub의 개방 데이터셋을 활용 하여, 개발한 cloud-edge-framework의 통합 동작을 확인합니다.

2. 개발한 cloud-edge-framework의 세부 기능 동작을 확인합니다.


#### 시스템 환경
- 필요한 기능, 데이터, 인프라, 시스템 구성도는 다음과 같습니다.

1. 필요한 기능은 분산연합학습을 수행하는 것입니다.

2. 시스템 구성도는 다음과 같습니다. 

TODO






#### 추진체제 및 역할 분담
- 준비 사항 및 역할을 분담 상황은 다음과 같습니다.

- 준비한 하드웨어 시스템

- 역할 분담



#### 관리 및 운영 방법

- 회의체의 정의, 기타 커뮤니케이션 규칙, 진척 관리 등의 프로젝트 관리 방침은 다음과 같습니다.

- github을 기반으로 작업내역을 버전관리하고, 이슈를 공유합니다.

- 개발자들의 구체적인 진척관리는 프로젝트 매니저 (과제 책임자)가 github 내용을 검토 후 개발자들에게 온라인/오프라인으로 수행합니다.

- 개발은 TDD(Test Driven Developement)나 애자일(agile) 철학을 지향합니다.

- 필요한 기능을 단시간에 개발하고, 검토하고, 수정합니다. 이를 지속적으로 반복합니다.

- 새로운 요구사항 발생 시 민첩하게 대응합니다.


## 참고 문헌 및 개념 설명

### PoC ?

- 기존 시장에 없었던 신기술을 도입하기 전에 이를 검증하기 위해 사용하는 것을 뜻한다. 특정 방식이나 아이디어를 실현하여 타당성을 증명하는 것을 뜻한다.

  . 출처 : https://ko.wikipedia.org/wiki/개념_증명

- 개념 증명, 槪念證明, Proof Of Concept, POC
제품, 기술, 정보 시스템 등이 조직의 특수 문제 해결을 실현할 수 있다는 증명 과정. 아직 시장에 나오지 않은 신제품에 대한 사전 검증을 위해 사용된다.

  . 출처 : http://terms.tta.or.kr/mobile/dictionaryView.do?word_seq=053088-1



#### 참고 : AI Hub 데이터셋 특징

- [x] 데이터분야 / 차로 위반 영상 : 2022-07월 갱신, 2021년 구축, 286.69G, 
- [x] 이미지 / 상품 이미지 : {과자, 디지터, 면류, 소스, 의약품, ...} 등의 상품 이미지 분류, 분류문제
- [x] 이미지 / 차량 이미지 : 차종 판별에 중점을 두고 있음, 분류 문제
- [x] 이미지 / 한국어 글자체 이미지 : 손글씨 등의 글자체 인식 기술 개발용, 글자인식
- [x] 이미지 / 한국인 감정인식을 위한 복합 영상 데이터, 영상내 얼굴을 비롯한 다중 영역을 태깅하여 사람의 감정 상태 추정용, 감정 분류 문제
- [x] 자율주행 / 위성영상 객체판독, 영상내 객체 영역 검출, 객체 클래스 분류




### 주요 참고문헌

```bibtex
@article{mathur2021device,
  title={On-device federated learning with flower},
  author={Mathur, Akhil and Beutel, Daniel J and de Gusmao, Pedro Porto Buarque and Fernandez-Marques, Javier and Topal, Taner and Qiu, Xinchi and Parcollet, Titouan and Gao, Yan and Lane, Nicholas D},
  journal={arXiv preprint arXiv:2104.03042},
  year={2021}
}
```
