package 
{
	import ui.GameStartUI;
	import laya.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameStart extends GameStartUI 
	{
		
		public function GameStart() 
		{
			super();
			this.startBtn.on(Event.CLICK, this, this.startGame);
		}
		private function startGame():void{
			//移除遊戲開始介面
			this.removeSelf();			
			
			//添加遊戲介面
		if(!LayaSample.gameView){
			LayaSample.gameView = new GameView();
		}
		LayaSample.gameView.gameStart();
		Laya.stage.addChild(LayaSample.gameView);
	}

}
}