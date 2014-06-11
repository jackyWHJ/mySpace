var AboutLayer = cc.Layer.extend({
    init:function () {
        var bRet = false;
        if (this._super()) {
            var sp = cc.Sprite.create(s_b02);
            sp.setAnchorPoint(cc.p(0,0));
            this.addChild(sp, 0, 1);

            var cacheImage = cc.TextureCache.getInstance().addImage(s_menuTitle);
            var title = cc.Sprite.createWithTexture(cacheImage, cc.rect(0, 36, 100, 34));
            title.setPosition( winSize.width / 2, winSize.height - 60 );
            this.addChild(title);

            // There is a bug in LabelTTF native. Apparently it fails with some unicode chars.
            var about = cc.LabelTTF.create("This is a casual game.\n Move the block when the same block " +
                " in the line they will disappear. clear up all the block in the screen the game is over .it's easy. just have a try." +
                " \n \n Programmer: jacky(王浩杰)\n email:719810496@qq.com", "Arial", 20,
                cc.size(winSize.width * 0.85, 320), cc.TEXT_ALIGNMENT_CENTER );
            about.setPosition(winSize.width / 2,  winSize.height/2 );
            about.setAnchorPoint( cc.p(0.5, 0.5) );
            this.addChild(about);

            var label = cc.LabelTTF.create("Go back", "Arial", 20);
            var back = cc.MenuItemLabel.create(label, this.onBackCallback);
            var menu = cc.Menu.create(back);
            menu.setPosition( winSize.width / 2, 50);
            this.addChild(menu);
            bRet = true;
        }

        return bRet;
    },
    onBackCallback:function (pSender) {
        var scene = cc.Scene.create();
        scene.addChild(SysMenu.create());
        cc.Director.getInstance().replaceScene(cc.TransitionFade.create(1.2, scene));
    }
});

AboutLayer.create = function () {
    var sg = new AboutLayer();
    if (sg && sg.init()) {
        return sg;
    }
    return null;
};
