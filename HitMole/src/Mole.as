package 
{
	import laya.ui.Image;
	import laya.net.Loader;
	import laya.utils.Handler;
	import laya.events.Event;
	import laya.utils.Tween;
	import laya.utils.Ease;
	/**
	 * ...
	 * @author ...
	 */
	public class Mole 
	{
		private var normalState:Image;
		private var hitState:Image;
		private var downY:Number;
		private var upY:Number;
		private var scoreImg:Image;
		private var scoreY:Number;
		private var hitCallBackHd:Handler;
		
		private var isActive:Boolean;
		private var isShow:Boolean;
		private var isHit:Boolean;
		
		private var type:int;
		
		public function Mole(normalState:Image,hitState:Image,scoreImg:Image,downY:Number,hitCallBackHd:Handler) 
		{
			this.normalState = normalState;
			this.hitState = hitState;
			this.scoreImg = scoreImg;
			this.scoreY = scoreImg.y;
			this.downY = downY;
			this.upY = this.normalState.y;
			this.hitCallBackHd = hitCallBackHd;
			this.reset();
			this.normalState.on(Event.CLICK, this, this.hit);
		}
		
		//重置方法
		private function reset():void{
			this.normalState.visible = false;
			this.hitState.visible = false;
			this.scoreImg.visible = false;
			this.isActive = false;
			this.isShow = false;
			this.isHit = false;
		}
		
		//show
		public function show():void{
			if (this.isActive) return;
			this.isActive = true;
			this.isShow = true;
			this.type = Math.random() < 0.3?1:2;
			this.normalState.skin = "ui/mouse_normal_" + type+".png";
			this.hitState.skin = "ui/mouse_hit_" + type+".png";
			this.scoreImg.skin = "ui/score_" + type+".png";
			this.normalState.y = this.downY;
			this.normalState.visible = true;
			//驅動方式
			Tween.to(this.normalState, { y:this.upY }, 500, Ease.backOut, Handler.create(this, this.showComplete));
		}
		
		//停留
		private function showComplete():void {
			if (this.isShow && !this.isHit){
			Laya.timer.once(2000, this, this.hide);
			}	
		}
		
		//消失
		private function hide():void {
			if(this.isShow && !this.isHit ){
			this.isShow = false;
			//緩動消失
			Tween.to(this.normalState, { y:this.downY },300, Ease.backIn, Handler.create(this, this.reset));
			}
			
		}
		
		//受擊
		private function hit():void {
			if(this.isShow && !this.isHit){
			this.isHit = true;
			Laya.timer.clear(this,this.hide);
			this.normalState.visible = false;
			this.hitState.visible = true;
			Laya.timer.once(500, this, this.reset);
			this.hitCallBackHd.runWith(this.type);
			this.showScore();
			}
		
		}
		
		//顯示得分飄字
		private function showScore():void{
			this.scoreImg.y = this.scoreY - 30;
			this.scoreImg.scale(0, 0);
			this.scoreImg.visible = true;
			//緩動向上放大顯示
			Tween.to(this.scoreImg, { y:this.scoreY, scaleX:1, scaleY:1 }, 300, Ease.backOut);
		}
		
}
}