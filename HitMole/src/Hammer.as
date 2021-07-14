package 
{
	import ui.HammerUI;
	import laya.utils.Mouse;
	import laya.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Hammer extends HammerUI 
	{
		
		public function Hammer() 
		{
			super();
		}
		
		public function start():void{
			Mouse.hide();
			Laya.stage.on(Event.MOUSE_MOVE, this,onMouseMove);
			Laya.stage.on(Event.MOUSE_DOWN, this,onMouseDown);
			onMouseMove();
		}
		
		private function onMouseDown():void{
			this.hit.play(0, false);
		}
		
		private function onMouseMove():void{
			this.pos(Laya.stage.mouseX-this.width/2,Laya.stage.mouseY-this.height/3);
		}
		
		public function end():void{
			Mouse.show();
			Laya.stage.off(Event.MOUSE_MOVE, this,onMouseMove);
			Laya.stage.off(Event.MOUSE_DOWN, this,onMouseDown);
		}

}
}