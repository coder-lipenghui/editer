package view.object 
{
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import editor.manager.CatalogManager;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameObject
	{
		private var _id:int = 0;
		private var _path:String = "";
		private var _currAction:String = "";
		private var _currCatalogId:int = -1;
		private var _actInfo:Object = new Object;
		private var _sourceBmd:BitmapData = null;
		private var _parent:BitmapData = null;
		private var _pos:Point = null;
		private var _frameCount:int = 0;
		private var _currFrame:int = 0;
		private var _once:Boolean = true;
		private var _repeat:Boolean = false;
		private var _dir:int = 4;
		public function GameObject() 
		{
			super();
		}
		/**
		 * 直接转到某个方向
		 * @param	value
		 */
		public function changeDir(value:int):void 
		{
			_dir = value;
			draw(_parent,_pos,_dir,_currFrame);
		}
		/**
		 * 向左或向右转向
		 * @param	type 0向右 1向左
		 */
		public function turn(type:int):void 
		{
			if (type) 
			{
				_dir--;
			}else{
				_dir++;
			}
			_dir = _dir < 0?7:_dir;
			_dir = _dir > 7?0:_dir;
			draw(_parent,_pos,_dir,_currFrame);
		}
		
		/**
		 * 显示资源
		 * @param	id 动作ID 例：00| 01| 02| 03
		 * @param	name 例：新手衣服(1000)
		 */
		public function show(background:BitmapData,pos:Point,id:int,name:String,action:String,catalogId:int):void 
		{	
			_parent = background;
			_id = id;
			_pos = pos;
			_currCatalogId = catalogId;
			_currAction = action;
			_path = ProjectConfig.libraryPath + CatalogManager.instance.getAbsolutePath(catalogId) + "/" + name+"("+id+")"+"/export/" + action;
			loadRes();
		}
		private function loadRes():void 
		{
			App.loader.loadBMD(_path + ".png",new Handler(handlerComplete),null,new Handler(handlerLoadError),false);
		}
		private function handlerComplete(bmd:BitmapData):void
		{
			if (bmd) 
			{
				_sourceBmd = bmd;
				getAnimateInfo();
				draw(_parent,_pos,_dir, 0);
			}
		}
		private function handlerLoadError(msg:*):void 
		{
			//trace("资源加载失败，开始在资源库中尝试查找同id的资源...");
			var folder:File = File.applicationDirectory.resolvePath(ProjectConfig.libraryPath + CatalogManager.instance.getAbsolutePath(_currCatalogId));
			if (folder.exists) 
			{
				var resources:Array = folder.getDirectoryListing();
				for each(var resource:File in resources)
				{
					if (resource.name.indexOf("("+_id+")")>-1) 
					{
						_path = resource.nativePath + "/export/" + _currAction;
						trace("加载资源:",_path+".png");
						App.loader.loadBMD(_path + ".png",new Handler(handlerComplete),null,new Handler(handlerLoadError),true);
					}
				}
			}else{
				trace("资源库中未找到id为:",_id,"的资源(",folder.nativePath,")");
			}
		}
		public function play(repeat:Boolean = false):void 
		{
			_currFrame = 0;
			_once = !repeat;
			_repeat = repeat;
			var frame:int = 25;// int(PropertyFrameView.instance.txt_gameframe.text);
			if (frame<=0) 
			{
				frame = 1;
			}
			if (frame>40) 
			{
				frame = 40;
			}
			App.timer.doLoop(1 / frame * 1000, doActionPlay);
		}
		
		private  function getAnimateInfo():void 
		{
			var file:File = File.applicationDirectory.resolvePath(_path+".bin");
			if (file.exists) 
			{
				var ba:ByteArray = new ByteArray();
					ba.endian = Endian.LITTLE_ENDIAN;
				var binStream:FileStream = new FileStream();
					binStream.open(file, FileMode.READ);
					binStream.readBytes(ba);
					binStream.close();
				var dirCount:int = ba.readByte();  	// 方向数
				ba.readByte();  					// 暂时无用
				var imgNum:int=ba.readByte(); 		// 图片数量
				var frameCount:int = 0;
				var keyFrameData:Array = [];
				var frameData:Array = [];
				
				for (var i:int = 0; i < imgNum; i++) 
				{
					var temp:int=ba.readByte();
					keyFrameData[i] = temp;
					frameCount += temp;
				}
				_actInfo.dirCount = dirCount;
				_actInfo.frameCount = frameCount;
				_frameCount = frameCount;
				i = 0;
				try 
				{
					for (i; i < dirCount; i++)
					{
						var index:int = 0; //单方向素材的帧信息
						frameData[i] = new Array;
						for (var j:int = 0; j < imgNum; j++)
						{
							var id:int = (i * imgNum) + j;
							var x:int=ba.readShort();
							var y:int=ba.readShort();
							var w:int=ba.readShort();
							var h:int=ba.readShort();
							var cx:int=ba.readShort();
							var cy:int=ba.readShort();
							var rotated:int = ba.readShort();
							for (var k:int = 0; k < keyFrameData[j]; k++) 
							{
								frameData[i][index] = new Array();
								frameData[i][index][0]=(x);
								frameData[i][index][1]=(y);
								frameData[i][index][2]=(w);
								frameData[i][index][3]=(h);
								frameData[i][index][4]=(cx);
								frameData[i][index][5]=(cy);
								frameData[i][index][6]=(rotated);
								index++;
							}
						}
					}
					_actInfo.frameData = frameData;
				}catch (err:Error)
				{
					trace("出现异常");
				}
			}else
			{
				trace("不存在文件:",file.nativePath);
			}
		}
		private function draw(bmd:BitmapData,targetPoint:Point,dir:int,currFrame:int):void
		{
			if (!bmd) 
			{
				return;
			}
			var result:BitmapData = null;
			var frameData:Array = _actInfo.frameData;
			var flipX:Boolean = false;
			if (dir>4) 
			{
				flipX = true;
				dir = 8 - dir;
			}
			if (frameData&&frameData.length>0)
			{
				if (frameData[dir]&&frameData[dir][currFrame]) 
				{
					var x:int = frameData[dir][currFrame][0];
					var y:int = frameData[dir][currFrame][1];
					var w:int = frameData[dir][currFrame][2];
					var h:int = frameData[dir][currFrame][3];
					var cx:int = frameData[dir][currFrame][4];
					var cy:int = frameData[dir][currFrame][5];
					var rotated:int = frameData[dir][currFrame][6];
					
					var rect:Rectangle = null;
					var pt:Point = new Point();
					var pt1:Point = new Point();
					bmd.fillRect(new Rectangle(0, 0, 1000, 1000), 0xFF0000);
					
					var distanceX:int = 0;
					pt.x = cx + (targetPoint.x);
					pt.y = cy + (targetPoint.y);
					if (rotated &&_sourceBmd)
					{
						rect = new Rectangle(x, y, h, w);
						result = new BitmapData(h, w);
						result.copyPixels(_sourceBmd, rect, new Point());
						var m:Matrix = new Matrix(); 
						m.rotate( -Math.PI / 2);
						pt.y = cy +h+ (targetPoint.y);
						m.translate(pt.x, pt.y);
						if (flipX) 
						{
							m.c =-1;
							m.tx = targetPoint.x - cx;
						}
						bmd.draw(result, m);
					}
					else
					{
						rect = new Rectangle(x, y, w, h);
						pt1 = new Point(x, y);
						if (_sourceBmd) 
						{
							if (flipX) 
							{
								result = new BitmapData(w,h);
								result.copyPixels(_sourceBmd, rect,new Point());
								m = new Matrix();
								m.translate(pt.x,pt.y);
								m.a =-1;
								m.tx = targetPoint.x - cx;
								bmd.draw(result,m);
							}else{
								bmd.copyPixels(_sourceBmd, rect,pt,_sourceBmd,pt1);
							}
						}else {
							App.log.error("targetBmd不存在");
						}
					}
				}
			}
		}
		/**
		 * 播放的具体入口
		 */
		private function doActionPlay():void 
		{
			//if (avatar.length==0) 
			//{
				//return;
			//}
			var count:int = _actInfo.frameCount;
			//for (var i:int = 0; i <avatar.length ; i++) 
			//{
				//if (i==3) 
				//{
					//continue;
				//}
				//var resid:int = 0;
				//var path:String = avatar[i].path;
				//if (i == 0) resid = _cloth;
				//if (i == 1) resid = _weapon;
				//if (i == 2) resid = _wing;
				//if (avatar[i].frameCount>0) 
				//{
					draw(_parent,_pos,_dir,_currFrame);//目前装备，武器，翅膀的总帧数必须相同。
				//}
			//}
			_currFrame++;
			if (_currFrame>count) 
			{
				if (_once) 
				{
					////动作播放完后 是否回到第一帧。
					_currFrame = 0;
					//for (i = 0; i <avatar.length ; i++) 
					//{
						//if (i == 3) continue;
						//resid = 0;
						//path = avatar[i].path;
						//if (i == 0) resid = _cloth;
						//if (i == 1) resid = _weapon;
						//if (i == 2) resid = _wing;
						//if (avatar[i].frameCount>0)
						//{
							draw(_parent,_pos,_dir,_currFrame);
						//}
					//}
					App.timer.clearTimer(doActionPlay);
					return;
				}
				else if (_repeat)
				{
					_currFrame = 0;
				}
			}
		}
	}

}