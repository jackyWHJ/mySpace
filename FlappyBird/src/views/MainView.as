package views
{	
	
	import model.MainModel;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	/**
	 * 主程序视图 
	 * @author haojie.wang
	 * 
	 */	
	public class MainView extends Sprite
	{		

		private var _mc:MainModel;
		private var _state:int;
		private var _page:Gaming;
		public function MainView()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
		}
		
		private function addedToStageHandler(e:Event):void
		{
			init();
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function init():void
		{
			//获取主数据模型
			_mc = MainModel.getInstance();	
			//初始化纹理集
			_mc.textureAtlas = new TextureAtlas(Texture.fromBitmapData(_mc.birdAssetsBmd),_mc.birdAssetsXML);
			//设定舞台
			_mc.stage = this.stage;
			//添加游戏画面
			_page = new Gaming();
			this.addChild(_page);
			_page.init();
		}
		
	}
}