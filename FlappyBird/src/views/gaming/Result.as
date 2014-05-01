package views.gaming
{
	import model.MainModel;
	import model.SubTextureName;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import util.AssetsUtil;
	
	import views.common.Score;
	
	/**
	 * 游戏结束结果面板视图 
	 * @author Administrator
	 * 
	 */
	public class Result extends Sprite
	{
		private var _gameOver:Image;
		private var _bg:Image;
		private var _nowScore:Score;
		private var _bestScore:Score;
		private var _new:Image;
		public function Result()
		{
			super();
			init();
		}
		
		private function init():void
		{
			_gameOver = new Image(AssetsUtil.getTexture(SubTextureName.GAME_OVER));
			_gameOver.x = (MainModel.STAGE_W - _gameOver.width) >> 1;
			_gameOver.y = 80;
			
			_bg = new Image(AssetsUtil.getTexture(SubTextureName.RESULT_PANEL));
			_bg.x = 30;
			_bg.y = 230;
			
			_nowScore = new Score(AssetsUtil.getTextures(SubTextureName.SMALL));
			_nowScore.x = 222;
			_nowScore.y = 266;
			
			_bestScore = new Score(AssetsUtil.getTextures(SubTextureName.SMALL));
			_bestScore.x = 222;
			_bestScore.y = 309;
			
			_new = new Image(AssetsUtil.getTexture(SubTextureName.NEW));
			_new.x = 153;
			_new.y = 266;
			
			this.addChild(_gameOver);
			this.addChild(_bg);
			this.addChild(_nowScore);
			
			this.addChild(_new);
			this.addChild(_bestScore);
			addListeners();
		}
		
		public function addListeners():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		public function removeListeners():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void
		{
			var mc:MainModel = MainModel.getInstance();
			if(mc.score > mc.bestScore)
			{
				_new.visible = true;
				mc.bestScore = mc.score;
				mc.so.data.bestScore = mc.bestScore;
				mc.so.flush();
			}
			else
			{
				_new.visible = false;
			}
			
			_nowScore.setValue(mc.score);
			_bestScore.setValue(mc.bestScore);
		}
		
		override public function dispose():void
		{
			removeListeners();
			super.dispose();
		}
	}
}