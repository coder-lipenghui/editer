import sys
from PIL import Image
if __name__ == "__main__":
    if len(sys.argv)>1:
        qlty=100
        filePath=sys.argv[1]
        if len(sys.argv) > 2:
            exportPath=sys.argv[2]
        if len(sys.argv) > 3 :
            exportName=sys.argv[3]
        if len(sys.argv) > 4 :
            exportSize=int(sys.argv[4])
        if len(sys.argv) >5 :
            qlty=int(sys.argv[5])
            qlty=qlty<1 and 1 or qlty
            qlty=qlty>100 and 95 or qlty
        Image.MAX_IMAGE_PIXELS=2300000000
        image = Image.open(filePath)
        width=image.size[0]
        height=image.size[1]
        c=1
        for x in range(0,width,exportSize):
            r=1
            for y in range(0,height,exportSize):
                w=exportSize
                h=exportSize
                if x+w>width:
                    w=width-x
                if y+h>height:
                    h=height-y
                # print("正在切图:",w,h,x+w,y+h)
                box=(x,y,x+w,y+h)
                region = image.crop(box)
                targetPath=exportPath+exportName+"_r"+str(r)+"_c"+str(c)+".jpg"
                print(targetPath)
                
                region.save(targetPath,quality=qlty)
                r=r+1
            c=c+1
    else:
        print("params error")
    
    
        
        

