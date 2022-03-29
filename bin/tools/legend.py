import os
import sys
from telnetlib import theNULL
from PIL import Image
if __name__ == "__main__":
    '''
    使用pyinstaller生成exe文件:pyinstaller -F -i icon.ico -legend.py
    生成Legend私服资源，资源会按照中心点位置生成到1024*1024的新图片上
    '''
    #error  https://cn.dll-files.com/api-ms-win-core-path-l1-1-0.dll.html
    #root="C:/Users/lipenghui/Desktop/test/测试资源/monster/Mon205" #sys.argv[1]
    root=sys.argv[1]
    batch=False
    if len(sys.argv)>2:
        batch=int(sys.argv[2])>0
    roots=[]
    # if not os.path.exists(root+"/Placements"):
    #     print("不存在Placements目录")
    #     exit(1)
    if batch :
        tmp=os.listdir(root)
        for folder in tmp:
            if os.path.isdir(root+"/"+folder) :
                roots.append(root+"/"+folder)
    else:
        roots.append(root)
    for folder in roots:
        print("===>:"+folder)
        imgs=os.listdir(folder)
        for img in imgs:
            imgPath=folder+"/"+img
            if os.path.isfile(imgPath) and img.upper().endswith(".PNG"):
                with Image.open(imgPath) as im:
                    w=im.size[0]
                    h=im.size[1]
                    if w>1 and h>1:
                        txt=img.split(".")[0]
                        txtPath=folder+"/Placements/"+txt+".txt"
                        if os.path.exists(txtPath):
                            f = open(txtPath,"r")
                            fileStr = f.read()
                            f.close()
                            xy=fileStr.split("\n")
                            x=str(xy[0])
                            y=str(xy[1])
                            newImg=Image.new("RGBA",[1024,1024])
                            newImg.paste(im,[512+int(x),512+int(y)])
                            newImgPath=folder+"/Gen/"
                            if not os.path.exists(newImgPath):
                                os.mkdir(newImgPath)
                            newImg.save(newImgPath+img)
                            newImg=NULL
                            # print("done:"+newImgPath+img)

                
