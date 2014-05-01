package model
{
	import flash.display.BitmapData;
	import flash.net.SharedObject;
	
	import control.AudioManager;
	
	import starling.display.Stage;
	import starling.textures.TextureAtlas;

	/**
	 * 主要数据模型 
	 * @author haojie.wang
	 * 
	 */
	public class MainModel
	{
		/**
		 * 宽度 
		 */		
		static public const STAGE_W:int = 288;
		
		/**
		 * 高度 
		 */		
		static public const STAGE_H:int = 512;
		
		/**
		 * 设置 
		 */		
		static public const SETTING:SettingVO = new SettingVO();
		
		/**
		 * 声音设备 
		 */		
		static public var audioManager:AudioManager = new AudioManager();
		
		static private var _instance:MainModel;
		
		/**
		 * 获取数据模型的实例 
		 * @return 
		 * 
		 */		
		static public function getInstance():MainModel
		{
			if(_instance == null)
			{
				_instance = new MainModel();
			}
			return _instance;
		}
		
		/**
		 * 舞台 
		 */		
		public var stage:Stage;
		
		/**
		 * 资源位图 
		 */		
		public var birdAssetsBmd:BitmapData;
		
		/**
		 * 资源配置XML 
		 */		
		public var birdAssetsXML:XML;
		
		/**
		 * 纹理集 
		 */		
		public var textureAtlas:TextureAtlas;
		
		/**
		 * 分数 
		 */		
		public var score:int = 0;
		
		/**
		 * 最佳分数 
		 */		
		public var bestScore:int = 0;
		
		/**
		 * 本地存储 
		 */		
		public var so:SharedObject;
	}
}