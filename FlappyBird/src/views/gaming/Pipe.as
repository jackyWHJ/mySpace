package views.gaming
{
	import model.MainModel;
	import model.SubTextureName;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * 管道视图 
	 * @author haojie.wang
	 * 
	 */
	public class Pipe extends Sprite
	{
		public var crossed:Boolean = false;
		
		private var _image:Image;
		
		private var _position:int;
		public function get position():int
		{
			return _position;
		}
		
		/**
		 * 
		 * @param position 位置 0:上 1:下
		 * 
		 */		
		public function Pipe(position:int = 0)
		{
			_position = position;
			var t:Texture;
			switch(position)
			{
				case 0:
					t = MainModel.getInstance().textureAtlas.getTexture(SubTextureName.GREEN_TOP);
					_image = new Image(t);
					_image.y = -_image.height;
					break;
				case 1:
					t = MainModel.getInstance().textureAtlas.getTexture(SubTextureName.GREEN_DOWN);
					_image = new Image(t);
					break;
			}
			_image.x = -(_image.width >> 1);
			this.addChild(_image);
		}
		
		public function scroll(value:int):void
		{
			this.x += value;
		}
		
		/**
		 * 
		 * @return -1 从左边滑出了屏幕 0 在屏幕中 1还在屏幕右边 
		 * 
		 */		
		public function checkStageState():int
		{
			var right:int = this.x + _image.x + _image.width;
			if(right < 0)
			{
				return -1;
			}
			else if(right > MainModel.STAGE_W)
			{
				return 1;
			}
			return 0;
		}
	}
}