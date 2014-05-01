package views.gaming
{
	import model.MainModel;
	import model.SubTextureName;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * 地面视图 
	 * @author haojie.wang
	 * 
	 */
	public class Ground extends Sprite
	{
		private var _img:Image;
		private var _parts:QuadBatch;
		private var _imgPosX:int;
		public function Ground()
		{
			super();
			var t:Texture = MainModel.getInstance().textureAtlas.getTexture(SubTextureName.GROUND);
			
			_img = new Image(t);
			
			_parts = new QuadBatch();
			_parts.addImage(_img);
			_img.x = _img.width;
			_parts.addImage(_img);
			this.addChild(_parts);
		}
		
		public function scroll(value:int):void
		{
			var rightChanged:int = _imgPosX + _img.width - value;
			if(rightChanged < 0)
			{
				_imgPosX = rightChanged;
			}
			else
			{
				_imgPosX = _imgPosX - value;
			}

			_parts.reset();
			_img.x = _imgPosX;
			_parts.addImage(_img);
			_img.x += _img.width - 1;
			_parts.addImage(_img);
		}
	}
}