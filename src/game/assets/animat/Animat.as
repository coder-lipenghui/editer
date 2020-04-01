package game.assets.animat 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 3464285@gmail.com
	 */
	public class Animat 
	{
		private var _frameInfo:Array = [];
		private var _dir:int = 0;
		private var _currFrame:int = 0;
		private var _resId:int = 0;
		
		private var _width:int = 0;
		private var _height:int = 0;
		
		private var _modules:Array = [];
		
		//TODO 显示组建及顺序需要挪到xml配置项中去
		private static var GROUP_CLOTH:int = 0;
		private static var GROUP_WEAPON:int = 1;
		private static var GROUP_WING:int = 2;
		
		private static var Z_INDEX:Array = [
			[GROUP_WEAPON,GROUP_CLOTH,GROUP_WING],//0方向
			[GROUP_CLOTH,GROUP_WEAPON,GROUP_WING],//1方向
			[GROUP_WING,GROUP_CLOTH,GROUP_WEAPON],//2方向
			[GROUP_WING,GROUP_CLOTH,GROUP_WEAPON],//3方向
			[GROUP_WING,GROUP_WEAPON,GROUP_CLOTH],//4方向
		]
		public function Animat() 
		{
			
		}
		public function play():void 
		{
			if (_modules.length==0) 
			{
				return;
			}
			var count:int = _modules[0].frameCount;
			for (var i:int = 0; i <_modules.length ; i++) 
			{
				if (i==3) 
				{
					continue;
				}
				var resid:int = 0;
				var path:String = _modules[i].path;
				//if (i == 0) resid = _cloth;
				//if (i == 1) resid = _weapon;
				//if (i == 2) resid = _wing;
				if (_modules[i].frameCount>0) 
				{
					//draw(_modules[i].bmd, i, resid, _currDir, _currFrame, _modules[i].path);//目前装备，武器，翅膀的总帧数必须相同。
				}
			}
			_currFrame++;
			if (_currFrame>count) 
			{
				if (_modules) 
				{
					////动作播放完后 是否回到第一帧。
					_currFrame = 0;
					for (i = 0; i <_modules.length ; i++) 
					{
						if (i == 3) continue;
						resid = 0;
						path = _modules[i].path;
						//if (i == 0) resid = _cloth;
						//if (i == 1) resid = _weapon;
						//if (i == 2) resid = _wing;
						if (_modules[i].frameCount>0)
						{
							//draw(_modules[i].bmd, i, resid, _currDir, _currFrame, _modules[i].path);
						}
					}
					//App.timer.clearTimer(doActionPlay);
					return;
				}
				//else if (_repeat)
				//{
					//_currFrame = 0;
				//}
			}
		}
		public function repeat():void 
		{
			
		}
		public function stop():void 
		{
			
		}
		/**
		 * 往图层绘制显示素材
		 * @param	group 		素材分类
		 * @param	resid     	素材id
		 * @param	dir			方向
		 * @param	currFrame	帧
		 */
		public function draw(bmd:BitmapData):void
		{
			if (!bmd) 
			{
				//App.log.error("没有bmd信息");
				return;
			}
			var targetX:int = 256;
			var targetY:int = 0;
			for (var i:int = 0; i < _modules.length; i++) 
			{
				var module:Object = _modules[i];
				var result:BitmapData = null;
				var frameInfo:Array = module.frameData;
				var targetBmd:BitmapData = module.texture;
				if (int(_modules[i].dirCount)==1) 
				{
					dir =0;
				}
				if (frameInfo&&frameInfo.length>0)
				{
					if (frameInfo[dir]&&frameInfo[dir][currFrame]) 
					{
						var x:int = frameInfo[dir][currFrame][0];
						var y:int = frameInfo[dir][currFrame][1];
						var w:int = frameInfo[dir][currFrame][2];
						var h:int = frameInfo[dir][currFrame][3];
						var cx:int = frameInfo[dir][currFrame][4];
						var cy:int = frameInfo[dir][currFrame][5];
						var rotated:int = frameInfo[dir][currFrame][6];
						
						var rect:Rectangle = null;
						var pt:Point = new Point();
						var pt1:Point = new Point();
						bmd.fillRect(new Rectangle(0, 0, this.width, this.height), 0xFF0000);
						var distanceX:int = 0;
						pt.x = cx + (this.width >>1);
						pt.y = cy + (this.height >> 1);
						//if (!EditorConfig.IS_LUWEIRAN)
						//{
						rotated = rotated == 2?1:0;
						//}
						if (rotated &&targetBmd)
						{
							rect = new Rectangle(x, y, h, w);
							result = new BitmapData(h, w);
							result.copyPixels(targetBmd, rect, new Point());
							var m:Matrix = new Matrix(); 
							m.rotate( -Math.PI / 2);
							pt.y = cy +h+ (this.height>>1);
							m.translate(pt.x,pt.y); 
							bmd.draw(result, m);
						}
						else
						{
							rect = new Rectangle(x, y, w, h);
							pt1 = new Point(x, y);
							if (targetBmd) 
							{
								bmd.copyPixels(targetBmd, rect, pt,targetBmd,pt1,true);
							}else {
								App.log.error("targetBmd不存在");
							}
						}
					}
				}
			}
		}
		
		public function get resId():int 
		{
			return _resId;
		}
		
		public function set resId(value:int):void 
		{
			_resId = value;
		}
		
		public function get currFrame():int 
		{
			return _currFrame;
		}
		
		public function set currFrame(value:int):void 
		{
			_currFrame = value;
		}
		
		public function get dir():int 
		{
			return _dir;
		}
		
		public function set dir(value:int):void 
		{
			_dir = value;
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function set width(value:int):void 
		{
			_width = value;
		}
		
		public function get height():int 
		{
			return _height;
		}
		
		public function set height(value:int):void 
		{
			_height = value;
		}
	}

}