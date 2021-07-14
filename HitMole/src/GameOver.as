package 
{
	import ui.GameOverUI;
	import laya.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameOver extends GameOverUI 
	{
		
		public function GameOver() 
		{
			super();
			this.restarBtn.on(Event.CLICK, this, this.restartGame);
		}
		
		private function restartGame():void{
			//移除遊戲結束介面
			this.removeSelf();
			//移除遊戲中的介面
			LayaSample.gameView.removeSelf();
			//添加遊戲開始
			Laya.stage.addChild(LayaSample.gameStart);
		}
		
		//設置分數
		public function setScore(score:Number):void{
			var data:Object = { };
			var temp:Number = score;
			for (var i:int = 9; i >= 0;i-- ) {
				data["item" + i] = { index:Math.floor(temp % 10) };
				temp /= 10;
			}
			this.scoreNums.dataSource = data;
		}
		
	}

}