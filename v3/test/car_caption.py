import cv2
from ultralytics import YOLO
import os
from pathlib import Path

#----------------------------------------------------------
# 1. 훈련된 best model 불러오기
# 2. 자막 생성하기 
#----------------------------------------------------------

# best_model 불러오기 
model = YOLO('best.pt') 


# 탐지된 모든 bbox 좌표들 중 가장 면적이 큰 bbox 고르기 
def give_me_max_key(num, test_results):
    wh = test_results[num].boxes.xywh[:, 2:4] # wh값만
    width = {}

    for i in range(len(wh)):
        width[i] = (wh[i][0]*wh[i][1]).item()
    
        max_width = sorted(width.values(), reverse=True)[0]

    for k, v in width.items():
        if v == max_width:
            max_k = k

            return max_k
        

# 자막 생성하기 
def car_caption(in_dir, out_dir):
    test_results = model(in_dir)
    fps = 30

    video_name = Path(in_dir).stem
    output_path = os.path.join(out_dir+'/'+video_name+'.mp4')
    out = cv2.VideoWriter(output_path,cv2.VideoWriter_fourcc(*'mp4v'), fps, (1280,720))

    for i in range(len(test_results)):
        word_key = give_me_max_key(i, test_results)
        test_result = test_results[i]
        box = test_result.boxes[word_key]
        word = test_results[i].names[box.cls[0].item()]

        img = test_result.plot()
        text=f'warning : {word}'
        font = cv2.FONT_HERSHEY_SIMPLEX # 글자 폰트
        fontSize = 1 # 글자 크기
        color = (0,255,0) # 글자 색
        thickness = 2 # 글자 굵기
        cv2.putText(img, text,(50,100), font, fontSize, color , thickness, cv2.LINE_AA)
        

        out.write(img)

    out.release()