#coding:utf-8
import os
import os.path
import shutil
comp=[9,9,13,8,7,3,4,7,11,18]
compFolder=["待机","走路","跑步","攻击","施法","受伤","死亡","采集","技能1","技能2"]
dir=8
# newRootPath="/Users/lipenghui/CodeZ/design/original/主角/外观/女_8/"
# rootPath="/Users/lipenghui/CodeZ/design/original/主角/外观/女/"
newRootPath="/Users/lipenghui/CodeZ/design/original/主角/武器/女_8/"
rootPath="/Users/lipenghui/CodeZ/design/original/主角/武器/女/"
rootFiles=sorted(os.listdir(rootPath))
for rootFile in rootFiles:
	if os.path.basename(rootFile)==".DS_Store":
		continue
	if not os.path.exists(newRootPath+rootFile):
		os.mkdir(newRootPath+rootFile)
	targetPath=rootPath+rootFile+"/"
	newTargetPath=newRootPath+rootFile+"/"
	files=sorted(os.listdir(targetPath))
	for file in files:
		if os.path.basename(file)==".DS_Store" or os.path.basename(file)=="Thumbs.db" or os.path.basename(file)=="00000.png":
			files.remove(file)
	total =89
	compLen=len(comp)
	if len(files)<712:
		total=71
		compLen=len(comp)-1
	for x in xrange(0,8):
		tmp=0
		for j in xrange(0,compLen):
			folder=compFolder[j]
			# targetFolder=targetPath+"/"+folder
			newFolder=newTargetPath+"/"+folder
			# if not os.path.exists(targetFolder):
			# 	os.mkdir(targetFolder)
			if not os.path.exists(newFolder):
				os.mkdir(newFolder)
			for n in xrange(0,comp[j]):
				id=x*total+tmp+n
				print targetPath+files[id]
				shutil.copyfile(targetPath+files[id],newFolder+"/"+files[id])
			tmp=tmp+comp[j]
