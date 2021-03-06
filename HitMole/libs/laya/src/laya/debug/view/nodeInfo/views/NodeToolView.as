package laya.debug.view.nodeInfo.views 
{
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.ui.Button;
	import laya.debug.tools.ClassTool;
	import laya.debug.DebugTool;
	import laya.debug.tools.DisControlTool;
	import laya.debug.tools.MouseEventAnalyser;
	import laya.debug.view.nodeInfo.NodeInfoPanel;
	import laya.debug.view.nodeInfo.nodetree.NodeTool;
	import laya.debug.view.nodeInfo.ToolPanel;
	/**
	 * ...
	 * @author ww
	 */
	public class NodeToolView extends UIViewBase 
	{
		
		public function NodeToolView() 
		{
			super();
			
		}
		private static var _I:NodeToolView;
		public static function get I():NodeToolView
		{
			if (!_I) _I = new NodeToolView();
			return _I;
		}
		override public function show():void 
		{
			showByNode();
		}
		public var view:NodeTool;
		override public function createPanel():void
		{

			view = new NodeTool();
			addChild(view);
			view.on(Event.CLICK, this, onBtnClick);
			view.closeBtn.on(Event.CLICK, this, onCloseBtn);
			DisControlTool.setDragingItem(view.bg, view);
			dis = view;
			
			view.freshBtn.on(Event.CLICK, this, onFreshBtn);
			dragIcon = view.dragIcon;
			dragIcon.removeSelf();
			dragIcon.on(Event.DRAG_END, this, mouseAnalyserDragEnd);
			view.mouseAnalyseBtn.on(Event.MOUSE_DOWN, this, mouseAnalyserMouseDown);
		}
		private var dragIcon:Sprite;
		private static var tempPos:Point=new Point();
		private function mouseAnalyserMouseDown():void
		{
			var gPos:Point = tempPos;
			gPos.setTo(0, 0);
			gPos = view.mouseAnalyseBtn.localToGlobal(gPos);
			dragIcon.pos(gPos.x, gPos.y);
			dragIcon.mouseEnabled = false;
			Laya.stage.addChild(dragIcon);
			dragIcon.startDrag();
			
		}
		private function mouseAnalyserDragEnd():void
		{
			dragIcon.removeSelf();
			if (NodeToolView.I.target)
			{
				MouseEventAnalyser.analyseNode(NodeToolView.I.target);
			}
		}
		private function onFreshBtn():void
		{
			if (!_tar) return;
			_tar.reCache();
			_tar.repaint();
		}
		private function onCloseBtn():void
		{
			close();
		}
		private function onBtnClick(e:Event):void
		{
			if (!_tar) return;
			var tar:Sprite;
		    tar = e.target;
			trace("onBtnClick:", tar);
			var txt:String;
			txt = (tar as Button).label;
			switch(txt)
			{
				case "??????":
					DebugTool.showParentChain(_tar);
					SelectInfosView.I.setSelectList(DebugTool.selectedNodes);
					break;
				case "???":
					DebugTool.showAllChild(_tar);
					SelectInfosView.I.setSelectList(DebugTool.selectedNodes);
					break;
				case "??????":
					DebugTool.showAllBrother(_tar);
					SelectInfosView.I.setSelectList(DebugTool.selectedNodes);
					break;
				case "Enable???":
					OutPutView.I.dTrace(DebugTool.traceDisMouseEnable(_tar));
					SelectInfosView.I.setSelectList(DebugTool.selectedNodes);
					break;
				case "Size???":
					OutPutView.I.dTrace(DebugTool.traceDisSizeChain(_tar));
					SelectInfosView.I.setSelectList(DebugTool.selectedNodes);
					break;
				case "????????????":
					NodeInfoPanel.I.recoverNodes();
					NodeInfoPanel.I.hideOtherChain(_tar);
					break;
				case "????????????":
					NodeInfoPanel.I.recoverNodes();
					NodeInfoPanel.I.hideBrothers(_tar);
					break;
				case "?????????":
					NodeInfoPanel.I.recoverNodes();
					NodeInfoPanel.I.hideChilds(_tar);
					break;
				case "??????":
					NodeInfoPanel.I.recoverNodes();
					break;
				case "???????????????":
					ToolPanel.I.showSelectInStage(_tar);
					break;
				case "????????????":
					DebugTool.showDisBound(_tar);
					break;
				case "??????????????????":
					trace(_tar);
					break;
				case "????????????":
					_tar.visible = !_tar.visible;
					break;
				
			}
		}
		public function showByNode(node:Sprite=null,ifShow:Boolean=true):void
		{
			if (!node) node = Laya.stage;
			if(ifShow)
			super.show();
			_tar = node;
			fresh();	
		}
		public function get target():Sprite
		{
			return _tar;
		}
		private var _tar:Sprite;
		public function fresh():void
		{
			if (!_tar) return;
			view.tarTxt.text = ClassTool.getNodeClassAndName(_tar);
			
		}
	}

}