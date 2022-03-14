package editor.tools 
{
	
	
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.display.PNGEncoderOptions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import editor.configuration.MapDesp;
	import editor.manager.MementoManager;
	import flash.geom.Point;
	import view.window.MapEdit;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class MapTools 
	{
		//接收方
		//执行对应的操作
		//private var _logicCell:Array = null;
		private var _map:MapEdit;
		private var _inited:Boolean = false;
		public function MapTools(map:MapEdit = null)
		{
			_map = map;
		}
		/**
		 * 直线填充
		 * 依据bresenham算法
		 * @param	sx 起始x
		 * @param	sy 起始y
		 * @param	ex 结束x
		 * @param	ey 结束y
		 */
		public function drawLine(sp:Point,ep:Point,type:int):void
		{
			var original:Dictionary = new Dictionary;
			if (!_map) return;
			var x:int = 0;
			var y:int = 0;
			var dx:int = 0;
			var dy:int = 0;
			var unitx:int = 0;
			var unity:int = 0;
			var fabs_dx:int = 0;
			var fabs_dy:int = 0;
			var e:int = 0;
			var i:int = 0;
			dx=ep.x-sp.x;
			dy=ep.y-sp.y;
			fabs_dx = Math.abs(dx);
			fabs_dy = Math.abs(dy);
			unitx = dx / fabs_dx ;
			unity = dy / fabs_dy ;
			x=sp.x;
			y = sp.y;
			if( fabs_dx> fabs_dy )
			{
				e=-fabs_dx;
				for(i=0;i<=fabs_dx;i++)
				{
					if (!original[y]) 
					{
						original[y] = new Dictionary;
					}
					original[y][x] = _map.mapDesp.logicCell[y][x];
					var tmp:int = fixDrawType(type, x, y);
					_map.mapDesp.logicCell[y][x] = tmp;
					x+=unitx,e=e+2*fabs_dy;
					if(e>=0)
					{
						y+=unity;e=e-2*fabs_dx;
					}
				}
			}
			else
			{
				e-=fabs_dy;
				for(i=0;i<=fabs_dy;i++)
				{
					if (!original[y]) 
					{
						original[y] = new Dictionary;
					}
					original[y][x] = _map.mapDesp.logicCell[y][x];
					tmp = fixDrawType(type, x, y);
					_map.mapDesp.logicCell[y][x] = tmp;
					y+=unity,e=e+2*fabs_dx;
					if(e>=0)
					{
						x+=unitx;e=e-2*fabs_dy;
					}
				}
			}
			backup(original);
		}
		/**
		 * 矩形填充
		 * @param	sp
		 * @param	ep
		 */
		public function drawRect(sp:Point,ep:Point,type:int):void 
		{
			if (!_map) return;
		}
		/**
		 * 单个格子
		 * @param	p
		 * @param	type
		 */
		public function drawOne(p:Point,type:int):void 
		{
			if (!_map) return;
			if (_map.mapDesp.logicCell[p.y] && _map.mapDesp.logicCell[p.y][p.x]>=0) 
			{
				var original:Dictionary = new Dictionary;
				if (!original[p.y]) 
				{
					original[p.y] = new Dictionary;
				}
				original[p.y][p.x] = _map.mapDesp.logicCell[p.y][p.x] ;
				var tmp:int = fixDrawType(type,p.x,p.y);
				_map.mapDesp.logicCell[p.y][p.x] = tmp;
				backup(original);
			}else{
				trace("不存在:",p.x,p.y);
			}
		}
		/**
		 * 填充
		 * @param	p
		 */
		public function drawFill(p:Point,type:int):void 
		{
			var original:Dictionary = new Dictionary;
			var openlist:Array = [];
			try 
			{
				floodFill4(p.x, p.y, type, openlist,original);
			}catch (err:Error)
			{
				App.log.error("填充出现异常,可ctrl+z撤销");
			}
			openlist = null;
			backup(original);
		}
		/**
		 * 填充某个坐标上下左右4个格子
		 * @param	x
		 * @param	y
		 * @param	type
		 */
		private function floodFill4(x:int,y:int,type:int,openlist:Array,original:Dictionary):void 
		{
			if (!openlist[x]) 
			{
				openlist[x] = new Array;
			}
			//边界检测、类型检测、剔除已遍历过的坐标
			if (x >= 0 && y >= 0 && x < _map.mapDesp.mapCellH 
				&& y < _map.mapDesp.mapCellV 
				&& (!openlist[x] || !openlist[x][y])
				&& _map.mapDesp.getLogicInfo(x,y)==0) 
			{
				if (!original[y]) 
				{
					original[y] = new Dictionary;
				}
				original[y][x] = _map.mapDesp.logicCell[y][x];
				_map.mapDesp.logicCell[y][x]=openlist[x][y] = type;
				floodFill4(x + 1, y,type,openlist,original);
				floodFill4(x - 1, y,type,openlist,original);
				floodFill4(x,y + 1, type,openlist,original);
				floodFill4(x,y - 1, type,openlist,original);
			} 
		}
		private function fixDrawType(type:int,x:int,y:int):int
		{
			var result:int = type;
			if (_map && _map.mapDesp && _map.mapDesp.logicCell[y] && _map.mapDesp.logicCell[y][x]==2) 
			{
				if (type==4) 
				{
					result = 6;
				}
			}
			return result;
		}
		/**
		 * 撤销操作
		 */
		public function revocation():void 
		{
			if (!_map) return;
			var temp:Dictionary = MementoManager.pop();
			if (temp) 
			{
				for (var i:String in temp)
				{
					var temp1:Dictionary = temp[int(i)];
					for (var j:String in temp1) 
					{
						var type:int = temp1[int(j)];
						_map.mapDesp.logicCell[int(i)][int(j)] = type;
					}
				}
				_map.drawLogic();
			}
		}
		public function backup(dic:Dictionary):void 
		{
			if (!_map) return;
			_map.drawLogic();
			MementoManager.add(dic);
		}
		public static function exportMiniMap(bmd:BitmapData, mapId:String):void
		{
			var miniW:int = 660;
			var miniH:int = 520;
			var a:Number =  660/bmd.width;
			var d:Number = 520/bmd.height;
			var miniBmd:BitmapData = new BitmapData(miniW, miniH);
			var matrix:Matrix = new Matrix();
			matrix.scale(a, d);
			miniBmd.draw(bmd, matrix);
			var path:String = ProjectConfig.assetsPath + "/minimap/";
			SaveNewImg(miniBmd, path, mapId);
		}
		
		public static function exportMap(bmd:BitmapData,mapId:String):void 
		{
			if (true)
			{
				var row:int = bmd.width / ProjectConfig.GROUND_W;
				var cow:int = bmd.height / ProjectConfig.GROUND_H;
				var total:int = row * cow;
				
				var shu:Boolean = false;
				var heng:Boolean = false;
				if (bmd.width % ProjectConfig.GROUND_W!=0)
				{
					row = row + 1;
					shu = true;
				}
				if (bmd.height % ProjectConfig.GROUND_H!=0)
				{
					cow = cow + 1;
					heng = true;
				}
				for (var h:int = 0; h < cow; h++)
				{
					for (var w:int = 0; w < row; w++ )
					{
						var ww:int = ProjectConfig.GROUND_W;
						var hh:int = ProjectConfig.GROUND_H;
						var xx:int = w * ProjectConfig.GROUND_W;
						var yy:int = h * ProjectConfig.GROUND_H;
						if (shu)
						{
							if ((row - 1) == w)
							{
								ww = bmd.width - w * ProjectConfig.GROUND_W;
							}
						}
						if (heng)
						{
							if ((cow - 1) == h)
							{
								hh = bmd.height - h * ProjectConfig.GROUND_H;
							}
						}
						if (ww >0 && hh>0) 
						{
							var _clip:BitmapData = new BitmapData(ww,hh, true);
							var _rect:Rectangle = new Rectangle(xx, yy,ww, hh);
							var _point:Point = new Point(0, 0);
							var _alphaPoint:Point = new Point(xx, yy);
							//_clip.copyPixels(bmd, _rect, _point,bmd, _alphaPoint);
							var matrix:Matrix = new Matrix(1, 0, 0, 1, -xx, -yy);
							_clip.draw(bmd, matrix);
							var name:String = "_r" +(h + 1) + "_c" +  (w + 1);
							var path:String = ProjectConfig.assetsPath + "/map/" + mapId;
							SaveNewImg(_clip, path + "/" + mapId, name);
							_clip.dispose();
							_clip = null;
						}else
						{
							App.log.debug("<font color='#FF0000'>错误:" + name+"</font>");
						}
					}
				}
			}
			
			App.log.info("地图导出成功");
		}
		private static function SaveNewImg(bitmapdata:BitmapData,path:String,name:String,type:String="jpg"):void 
		{
			var compressor:*= type == "jpg"?new JPEGEncoderOptions(100):new PNGEncoderOptions(true);
			var bmd:BitmapData = bitmapdata;
			var byteArray:ByteArray = bmd.encode(bmd.rect,compressor);
			
			var temp:String = path+name+"."+type;
			App.log.debug("资源路径:"+temp);
			var file:File = new File(File.applicationDirectory.resolvePath(temp).nativePath);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(byteArray);
			fs.close();
			fs = null;
			file = null;
			//bmd.dispose();
			byteArray = null;
		}
	}

}