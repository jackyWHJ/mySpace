var STATE_PLAYING = 0;
var STATE_GAMEOVER = 1;

var g_sharedGameLayer;

var GameLayer = cc.Layer.extend({
    _time:0,
    _timeLabel:null,
    _timeString:"",

    screenRect:null,
    _state:STATE_PLAYING,
    _explosions:null,
    _texOpaqueBatch:null,
    _blocks:[],
    _heroFrameCache:null,
    init:function () {
        var bRet = false;
        if (this._super()) {
            cc.SpriteFrameCache.getInstance().addSpriteFrames(s_textureOpaquePack_plist);
            this._heroFrameCache = cc.SpriteFrameCache.getInstance();
            this._heroFrameCache.addSpriteFrames(s_textureNormalImage_plist);
            cc.SpriteFrameCache.getInstance().addSpriteFrames(s_textureLoveImage_plist);
            // reset global values
            LLK.map = [];//元素表,Block数组
            this._state = STATE_PLAYING;

            // OpaqueBatch
            var texOpaque = cc.TextureCache.getInstance().addImage(s_textureOpaquePack);
            this._texOpaqueBatch = cc.SpriteBatchNode.createWithTexture(texOpaque);
            this._texOpaqueBatch.setBlendFunc(gl.SRC_ALPHA, gl.ONE);
            this.addChild(this._texOpaqueBatch);

            var winSize = cc.Director.getInstance().getWinSize();
//            this._wayManager = new WayManager(this);
            this.screenRect = cc.rect(0, 0, winSize.width, winSize.height + 10);

            // explosion batch node
            cc.SpriteFrameCache.getInstance().addSpriteFrames(s_explosion_plist);
            var explosionTexture = cc.TextureCache.getInstance().addImage(s_explosion);
            this._explosions = cc.SpriteBatchNode.createWithTexture(explosionTexture);
            this._explosions.setBlendFunc(gl.SRC_ALPHA, gl.ONE);
            this.addChild(this._explosions);
            Explosion.sharedExplosion();

            this.initBackground();
            this.initBlock();
            // accept touch now!

            this._timeLabel = cc.LabelTTF.create("00:00","Arial Bold",16);
            this._timeLabel.setPosition(180,520);
            this._timeLabel.setColor(cc.c3b(255,255,255));
            this.addChild(this._timeLabel,10);

            if( 'keyboard' in sys.capabilities )
                this.setKeyboardEnabled(true);

            if( 'mouse' in sys.capabilities )
                this.setMouseEnabled(true);

            if( 'touches' in sys.capabilities )
                this.setTouchEnabled(true);
            if (LLK.SOUND) {
//                cc.log(cc.AudioEngine.getInstance().isMusicPlaying());
                cc.AudioEngine.getInstance().playMusic(s_bgMusic_mp3,true);
            }
            // schedule
            this.scheduleUpdate();
            this.schedule(this.scoreCounter, 1);
            bRet = true;

			g_sharedGameLayer = this;
        }
        return bRet;
    },

    initBlock:function(){
        var mapIndex = 0,i = 0,j = 0;
        var imgLen =  LLK.CONTAINER.NORMALIMAGES.length;
        if(LLK.MODE){
            imgLen =  LLK.CONTAINER.NORMALIMAGES.length;
            for ( i = 0; i < LLK.LEVEL.x*LLK.LEVEL.y; i+=2) {
                this._blocks[i] = this._blocks[i + 1] = LLK.CONTAINER.NORMALIMAGES[Math.floor(Math.random() * imgLen)];
            }
        }
        else{
            imgLen =  LLK.CONTAINER.MENGIMAGES.length;
            for ( i = 0; i < LLK.LEVEL.x*LLK.LEVEL.y; i+=2) {
                this._blocks[i] = this._blocks[i + 1] = LLK.CONTAINER.MENGIMAGES[Math.floor(Math.random() * imgLen)];
            }
        }
        var imgName = "";
        for ( j=0; j < LLK.LEVEL.y; j++) {
            for ( i=0; i < LLK.LEVEL.x; i++) {
                imgName = this.randomArray(this._blocks);
                var temp = new Block(imgName);
                temp.pointX = i;
                temp.pointY = j;
                temp.name = imgName;
                temp.id = mapIndex;
                LLK.map[temp.id] = temp;
                temp.setAnchorPoint(cc.p(0, 0));
                temp.setPosition(i*60, j*60+30);
                this.addChild(temp);
                mapIndex ++;
            }
        }
        LLK.COUNT = mapIndex;
    },
    randomArray:function (arr){
        var index = Math.floor(Math.random()*arr.length);
        return arr.splice(index,1)[0];
    },

    scoreCounter:function () {
        if( this._state == STATE_PLAYING ) {
            this._time++;

            var minute = 0 | (this._time / 60);
            var second = this._time % 60;
            minute = minute > 9 ? minute : "0" + minute;
            second = second > 9 ? second : "0" + second;
            this._timeString = minute + ":" + second;
            this._timeLabel.setString(this._timeString);
//            this._levelManager.loadLevelResource(this._time);
        }
    },

    initBackground:function () {
        // bg
        var bgImage = s_b03;
        if(Math.random() > 0.5){
            bgImage = s_b04;
        }
        this._backSky = cc.Sprite.create(bgImage);
        this._backSky.setAnchorPoint(cc.p(0, 0));
        this._backSkyHeight = this._backSky.getContentSize().height;
        this.addChild(this._backSky, -10);
    },
    onGameOver:function () {
        this._state = STATE_GAMEOVER;
        var scene = cc.Scene.create();
        scene.addChild(GameOver.create());
        cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.2, scene));
    }
});

GameLayer.create = function () {
    var sg = new GameLayer();
    if (sg && sg.init()) {
        return sg;
    }
    return null;
};

GameLayer.scene = function () {
    var scene = cc.Scene.create();
    var layer = GameLayer.create();
    scene.addChild(layer, 1);
    return scene;
};

GameLayer.prototype.addExplosions = function (explosion) {
	this._explosions.addChild(explosion);
};
GameLayer.prototype.addSpark = function (spark) {
    this._texOpaqueBatch.addChild(spark);
};
