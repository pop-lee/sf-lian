package cn.sftec.www.view
{
	import cn.sftec.www.event.ChangePageEvent;
	import cn.sftec.www.model.ModelLocator;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFButton;
	import cn.sftech.www.view.SFContainer;
	import cn.sftech.www.view.SFLabel;
	
	import flash.events.MouseEvent;

	public class ScoreListPage extends SFContainer
	{
		private var _scoreCount : int = 10;
		
		private var _dataProvider : Vector.<int> = new Vector.<int>;
		
		private var _scoreListView : Array = new Array();
		
		public function ScoreListPage()
		{
			super();
			
			var textFieldY : int = 20;
			for(var i: int = 0;i<_scoreCount;i++) {
				var _textField : SFLabel = new SFLabel();
				_textField.text = "第" + (i+1) + "名";
				_textField.x = 40;
				_textField.y = textFieldY ;
				textFieldY = _textField.y + _textField.height + 7;
				_scoreListView.push(_textField);
				this.addChild(_textField);
			}
			
			
			var backMainBtn : SFButton = new SFButton();
			backMainBtn.width = 100;
			backMainBtn.height = 30;
			backMainBtn.x = 5;
			backMainBtn.y = 290;
//			backMainBtn.label = "";
//			backMainBtn.backgroundImage = ModelLocator.getImageResource("returnBtn");
			backMainBtn.addEventListener(MouseEvent.CLICK,toMainPage);
			addChild(backMainBtn);
		}
		
		public function set dataProvider(_arr : Vector.<int>) : void
		{
			_dataProvider = _arr;
			updateData();
		}
		
		private function updateData() : void
		{
			for(var k:int = 0;k<_scoreCount;k++) {
				(_scoreListView[k] as SFLabel).text ="第" + (k+1) + "名" + "   " + ((_dataProvider.length<k+1)?0:_dataProvider[k]) + "分";
			}
		}
		
		private function toMainPage(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent();
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			SFApplication.application.dispatchEvent(changePageEvent);
		}
	}
}