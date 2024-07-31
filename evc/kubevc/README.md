# KubEVC
Kubernetes를 활용한 클러스터 구축 및 모델 배포 파이프라인 구축을 위한 모듈<br>
기존의 직접통신 방식과 더불어 별도의 프로파일로 적용해 활용

## 구성
모듈 동작에 필요한 핵심 요소


### 노드 구성
1. Agent node<br>

   원격에서 kubevc 스크립트를 배포하는 노드<br>
   클러스터와 직접적인 연관이 없음
   
3. Master node<br>

   kubevc cluster의 control-plane 역할을 하는 노드
   
4. Worker node<br>

   kubevc cluster에서 runtime을 할당받아 수행하는 역할을 하는 노드



### 구동 스크립트
k8s 환경 구성, 노드 간 인증 절차, 클러스터 구성 및 모델 배포 등의 절차를 자동화한 셸 스크립트<br>

```
1. env set up & key share script
2. k8s cluster initializing script
3. Ingress & Load-balancer deployment script
4. AI model deployment script
```

### Ansible Playbooks
클러스터 구축 절차에서 필요한 명령 전달 및 원격 구동을 위한 ansible 스크립트

```
## playbooks path
cd kubevc/ansible_assets/
```

## Get started with KubEVC
k8s 프로파일을 활용하여 EVC를 구성하고 모델을 배포하기 위한 튜토리얼 가이드라인

### 1. 사전 작업
1. 노드 원격 통신을 위한 Ansible 패키지 다운로드
   >수행 위치 : Agent Node
   
   ```
   pip install ansible
   ```
   
3. k8s 설치 및 환경 구성을 위한 자동화 스크립트 배포
   >수행 위치 : Master Node, Worker Node
   
   ```
   ## 스크립트는 파일 서버에 업로드 후 별도 관리
   wget evc.re.kr:20096/www/1_environment_setup_localhost.sh

   ## run script
   bash 1_environment_setup_localhost.sh
   ```

### 2. 클러스터 구축
### 3. Ingress, Load Balancer 배포
### 4. EVC 학습모델 배포
