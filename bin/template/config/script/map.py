#coding:utf-8
import os
import os.path
import Image

if __name__ == '__main__':
	cellW=512
	cellH=512
	root="D:/CodeX/design/CodeXResource/original/map/"
	mapId="v001"
	path=root+mapId+".jpg"
	mapRes=Image.open(path)
	size=mapRes.size
	#print(size[0],size[1])
	row=size[0]/cellH
	col=size[1]/cellW
	if not os.path.isdir(root+mapId):
		os.mkdir(root+mapId)
	for i in xrange(0,col):
		for j in xrange(0,row):
			y=i*cellH
			x=j*cellW
			print(x,y,cellH,cellW)
			cell=mapRes.crop((x,y,x+cellW,y+cellH))
			mapCell=Image.new("RGB",cell.size)
			mapCell.paste(cell,(0,0,cellW,cellH))
			mapCell.save(root+mapId+"/"+mapId+"_r"+str(i+1)+"_c"+str(j+1)+".jpg")