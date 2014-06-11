var GameOver = cc.Layer.extend({
    init:function () {
        var bRet = false;
        if (this._super()) {
            var sp = cc.Sprite.create(s_b05);
            sp.setAnchorPoint( cc.p(0,0) );
            this.addChild(sp, 0, 1);

            var logo = cc.Sprite.create(s_gameOver);
            logo.setAnchorPoint(cc.p(0,0));
            logo.setPosition(20,350);
            this.addChild(logo,10,1);

            var playAgainNormal = cc.Sprite.create(s_menu, cc.rect(378, 0, 126, 33));
            var playAgainSelected = cc.Sprite.create(s_menu, cc.rect(378, 33, 126, 33));
            var playAgainDisabled = cc.Sprite.create(s_menu, cc.rect(378, 33 * 2, 126, 33));

            var playAgain = cc.MenuItemSprite.create(playAgainNormal, playAgainSelected, playAgainDisabled, function(){
                flareEffect(this,this,this.onPlayAgain);
            }.bind(this) );

            var menu = cc.Menu.create(playAgain);
            this.addChild(menu, 1, 2);
            menu.setPosition(winSize.width / 2, 280);

            if(!localStorage.getItem("bestScore")){
                localStorage.setItem("bestScore",g_sharedGameLayer._timeString);
            };
            var lbScore = cc.LabelTTF.create("TIME "+g_sharedGameLayer._timeString,"Forte",26);
            lbScore.setPosition(winSize.width / 2,200);
            lbScore.setColor(cc.c3b(200,38,12));
//            lbScore.enableStroke(cc.c3b(0,0,0), 26);
            this.addChild(lbScore,10);

            var bestString = localStorage.getItem("bestScore");
            var bestArr = bestString.split(":");
            var sTime = bestArr[0]*60 + bestArr[1];
            if(sTime > g_sharedGameLayer._time){
                localStorage.setItem("bestScore",g_sharedGameLayer._timeString);
            }
            var bestScore = cc.LabelTTF.create("BEST TIME "+localStorage.getItem("bestScore"),"Forte",26);
            bestScore.setPosition(180,150);
            bestScore.setColor(cc.c3b(200,38,12));
            this.addChild(bestScore,10);

            if(LLK.SOUND){
                cc.AudioEngine.getInstance().playMusic(s_mainMainMusic_mp3);
            }

            bRet = true;
        }
        return bRet;
    },
    onPlayAgain:function (pSender) {
        var scene = cc.Scene.create();
        scene.addChild(GameLayer.create());
        scene.addChild(GameControlMenu.create());
        cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.2,scene));
    }
});

GameOver.create = function () {
    var sg = new GameOver();
    if (sg && sg.init()) {
        return sg;
    }
    return null;
};

GameOver.scene = function () {
    var scene = cc.Scene.create();
    var layer = GameOver.create();
    scene.addChild(layer);
    return scene;
};
