package {
	import laya.net.Loader;
	import laya.utils.Handler;
	import laya.display.Stage;
	
	public class LayaSample {
		
		public static var gameStart:GameStart;
		public static var gameView:GameView;
		public static var gameOver:GameOver;
		
		public function LayaSample() {
			//初始化引擎
			Laya.init(800, 600);
			//Laya.stage.scaleMode = Stage.SCALE_NOSCALE; //不隨著螢幕縮放
			Laya.stage.scaleMode=Stage.SCALE_SHOWALL;  //隨著螢幕縮放
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			//Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			Laya.stage.bgColor = "#FFCCCC";
			var resArray:Array = [
			{url:"res/atlas/ui.json",type:Loader.ATLAS},
			{url:"ui/back.png",type:Loader.IMAGE}
			];
			Laya.loader.load(resArray, Handler.create(this, this.onLoaded));
		}
		private function onLoaded():void{
			//show view
			//var view:GameView = new GameView();
			
			gameStart = new GameStart();
			Laya.stage.addChild(gameStart);
			
		}
	}
}