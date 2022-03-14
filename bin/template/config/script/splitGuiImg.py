#coding:utf-8
import os
import os.path
import Image

if __name__ == '__main__':
	# cellW=512
	# cellH=512
	# root="D:/CodeX/design/CodeXResource/original/map/"
	# mapId="v001"
	path="C:/Users/Administrator/Desktop/UI/"
	imgName="clip_zhanhun_se"
	imgType=".png"
	direction=1 # 1 横向 2 纵向
	frame=9
	mapRes=Image.open(path+imgName+imgType)
	size=mapRes.size
	#print(size[0],size[1])
	# row=size[0]/cellH
	# col=size[1]/cellW
	# if not os.path.isdir(root+mapId):
	os.mkdir(path+imgName)
	cellW=size[0]
	cellH=size[1]
	if direction==1:
		cellW=size[0]/frame
	else:
		cellH=size[1]/frame
	for i in xrange(0,frame):
		cell=None
		x=0
		y=0
		if direction==1:
			x=i*cellW	
			cell=mapRes.crop((x,0,x+cellW,cellH))
		else:
			y=i*cellH
			cell=mapRes.crop((0,y,cellW,y+cellH))
		mapCell=Image.new("RGBA",cell.size)
		mapCell.paste(cell,(0,0,cellW,cellH))
		mapCell.save(path+imgName+"/"+str(i)+".png")