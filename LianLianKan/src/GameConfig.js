/**
 *  LianLianKan game config
 *
 * @Licensed:
 * no
 *
 *  @Authors:
 *  Programmer: Jacky（王浩杰）
 *
 */

//game state
LLK.GAME_STATE = {
    HOME:0,
    PLAY:1,
    OVER:2
};

//keys
LLK.KEYS = [];

//level
LLK.LEVEL = {
    x:6,
    y:8,
    STAGE1:1,
    STAGE2:2,
    STAGE3:3
};

//time
LLK.TIME = "";

//sound
LLK.SOUND = true;

LLK.MODE = true;
LLK.COUNT = 0;
//container
LLK.CONTAINER = {
    MENGIMAGES:["loveImage1.jpg","loveImage2.jpg","loveImage3.jpg","loveImage4.jpg","loveImage5.jpg","loveImage6.jpg",
        "loveImage7.jpg","loveImage8.jpg","loveImage9.jpg","loveImage10.jpg","loveImage11.jpg","loveImage12.jpg","loveImage13.jpg",
        "loveImage14.jpg","loveImage15.jpg","loveImage16.jpg","loveImage17.jpg","loveImage18.jpg","loveImage19.jpg","loveImage20.jpg",
        "loveImage21.jpg","loveImage22.jpg","loveImage23.jpg","loveImage24.jpg","loveImage25.jpg","loveImage26.jpg","loveImage27.jpg",
        "loveImage28.jpg"],
    NORMALIMAGES:["normalImage1.jpg","normalImage2.jpg","normalImage3.jpg","normalImage4.jpg","normalImage5.jpg","normalImage6.jpg",
        "normalImage7.jpg","normalImage8.jpg","normalImage9.jpg","normalImage10.jpg","normalImage11.jpg","normalImage12.jpg",
        "normalImage13.jpg","normalImage14.jpg","normalImage15.jpg","normalImage16.jpg","normalImage17.jpg","normalImage18.jpg",
        "normalImage19.jpg","normalImage20.jpg","normalImage21.jpg","normalImage22.jpg","normalImage23.jpg","normalImage24.jpg",
        "normalImage25.jpg","normalImage26.jpg","normalImage27.jpg","normalImage28.jpg","normalImage29.jpg","normalImage30.jpg",
        "normalImage31.jpg","normalImage32.jpg","normalImage33.jpg","normalImage34.jpg",
        "normalImage35.jpg","normalImage36.jpg","normalImage37.jpg","normalImage38.jpg","normalImage39.jpg","normalImage40.jpg",
        "normalImage41.jpg","normalImage42.jpg","normalImage43.jpg","normalImage44.jpg","normalImage45.jpg","normalImage46.jpg",
        "normalImage47.jpg","normalImage48.jpg","normalImage49.jpg","normalImage50.jpg","normalImage51.jpg","normalImage52.jpg",
        "normalImage53.jpg","normalImage54.jpg","normalImage55.jpg","normalImage56.jpg","normalImage57.jpg","normalImage58.jpg",
        "normalImage59.jpg","normalImage60.jpg","normalImage61.jpg","normalImage62.jpg","normalImage63.jpg","normalImage64.jpg",
        "normalImage65.jpg","normalImage66.jpg","normalImage67.jpg","normalImage68.jpg","normalImage69.jpg","normalImage70.jpg",
        "normalImage71.jpg","normalImage72.jpg","normalImage73.jpg","normalImage74.jpg","normalImage75.jpg","normalImage76.jpg",
        "normalImage77.jpg","normalImage78.jpg","normalImage79.jpg","normalImage80.jpg","normalImage81.jpg","normalImage82.jpg",
        "normalImage83.jpg","normalImage84.jpg","normalImage85.jpg","normalImage86.jpg","normalImage87.jpg","normalImage88.jpg",
        "normalImage89.jpg","normalImage90.jpg","normalImage91.jpg","normalImage92.jpg","normalImage93.jpg","normalImage94.jpg",
        "normalImage95.jpg","normalImage96.jpg","normalImage97.jpg","normalImage98.jpg","normalImage99.jpg","normalImage100.jpg",
        "normalImage101.jpg","normalImage102.jpg","normalImage103.jpg","normalImage104.jpg","normalImage105.jpg","normalImage106.jpg",
        "normalImage107.jpg","normalImage108.jpg","normalImage109.jpg", "normalImage110.jpg","normalImage111.jpg","normalImage112.jpg",
        "normalImage113.jpg","normalImage114.jpg","normalImage115.jpg","normalImage116.jpg","normalImage117.jpg","normalImage118.jpg"],
    BIGIMAGES:["bigImage1.jpg","bigImage2.jpg","bigImage3.jpg","bigImage4.jpg","bigImage5.jpg","bigImage6.jpg",
        "bigImage7.jpg","bigImage8.jpg","bigImage9.jpg","bigImage10.jpg","bigImage11.jpg","bigImage12.jpg",
        "bigImage13.jpg","bigImage14.jpg","bigImage15.jpg","bigImage16.jpg","bigImage17.jpg"/*,"bigImage18.jpg",
        "bigImage19.jpg","bigImage20.jpg","bigImage21.jpg"*/],
    SPARKS:[],
    EXPLOSIONS:[]
};

var g_hideSpritePos = cc.p( -10, -10);