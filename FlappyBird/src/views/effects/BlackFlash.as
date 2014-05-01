package views.effects
{
	import flash.display.BitmapData;
	
	import model.MainModel;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * 黑色视图，游戏结束新游戏开始的过度 
	 * @author haojie.wang
	 * 
	 */
	public class BlackFlash extends Sprite
	{
		private var _image:Image;
		private var _color:uint;
		private var _onBlack:Function;
		private var _onOver:Function;
		public function BlackFlash(onBlack:Function = null, onOver:Function = null, color:uint = 0)
		{
			super();
			_color = color;
			_onBlack = onBlack;
			_onOver = onOver;
			init();
		}
		
		private function init():void
		{
			var bmd:BitmapData = new BitmapData(1,1,false,_color);
			_image = new Image(Texture.fromBitmapData(bmd));
			_image.width = MainModel.STAGE_W;
			_image.height = MainModel.STAGE_H;
			_image.alpha = 0;
			bmd.dispose();
			this.addChild(_image);
		}
		
		override public function dispose():void
		{
			_image.dispose();
			super.dispose();
		}
		
		public function flash():void
		{			
			var tween:Tween = new Tween(_image,0.5);
			tween.fadeTo(1);
			tween.onComplete = step1;
			Starling.juggler.add(tween);
		}
		
		private function step1():void
		{
			var tween:Tween = new Tween(_image,0.5);
			tween.fadeTo(0);
			tween.onComplete = step2;
			tween.delay = 0.5;
			Starling.juggler.add(tween);
			if(_onBlack)
			{
				_onBlack();
			}
		}
		
		private function step2():void
		{
			if(_onOver)
			{
				_onOver();
			}
		}
	}
}