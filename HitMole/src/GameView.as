package 
{
	import laya.ui.Box;
	import laya.ui.Image;
	import laya.utils.Handler;
	import ui.GameUI;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameView extends GameUI 
	{
		private var moles:Vector.<Mole>;
		private var moleNum:int = 9;
		private var score:Number;
		private var hammer:Hammer;
		
		public function GameView()
		{
			super();
			moles = new Vector.<Mole>();
			var hitCallBackHd:Handler = new Handler(this, this.setScore);
			//mole = new Mole(this.normal, this.hit, 21);
			
			for (var i:int = 0; i < moleNum;i++ ){
				var box:Box = this.getChildByName("item" + i) as Box;
				var mole:Mole =  new Mole(
				box.getChildByName("normal") as Image,
				box.getChildByName("hit") as Image,
				box.getChildByName("score") as Image,
				21,hitCallBackHd
				);
				moles.push(mole);
			}
			hammer = new Hammer();
			this.addChild(hammer);
			hammer.visible = false;
		}
		public function gameStart():void{
			this.timeBar.value = 1;
			this.score = 0;
			this.updateScoreUI();
			hammer.visible = true;
			hammer.start();
			Laya.timer.loop(1000,this,this.onLoop);
		}
		
		private function onLoop():void{
			//mole.show();
			this.timeBar.value -= 1 / 10;
			if(this.timeBar.value<=0){
				this.gameOver();
				return;
			}
			var index:int = Math.floor(Math.random() * this.moleNum);
			moles[index].show();
		}
		
		private function gameOver():void{
			Laya.timer.clear(this, this.onLoop);
			hammer.visible = false;
			hammer.end();
			trace("game over");
			//顯示遊戲結束介面
			if(!LayaSample.gameOver){
				LayaSample.gameOver = new GameOver();
			}
			LayaSample.gameOver.centerX = 0;
			LayaSample.gameOver.centerY = 40;
			LayaSample.gameOver.setScore(this.score);
			this.addChild(LayaSample.gameOver);
		}
		//分數更新
		private function setScore(type:int):void{
			this.score += type == 1? -100:100;
			if(this.score<0){
				this.score = 0;
			}
			this.updateScoreUI();
		}
		private function updateScoreUI():void{
			//this.scoreNums.dataSource
			var data:Object = { };
			var temp:Number = this.score;
			for (var i:int = 9; i >= 0;i-- ) {
				data["item" + i] = { index:Math.floor(temp % 10) };
				temp /= 10;
			}
			this.scoreNums.dataSource = data;
		}
	}
}