package views
{
    import flash.geom.Rectangle;
    import flash.utils.getTimer;
    
    import model.Audio;
    import model.GamingState;
    import model.MainModel;
    import model.SubTextureName;
    
    import starling.animation.Transitions;
    import starling.animation.Tween;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    
    import util.AssetsUtil;
    import util.CollisionDetectionUtil;
    import util.RandomUtil;
    import util.VibrationUtil;
    
    import views.common.Score;
    import views.effects.BlackFlash;
    import views.gaming.Bird;
    import views.gaming.Ground;
    import views.gaming.Pipe;
    import views.gaming.Result;

	/**
	 * 主游戏游戏视图 
	 * @author haojie.wang
	 * 
	 */
    public class Gaming extends Sprite
    {
        private var _bg:Image;

        private var _ground:Ground;

        private var _bird:Bird;

        private var _pipes:Vector.<Pipe> = new Vector.<Pipe>();

        private var _score:Score;
		
		private var _tapTip:Image;
		
		private var _getReadyTip:Image;
		
		private var _state:int = 0;
		
		private var _update:Function;
		
		private var _enterStateTime:int = 0;
		
		private var _result:Result;
		
		private var _flash:BlackFlash;
        public function Gaming()
        {
            super();
        }

        override public function dispose():void
        {
            removeListeners();
            _bg.dispose();
            _ground.dispose();
            _bird.dispose();

			clearPipes();
            _score.dispose();
            super.dispose();
        }

		
		/**
		 * 初始化
		 * 
		 */
		public function init():void
        {
			//添加背景图
            _bg = new Image(AssetsUtil.getTexture(RandomUtil.getRandomInArray([SubTextureName.BG_0,SubTextureName.BG_1])));
            this.addChild(_bg);

			//添加小鸟
            _bird = new Bird();
            this.addChild(_bird);
			_bird.changeFlyMode(0);
			
			//初始化TAP_BEGIN图片
			_tapTip = new Image(AssetsUtil.getTexture(SubTextureName.TAP_BEGIN));
			_tapTip.x = (MainModel.STAGE_W - _tapTip.width) >> 1;
			_tapTip.y = (MainModel.STAGE_H - _tapTip.height) >> 1;
			
			//加入GET_READY图片
			_getReadyTip = new Image(AssetsUtil.getTexture(SubTextureName.GET_READY));
			_getReadyTip.x = (MainModel.STAGE_W - _getReadyTip.width) >> 1;
			_getReadyTip.y = 100;

			//添加计分板
            _score = new Score(AssetsUtil.getTextures(SubTextureName.BIG));
            _score.x = (MainModel.STAGE_W - _score.width) >> 1;
            _score.y = 20;
            this.addChild(_score);
			
			//加入地面
			_ground = new Ground();
			_ground.y = stage.stageHeight - _ground.height;
			this.addChild(_ground);
			
			//初始化结果视图
			_result = new Result();
			
			//	增加监听	
            addListeners();
			
			changeState(GamingState.PREPARE);
        }
		
		/**
		 * 改变游戏状态 
		 * @param state
		 * 
		 */
		private function changeState(state:int):void
		{
			if(_state == state)
			{
				return;
			}
			_enterStateTime = getTimer();
			_state = state;
			switch(state)
			{
				case GamingState.PREPARE:
					_update = prepareUpdate;
					enterPrepare();
					break;
				case GamingState.RUNNING:
					_update = runningUpdate;
					this.removeChild(_tapTip);
					this.removeChild(_getReadyTip);
					createPipe(MainModel.STAGE_W + MainModel.SETTING.pipeGapX, RandomUtil.getIntValueBetween(MainModel.SETTING.minPipePos, MainModel.SETTING.maxPipePos));
					_bird.changeFlyMode(1);					
					_bird.fly();
					break;
				case GamingState.PAUSE:
					_update = pauseUpdate;
					break;
				case GamingState.END:
					MainModel.audioManager.playMp3Sound(Audio.HIT);
					VibrationUtil.vibration(200);
					_update = endUpdate;
					_result.alpha = 0;
					_score.visible = false;
					this.addChild(_result);
					var tween:Tween = new Tween(_result,0.5,Transitions.EASE_OUT);
					tween.fadeTo(1);
					Starling.juggler.add(tween);
					break;
			}
		}
		
		/**
		 * 清除管道 
		 * 
		 */
		private function clearPipes():void
		{
			for each (var pipe:Pipe in _pipes)
			{
				this.removeChild(pipe);
				pipe.dispose();
			}
			_pipes.length = 0;
		}
		 
		/**
		 * 创建管道
		 * @param x
		 * @param y
		 * 
		 */
		private function createPipe(x:int, y:int):void
		{
			var pipeTop:Pipe = new Pipe(0);
			pipeTop.x = x;
			pipeTop.y = y;
			var pipeDown:Pipe = new Pipe(1);
			pipeDown.x = x;
			pipeDown.y = y + MainModel.SETTING.pipeGapY;
			
			this.addChildAt(pipeTop, 1);
			this.addChildAt(pipeDown, 1);
			_pipes.unshift(pipeTop);
			_pipes.unshift(pipeDown);
		}
		/**
		 * 进入游戏准备状态 
		 * 
		 */
		private function enterPrepare():void
		{
			this.removeChild(_result);
			clearPipes();
			this.addChild(_tapTip);
			this.addChild(_getReadyTip);
			_bird.x = int(MainModel.STAGE_W * 0.3);
			_bird.y = MainModel.STAGE_H >> 1;
			_bird.changeFlyMode(0);
			_bird.changeSkin();
			_score.visible = true;
			MainModel.getInstance().score = 0;
			_score.setValue(0);
			_bg.texture = AssetsUtil.getTexture(RandomUtil.getRandomInArray([SubTextureName.BG_0,SubTextureName.BG_1]));
			//存在过度特效的时候交换显示标签
			if(_flash)
			{
				this.swapChildren(_flash,_tapTip);
				this.swapChildren(_flash,_getReadyTip);
			}
		}

       

		/**
		 * 添加监听 
		 */
        public function addListeners():void
        {
			//添加帧频事件和触摸事件
            this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            this.addEventListener(TouchEvent.TOUCH, touchHandler);
        }

		/**
		 * 移除监听 
		 */
        public function removeListeners():void
        {
            this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            this.removeEventListener(TouchEvent.TOUCH, touchHandler);
        }

		/**
		 * 触摸事件处理 
		 * @param e
		 * 
		 */
        private function touchHandler(e:TouchEvent):void
        {
            if (TouchPhase.BEGAN == e.touches[0].phase)
            {
				switch(_state)
				{
					case GamingState.PREPARE:
						changeState(GamingState.RUNNING);
						break;
					case GamingState.RUNNING:
						_bird.fly();
						break;
					case GamingState.PAUSE:
						
						break;
					case GamingState.END:
						if(getTimer() - _enterStateTime > 1000 && null == _flash)
						{
							MainModel.audioManager.playMp3Sound(Audio.SWOOSHING);
							//添加过度效果
							_flash = new BlackFlash(onFlashBlack,onFlashOver);
							this.addChild(_flash);
							_flash.flash();																
						}
						break;
				}
            }
        }
		
		private function onFlashBlack():void
		{
			changeState(GamingState.PREPARE);
		}
		
		private function onFlashOver():void
		{
			if(_flash)
			{
				this.removeChild(_flash);
				_flash.dispose();
				_flash = null;
			}
		}
		
		private function prepareUpdate():void
		{
			_ground.scroll(MainModel.SETTING.flySpeed);
			_bird.update();
		}
		
		private function playPointSound():void
		{
			MainModel.audioManager.playMp3Sound(Audio.POINT);
		}
		
		private function runningUpdate():void
		{
			_ground.scroll(MainModel.SETTING.flySpeed);
			
			var pipeState:int = int.MAX_VALUE;
			var lastPipe:Pipe;
			var count:int = _pipes.length;
			var pipe:Pipe;
			//管道碰撞检测
			while (--count > -1)
			{
				pipe = _pipes[count];
				pipe.scroll(-MainModel.SETTING.flySpeed);
				
				if (pipe.x <= _bird.x && false == pipe.crossed && 0 == pipe.position)
				{
					pipe.crossed = true;
					MainModel.getInstance().score += 1;
					_score.setValue(MainModel.getInstance().score);
					playPointSound();
				}
				pipeState = pipe.checkStageState();
				lastPipe = pipe;
				
				if (pipeState < -1)
				{
					this.removeChild(pipe);
					_pipes.splice(count, 1);
				}
				else if(0 == pipeState)
				{
					var birdRect:Rectangle = _bird.getSizeRect();
					//检查是否碰撞
					if(CollisionDetectionUtil.RectangleCollisionDetection(birdRect,pipe.bounds))
					{
						changeState(GamingState.END);
					}
				}
			}
			
			if (0 == pipeState)
			{
				createPipe(lastPipe.x + MainModel.SETTING.pipeGapX, RandomUtil.getIntValueBetween(MainModel.SETTING.minPipePos, MainModel.SETTING.maxPipePos));
			}
			
			_bird.update();
			//鸟撞地面了
			if (_bird.y > _ground.y)
			{
				_bird.y = _ground.y;
				changeState(GamingState.END);
			}
		}
		
		private function pauseUpdate():void
		{
			
		}
		
		private function endUpdate():void
		{
			_bird.update();
			
			if (_bird.y > _ground.y)
			{
				_bird.y = _ground.y;
				changeState(GamingState.END);
			}
		}

        private function enterFrameHandler(e:Event):void
        {
			_update();
        }


    }
}
