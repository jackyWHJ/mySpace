var dirImg = "res/";
var dirMusic = "res/Music/";

//image
//var s_loading = dirImg + "loading.png";
var s_menu = dirImg + "menu.png";
var s_b01 = dirImg + "bgImage1.jpg";
var s_b02 = dirImg + "bgImage2.jpg";
var s_b03 = dirImg + "bgImage3.jpg";
var s_b04 = dirImg + "bgImage4.jpg";
var s_b05 = dirImg + "bgImage5.jpg";
//var s_b06 = dirImg + "bgImage6.jpg";
//var s_cocos2dhtml5 = dirImg + "cocos2d-html5.png";
var s_gameOver = dirImg + "gameOver.png";
var s_menuTitle = dirImg + "menuTitle.png";
var s_flare = dirImg + "flare.jpg";
var s_explosion = dirImg + "explosion.png";
var s_arial14 = dirImg + "arial-14.png";
var s_arial14_fnt = dirImg + "arial-14.fnt";
var s_textureOpaquePack = dirImg + "textureOpaquePack.png";
var s_textureLoveImage = dirImg + "loveImage.png";
var s_textureBigImage = dirImg + "bigImage.png";
var s_textureNormalImage = dirImg + "normalImage.png";

//music
var s_bgMusic_mp3 = dirMusic + "bgMusic.mp3";
var s_mainMainMusic_mp3 = dirMusic + "mainMainMusic.mp3";

//effect
var s_buttonEffect_mp3 = dirMusic + "buttonEffet.mp3";
var s_explodeEffect_mp3 = dirMusic + "explodeEffect.mp3";
var s_fireEffect_mp3 = dirMusic + "fireEffect.mp3";
var s_shipDestroyEffect_mp3 = dirMusic + "shipDestroyEffect.mp3";

//var s_bgMusic_ogg = dirMusic + "bgMusic.ogg";
//var s_mainMainMusic_ogg = dirMusic + "mainMainMusic.ogg";
//
////effect
//var s_buttonEffect_ogg = dirMusic + "buttonEffet.ogg";
//var s_explodeEffect_ogg = dirMusic + "explodeEffect.ogg";
//var s_fireEffect_ogg = dirMusic + "fireEffect.ogg";
//var s_shipDestroyEffect_ogg = dirMusic + "shipDestroyEffect.ogg";

//plist
var s_explosion_plist = dirImg + "explosion.plist";
var s_textureOpaquePack_plist = dirImg + "textureOpaquePack.plist";
var s_textureLoveImage_plist = dirImg + "loveImage.plist";
var s_textureBigImage_plist = dirImg + "bigImage.plist";
var s_textureNormalImage_plist = dirImg + "normalImage.plist";

var g_mainmenu = [
    {src:s_flare},
    {src:s_menu},
	{src:s_b01},
    {src:s_b02},
    {src:s_b03},
    {src:s_b04},
    {src:s_b05},
    {src:s_mainMainMusic_mp3},
    {src:s_menuTitle},
    {src:s_textureBigImage},
    {src:s_textureBigImage_plist},
    {src:s_textureLoveImage},
    {src:s_textureLoveImage_plist}
];

var g_maingame = [
    //image
    {src:s_gameOver},
    {src:s_arial14},
    {src:s_explosion},
    {src:s_textureOpaquePack},
    {src:s_textureLoveImage},
    {src:s_textureNormalImage},

    //plist
    {src:s_explosion_plist},
    {src:s_textureOpaquePack_plist},
    {src:s_textureLoveImage_plist},
    {src:s_textureNormalImage_plist},

    //music
    {src:s_bgMusic_mp3},

    //effect
    {src:s_buttonEffect_mp3},
    {src:s_explodeEffect_mp3},
    {src:s_fireEffect_mp3},
    {src:s_shipDestroyEffect_mp3},

    // FNT
    {src:s_arial14_fnt}
];
