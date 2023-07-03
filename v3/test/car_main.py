import argparse
from car_caption import car_caption
# car_caption.py = 비디오를 넣으면 객체 탐지 후 자막을 생성해주는 python 파일


# 테스트하고 싶은 비디오 주소, 결과를 저장할 주소 

def parse_args():
    parser = argparse.ArgumentParser(description = 'Object Eraser Arguments')

    parser.add_argument('--in_data', help='dir the video is saved', default='./input_video/car01.mp4')
    parser.add_argument('--out_dir', help='dir you want to save a file', default='./output_video')


    args = parser.parse_args()
    return args 


if __name__ == '__main__':
    args = parse_args()
    print(f'in_data = {args.in_data}')
    print(f'out_dir = {args.out_dir}')



    cc = car_caption(args.in_data, args.out_dir)
    # cc.run(in_data = args.in_data, 
    #        out_dir = args.out_dir)


#----------------------------------------------------------
# End of this file
#----------------------------------------------------------