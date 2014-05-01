package views.gaming
{
	import flash.geom.Rectangle;
	
	import model.Audio;
	import model.MainModel;
	import model.SubTextureName;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;
	
	import util.RandomUtil;

	/**
	 * playppy bird 视图 
	 * @author haojie.wang
	 * 
	 */
	public class Bird extends Sprite
	{
		private var _mc:MovieClip;
		
		private var _vy:Number;
		
		private var _flyMode:Function;
		private var _freePos:int;
		
		private var _sizeRect:Rectangle;
		
		public function getSizeRect():Rectangle
		{
			_sizeRect.x = this.x + _mc.x;
			_sizeRect.y = this.y + _mc.y;
			return _sizeRect;
		}
		
		public function Bird()
		{
			changeSkin();
			_sizeRect = new Rectangle(_mc.x,_mc.y,_mc.width - 7,_mc.height);
		}
		
		public function changeSkin():void
		{
			if(_mc != null)
			{
				Starling.juggler.remove(_mc);
				_mc.dispose();
			}
			_mc = new MovieClip(MainModel.getInstance().textureAtlas.getTextures(RandomUtil.getRandomInArray([SubTextureName.BIRD_BLUE,SubTextureName.BIRD_HERO,SubTextureName.BIRD_YELLOW])));
			_mc.x = -(_mc.width >> 1);
			_mc.y = -(_mc.height >> 1);
			this.addChild(_mc);
			Starling.juggler.add(_mc);
		}

		public function fly():void
		{
			MainModel.audioManager.playMp3Sound(Audio.WING);
			_vy = -10;
		}
		
		public function update():void
		{
			_flyMode();
		}		
		
		public function changeFlyMode(type:int):void
		{
			switch(type)
			{
				case 0:
					_flyMode = freeFly;
					_freePos = this.y;
					_vy = MainModel.SETTING.freeFlySpeed;
					break;
				case 1:
					_flyMode = fallFly;
					_vy = MainModel.SETTING.gravitation;
					break;
			}
			this.rotation = 0;
		}
		
		private function freeFly():void
		{
			const D:int = 5;
			this.y += _vy;
			if(this.y - _freePos >= D || this.y - _freePos <= -D)
			{
				_vy *= -1;
			}
		}
		
		private function fallFly():void
		{
			this.y += _vy;
			if(_vy >= 0)
			{
				_vy += MainModel.SETTING.flyPower;
				
				if (rad2deg(this.rotation) < 90)
				{
					this.rotation += deg2rad(3);
				}
			}
			else
			{
				_vy += MainModel.SETTING.gravitation;
				this.rotation = deg2rad(-30);
			}
		}
	}
}