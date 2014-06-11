cc.dumpConfig();
var winSize;
var SysMenu = cc.Layer.extend({
    _hero:null,
    _logo:null,
    _heroFrameCache:null,
    _logoFrameCache:null,
    imagesArrLen:0,
    bigImgLen:0,
    init:function () {
        var bRet = false;
        if (this._super()) {
            this._logoFrameCache = cc.SpriteFrameCache.getInstance();
            this._logoFrameCache.addSpriteFrames(s_textureBigImage_plist);
//            this._heroFrameCache = cc.SpriteFrameCache.getInstance();
//            this._heroFrameCache.addSpriteFrames(s_textureLoveImage_plist);

            winSize = cc.Director.getInstance().getWinSize();
            var sp = cc.Sprite.create(s_b01);
            sp.setAnchorPoint(cc.p(0,0));//设置锚点左下角
            this.addChild(sp, 0, 1);//addChild(cocos2d::CCNode *child, int zOrder, int tag);
            // 其中child参数为将要添加的节点。对于场景而言。添加的节点就是层，先添加的层会被置于后添加的层之下。
            // 如果想要指定先后次顺，可以使用不同的zOrder，zOrder代表该节点下元素的先后次序，值越大显示越靠上。
            // 默认值是0.tag是元素的标识号码，如果子节点设置了tag值，就可以在它的父节点中利用tag值找到它

            var newGameNormal = cc.Sprite.create(s_menu, cc.rect(0, 0, 126, 33));
            var newGameSelected = cc.Sprite.create(s_menu, cc.rect(0, 33, 126, 33));
            var newGameDisabled = cc.Sprite.create(s_menu, cc.rect(0, 33 * 2, 126, 33));

            var gameSettingsNormal = cc.Sprite.create(s_menu, cc.rect(126, 0, 126, 33));
            var gameSettingsSelected = cc.Sprite.create(s_menu, cc.rect(126, 33, 126, 33));
            var gameSettingsDisabled = cc.Sprite.create(s_menu, cc.rect(126, 33 * 2, 126, 33));

            var aboutNormal = cc.Sprite.create(s_menu, cc.rect(252, 0, 126, 33));
            var aboutSelected = cc.Sprite.create(s_menu, cc.rect(252, 33, 126, 33));
            var aboutDisabled = cc.Sprite.create(s_menu, cc.rect(252, 33 * 2, 126, 33));

            var newGame = cc.MenuItemSprite.create(newGameNormal, newGameSelected, newGameDisabled, function () {
                this.onButtonEffect();
                flareEffect(this, this, this.onNewGame);
            }.bind(this));
            var gameSettings = cc.MenuItemSprite.create(gameSettingsNormal, gameSettingsSelected, gameSettingsDisabled, this.onSettings, this);
            var about = cc.MenuItemSprite.create(aboutNormal, aboutSelected, aboutDisabled, this.onAbout, this);

            var menu = cc.Menu.create(newGame, gameSettings, about);
            menu.alignItemsVerticallyWithPadding(10);
            this.addChild(menu, 1, 2);
            menu.setPosition(winSize.width / 2 , winSize.height / 2 - 80);

            this.bigImgLen = LLK.CONTAINER.BIGIMAGES.length;
            this._logo = cc.Sprite.createWithSpriteFrameName(LLK.CONTAINER.BIGIMAGES[Math.floor( Math.random()*this.bigImgLen)]);
            this._logo.setAnchorPoint(cc.p(0, 0));
            this._logo.setPosition(winSize.width/2 -100, 300);
            this.addChild(this._logo, 10, 1);
            var animFrames = []; //      将所有帧存入一个数组
            for (var i=0;i<this.bigImgLen;i++) {
                //采用循环添加动画的每一帧
                var frame =this._logoFrameCache.getSpriteFrame(LLK.CONTAINER.BIGIMAGES[i]);
                if (frame) {
                    animFrames.push(frame);
                }
            }
            //        创建动画，设置播放间隔
            var animation = cc.Animation.create(animFrames, 1);
            // animation.setDelayPerUnit(0.1);
            //设置动画播放完成是否保持在第一帧，true为保持在第一帧，false为保持在最后一帧
            //animation.setRestoreOriginalFrame(false);
            this._logo.runAction(cc.RepeatForever.create(cc.Animate.create(animation)));

//            this.imagesArrLen = LLK.CONTAINER.MENGIMAGES.length;
//            this._hero = cc.Sprite.createWithSpriteFrameName(LLK.CONTAINER.MENGIMAGES[Math.ceil( Math.random()*this.imagesArrLen)]);
//            this._hero.setAnchorPoint(cc.p(0, 0));
//            var pos = cc.p(Math.min(Math.random() * winSize.width , 34), 34);
//            this._hero.setPosition( pos );
//            this._hero.velocity = cc.p(50, 50);
//            this.addChild(this._hero, 0, 4);

            if (LLK.SOUND) {
                cc.AudioEngine.getInstance().setMusicVolume(0.7);
                cc.AudioEngine.getInstance().playMusic(s_mainMainMusic_mp3, true);
            }

//            this.schedule(this.update, 0.05);//schedule(callback_fn, interval, repeat, delay)
            // 里面四个参数对应的含义是：
            // callback_fn：调用的方法名
            // interval：间隔多久再进行调用 单位是秒
            // repeat：重复的次数
            // delay：延迟多久再进行调用
            bRet = true;
        }
        return bRet;
    },
    onNewGame:function (pSender) {
        //load resources
        cc.Loader.preload(g_maingame, function () {
            var scene = cc.Scene.create();
            scene.addChild(GameLayer.create());
            scene.addChild(GameControlMenu.create());
            cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.2, scene));
        }, this);
    },
    onSettings:function (pSender) {
        this.onButtonEffect();
        var scene = cc.Scene.create();
        scene.addChild(SettingsLayer.create());
        cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
    },
    onAbout:function (pSender) {
        this.onButtonEffect();
        var scene = cc.Scene.create();
        scene.addChild(AboutLayer.create());
        cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.0, scene));
    },
  /*  update:function () {
        this._hero.setPosition(cc.pAdd(this._hero.getPosition(), cc.pMult(this._hero.velocity, 0.1)));
        this.checkHitEdge();
    },

    //检查边界碰撞
    checkHitEdge: function () {
        var pos = this._hero.getPosition();
        var contentSize = this._hero.getContentSize();
        //英雄碰到右边边界 或者英雄碰到左边边界
        if (pos.x >= winSize.width - 35 || pos.x <= 35) {
            this._hero.velocity.x *= -1;//改变水平速度方向
//            hero.setDisplayFrame(LLK.CONTAINER.BIGIMAGES[ Math.ceil( Math.random()*this.imagesArrLen)]);
//            this._logo.initWithSpriteFrameName(LLK.CONTAINER.BIGIMAGES[Math.ceil( Math.random()*this.bigImgLen)]);
//            this._logo.setAnchorPoint(cc.p(0, 0));
            this._hero.initWithSpriteFrameName(LLK.CONTAINER.MENGIMAGES[Math.floor( Math.random()*this.imagesArrLen)]);
        }
        //英雄碰到上边边界或者碰到下面边界
        if (pos.y >= winSize.height - 35|| pos.y <= 35) {
            this._hero.velocity.y *= -1;
            this._hero.initWithSpriteFrameName(LLK.CONTAINER.MENGIMAGES[Math.floor( Math.random()*this.imagesArrLen)]);
        }
    },*/
    onButtonEffect:function(){
        if (LLK.SOUND) {
            var s = cc.AudioEngine.getInstance().playEffect(s_buttonEffect_mp3);
        }
    }
});

SysMenu.create = function () {
    var sg = new SysMenu();
    if (sg && sg.init()) {
        return sg;
    }
    return null;
};

SysMenu.scene = function () {
    var scene = cc.Scene.create();
    var layer = SysMenu.create();
    scene.addChild(layer);
    return scene;
};
