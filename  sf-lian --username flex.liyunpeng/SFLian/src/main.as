package
{
	import cn.sftec.www.event.ChangePageEvent;
	import cn.sftec.www.model.ModelLocator;
	import cn.sftec.www.view.GamePage;
	import cn.sftec.www.view.IntrPage;
	import cn.sftec.www.view.MainPage;
	import cn.sftec.www.view.ScoreListPage;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFScoreList;
	import cn.sftech.www.view.SFViewStack;
	
	import com.qq.openapi.MttService;
	
	import flash.display.Sprite;
	
	[SWF(width="240",height="320")]
	public class main extends SFApplication
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		//主显示栈
		private var vs : SFViewStack = new SFViewStack();
		
		private var mainPage : MainPage;
		private var gamePage : GamePage;
		private var intrPage : IntrPage;
		private var scoreListPage : ScoreListPage;
		
		public function main()
		{
			
		}
		
		override protected function init():void 
		{
			initUI();
		}
		
		private function initUI():void
		{
			vs.percentWidth = 100;
			vs.percentHeight = 100;
			this.addChild(vs);
			
			var mainPage : MainPage = new MainPage();
			mainPage.percentWidth = 100;
			mainPage.percentHeight = 100;
			mainPage.backgroundAlpha = 0;
			mainPage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(mainPage);
			
			gamePage = new GamePage();
			gamePage.percentWidth = 100;
			gamePage.percentHeight = 100;
			gamePage.backgroundAlpha = 0;
			gamePage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(gamePage);
			
			intrPage = new IntrPage();
			intrPage.percentWidth = 100;
			intrPage.percentHeight = 100;
			intrPage.backgroundColor = 0x00ff00;
			intrPage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(intrPage);
			
			scoreListPage = new ScoreListPage();
			scoreListPage.percentWidth = 100;
			scoreListPage.percentHeight = 100;
			scoreListPage.backgroundColor = 0x0000ff;
			scoreListPage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(scoreListPage);
		}
		
		private function changePageHandle(event : ChangePageEvent):void
		{
			if(event.data == ChangePageEvent.TO_SCORELIST_PAGE) {
				scoreListPage.dataProvider = _model.topScoreArr;
			} else if(event.data == ChangePageEvent.EXIT) {
				MttService.exit();
				return;
			}
			vs.selectedIndex = event.data;
		}
	}
}