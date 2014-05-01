package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import model.Audio;
	import model.MainModel;
	import model.SettingVO;
	
	import starling.core.Starling;
	
	import util.AssetsUtil;
	
	import views.MainView;

	[SWF(width = "288", height = "512")]
	/**
	 * 游戏入口类，加载游戏所需要的资源
	 * @haojie.wang
	 * @date 2014-4-14
	 */
	public class FlappyBird extends Sprite
	{
		private var startling:Starling;
		
		private var loader:URLLoader;
		public function FlappyBird()
		{
			super();
			loadSetting();
		}
		/**
		 * 加载设置*/
		private function loadSetting():void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,loader_completeHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			loader.load(new URLRequest("assets/setting.xml"));
		}
		/**
		 * 加载IO异常处理*/
		private function loader_errorHandler(event:IOErrorEvent):void
		{
			removeLoader();
		}
		/**
		 * 加载完成处理*/
		private function loader_completeHandler(event:Event):void
		{
			var settingXML:XML = XML(loader.data);
			var settingVO:SettingVO = MainModel.SETTING;
			
			for each (var node:XML in settingXML.children())
			{
				settingVO[node.localName()] = node.toString();
			}
			
			removeLoader();
			init();
		}
		
		/**
		 * 移除loader*/
		private function removeLoader():void
		{
			loader.removeEventListener(Event.COMPLETE,loader_completeHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR,loader_errorHandler);
			loader = null;
		}
		
		/**
		 * 初始化代码
		 *
		 */
		private function init():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = 60;
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			loadRecord();
			AssetsUtil.init();
			registSounds();
			
			startling = new Starling(MainView, stage, new Rectangle(0, 0, MainModel.STAGE_W, MainModel.STAGE_H));
			startling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			startling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			startling.start();
			
			stage.addEventListener(Event.RESIZE, stage_resizeHandler);
		}
		
		/**
		 * 加载记录 
		 * 
		 */
		private function loadRecord():void
		{
			var mc:MainModel = MainModel.getInstance();
			mc.so = SharedObject.getLocal("recordObj");
			if(mc.so.data.bestScore)
			{
				mc.bestScore = mc.so.data.bestScore;
			}
		}
		
		private function stage_resizeHandler(e:Event):void
		{
			startling.viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			//			_startling.stage.stageWidth = stage.stageWidth;
			//			_startling.stage.stageHeight = stage.stageHeight;
		}
		
		private function onContextCreated(e:Event):void
		{
			
		}
		
		/**
		 * 注册声音文件 
		 * 
		 */
		private function registSounds():void
		{
			var MP3Sound:Sound;
			MP3Sound = new Sound();
			MP3Sound.load(new URLRequest("assets/sounds/point.mp3"));
			MainModel.audioManager.addMp3Sound(Audio.POINT,MP3Sound);
			
			MP3Sound = new Sound();
			MP3Sound.load(new URLRequest("assets/sounds/die.mp3"));
			MainModel.audioManager.addMp3Sound(Audio.DIE,MP3Sound);
			
			MP3Sound = new Sound();
			MP3Sound.load(new URLRequest("assets/sounds/wing.mp3"));
			MainModel.audioManager.addMp3Sound(Audio.WING,MP3Sound);
			
			MP3Sound = new Sound();
			MP3Sound.load(new URLRequest("assets/sounds/hit.mp3"));
			MainModel.audioManager.addMp3Sound(Audio.HIT,MP3Sound);
			
			
			MP3Sound = new Sound();
			MP3Sound.load(new URLRequest("assets/sounds/swooshing.mp3"));
			MainModel.audioManager.addMp3Sound(Audio.SWOOSHING,MP3Sound);
			MP3Sound.addEventListener(IOErrorEvent.IO_ERROR, loadSoundErrorHandler);
		}
		
		/**
		 * 加载声音异常处理 
		 * @param event
		 * 
		 */
		private function loadSoundErrorHandler(event:IOErrorEvent):void {
			trace("Couldn't load the file " + event.text);
		}

	}
}