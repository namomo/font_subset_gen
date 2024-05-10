# 폰트 서브셋 생성

## 가상 환경 및 패키지 설치

```bash
source .venv/bin/activate
pip install -r requirements.txt
```

## 실행

- generate.sh 파일의 GLYPHS 지정. 기본 TetraTheta-glyphs 사용
- fonts 디렉토리에 있는 폰트파일을 읽어 dist 디렉토리에 서브셋 ttf, woff, woff2 생성
