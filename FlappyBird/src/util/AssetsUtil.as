package util
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import model.MainModel;
	
	import starling.textures.Texture;

	/**
	 * 纹理集工具类 
	 * @author haojie.wang
	 * 
	 */
	public class AssetsUtil
	{
		[Embed(source="../assets/bird.png", mimeType="image/png")]
		static private var _fakeBirdImg:Class;
		
		[Embed(source="../assets/bird.xml", mimeType="application/octet-stream")]
		static private var _fakeBirdXml:Class;
		
		public function AssetsUtil()
		{
			
		}
		
		static public function init():void
		{
			var mc:MainModel = MainModel.getInstance();
			mc.birdAssetsBmd = (new _fakeBirdImg() as Bitmap).bitmapData;
			
			var ba:ByteArray = new _fakeBirdXml() as ByteArray;
			var xmlStr:String = ba.readMultiByte(ba.bytesAvailable,"utf-8");
			mc.birdAssetsXML = XML(xmlStr);
		}
		
		static public function getTexture(name:String):Texture
		{
			var mc:MainModel = MainModel.getInstance();
			return mc.textureAtlas.getTexture(name);
		}
		
		static public function getTextures(prefix:String):Vector.<Texture>
		{
			var mc:MainModel = MainModel.getInstance();
			return mc.textureAtlas.getTextures(prefix);
		}
	}
}