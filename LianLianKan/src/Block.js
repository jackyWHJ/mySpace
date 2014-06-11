var Block = cc.Sprite.extend({
    id:0,
    name:"",
    active:true,
    pointX:0,
    pointY:0,
    beginPoint:null,
    flash:false,
    ctor:function (arg) {
        this._super();
        if(!arg)return;
        this.initWithSpriteFrameName(arg);
        this.name = arg;
//        cc.registerTargetedDelegate(0,true,this);
        cc.Director.getInstance().getTouchDispatcher().addTargetedDelegate(this, 0, true);
    },
    //销毁隐藏
    destroy:function () {
        var explosion =	Explosion.getOrCreateExplosion();
        explosion.setPosition(this.getPosition());
//        SparkEffect.getOrCreateSparkEffect(this.getPosition());
        if(LLK.SOUND){
            cc.AudioEngine.getInstance().setMusicVolume(0.7);
            cc.AudioEngine.getInstance().playEffect(s_explodeEffect_mp3);
        }
		this.setVisible(false);
        this.active = false;
        LLK.COUNT --;
        if(LLK.COUNT <= 0/* || 1*/){
            g_sharedGameLayer.onGameOver();
        }
    },

    //判断触摸点是否在图片的区域上
    containsTouchLocation:function (touch) {
        //获取触摸点位置
        var getPoint = touch.getLocation();

        //物体当前区域所在的位置
        var contentSize  =  this.getContentSize();
        var myRect = cc.rect(0, 0, contentSize.width, contentSize.height);
        myRect.origin.x += this.getPosition().x;
        myRect.origin.y += this.getPosition().y;
        //判断点击是否在区域上
        return cc.rectContainsPoint(myRect,getPoint);
    },
    //刚触摸瞬间
    onTouchBegan:function (touch, event) {
        if (!this.containsTouchLocation(touch)) return false;
        this.beginPoint = touch.getLocation();
//        this.setZIndex(100);
        this.flash = true;
        this.setScale(1.2);
        return true;
    },
    //触摸移动
    onTouchMoved:function (touch, event) {
        if (!this.containsTouchLocation(touch)) return false;
        var touchPoint = touch.getLocation();
        var xDist = touchPoint.x - this.beginPoint.x,yDist = touchPoint.y - this.beginPoint.y;
        //移动距离超过10个像素位才有效
        if((Math.abs(xDist) >= 10 || Math.abs(yDist) >= 10)&&this.flash){
            this.flash = false;
            var block = this;
            if(Math.abs(xDist) > Math.abs(yDist)){
                if(xDist > 0){this.moveRight(block);}
                else{this.moveLeft(block);}
            }
            else{
                if(yDist > 0){this.moveUp(block);}
                else{this.moveDown(block);}
            }
        }
        return false;
    },
    onTouchEnded:function(touch,event){
        this.setScale(1);
        this.flash = true;
    },

    moveLeft:function(block){
        if(block.pointX == 0)return;
        var leftBlock = Block.getBlock(block.pointX - 1,block.pointY);
        if(leftBlock){
            leftBlock.pointX = block.pointX;
            leftBlock.setPosition(block.pointX*60,block.pointY*60+30);
            leftBlock.checkTheSame();
        }
        block.pointX --;
        block.setPosition(block.pointX*60,block.pointY*60+30);
        block.checkTheSame();
    },
    moveRight:function(block){
        if(block.pointX == LLK.LEVEL.x - 1)return;
        var rightBlock = Block.getBlock(block.pointX + 1,block.pointY);
        if(rightBlock){
            rightBlock.pointX = block.pointX;
            rightBlock.setPosition(block.pointX*60,block.pointY*60+30);
            rightBlock.checkTheSame();
        }
        block.pointX ++;
        block.setPosition(block.pointX*60,block.pointY*60+30);
        block.checkTheSame();
    },
    moveUp:function(block){
        if(block.pointY == LLK.LEVEL.y - 1)return;
        var upBlock = Block.getBlock(block.pointX,block.pointY+1);
        if(upBlock){
            upBlock.pointY = block.pointY;
            upBlock.setAnchorPoint(cc.p(0, 0));
            upBlock.setPosition(block.pointX*60,block.pointY*60+30);
            upBlock.checkTheSame();
        }
        block.pointY ++;
        block.setPosition(block.pointX*60,block.pointY*60+30);
        block.checkTheSame();
    },
    moveDown:function(block){
        if(block.pointY == 0)return;
        var downBlock = Block.getBlock(block.pointX,block.pointY - 1);
        if(downBlock){
            downBlock.pointY = block.pointY;
            downBlock.setPosition(block.pointX*60,block.pointY*60+30);
            downBlock.checkTheSame();
        }
        block.pointY --;
//        block.setAnchorPoint(cc.p(0, 0));
        block.setPosition(block.pointX*60,block.pointY*60+30);
        block.checkTheSame();
    },
    checkTheSame:function(){
        this.checkLeft() || this.checkUp()||this.checkRight()||this.checkDown();
    },
    checkLeft:function(){
        if(this.pointX == 0)return false;
        var leftBlock = Block.getBlock(this.pointX - 1,this.pointY);
        if(leftBlock && leftBlock.name == this.name){
            this.destroy();
            leftBlock.destroy();
            return true;
        }
        return false;
    },
    checkRight:function(){
        if(this.pointX == LLK.LEVEL.x - 1)return false;
        var rightBlock = Block.getBlock(this.pointX + 1,this.pointY);
        if(rightBlock && rightBlock.name == this.name){
            this.destroy();
            rightBlock.destroy();
            return true;
        }
        return false;
    },
    checkUp:function(){
        if(this.pointY == LLK.LEVEL.y - 1)return false;
        var upBlock = Block.getBlock(this.pointX,this.pointY+1);
        if(upBlock && upBlock.name == this.name){
            this.destroy();
            upBlock.destroy();
            return true;
        }
        return false;
    },
    checkDown:function(){
        if(this.pointY == 0)return false;
        var downBlock = Block.getBlock(this.pointX,this.pointY - 1);
        if(downBlock && downBlock.name == this.name){
            this.destroy();
            downBlock.destroy();
            return true;
        }
        return false;
    }

});

Block.getBlock = function(pointX,pointY) {
	for (var j = 0,len = LLK.map.length; j < len; j++) {
		if (LLK.map[j].active && pointX == LLK.map[j].pointX && pointY == LLK.map[j].pointY)
		{
			return LLK.map[j];
		}
	}
	return null;
};
