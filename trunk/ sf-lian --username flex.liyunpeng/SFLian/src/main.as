package
{
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFViewStack;
	import cn.sftec.www.view.MainPage;
	
	import flash.display.Sprite;
	
	[SWF(width="240",height="320")]
	public class main extends SFApplication
	{
		//主显示栈
		private var vs : SFViewStack = new SFViewStack();
		
		public function main()
		{
			
		}
		
		override protected function init():void 
		{
		}
		
		private function initUI():void
		{
			var mainPage : MainPage = new MainPage();
			vs.addItem(mainPage);
		}
	}
}