package
{
	import cn.sftec.www.event.ChangePageEvent;
	import cn.sftec.www.model.ModelLocator;
	import cn.sftec.www.view.GamePage;
	import cn.sftec.www.view.IntrPage;
	import cn.sftec.www.view.MainPage;
	import cn.sftec.www.view.ScoreListPage;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFLogo;
	import cn.sftech.www.view.SFScoreList;
	import cn.sftech.www.view.SFViewStack;
	
	import com.qq.openapi.MttScore;
	import com.qq.openapi.MttService;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
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
		
		private var logo : SFLogo;
		
		public function main()
		{
			
		}
		
		override protected function init():void 
		{
			this.addEventListener(Event.ENTER_FRAME,hideLogo);
			logo = new SFLogo();
			logo.width = this.width;
			logo.height = this.height;
			addChild(logo);
			
			MttService.initialize(root, "D5FE393C02DB836FFDE413B8794056ED","326");
			MttService.addEventListener(MttService.ETLOGOUT, onLogout);
			
			initData();
			initUI();
		}
		
		private function hideLogo(event : Event) : void
		{
			if(logo.alpha > 0) {
				logo.alpha -= 0.03;
			} else {
				this.removeEventListener(Event.ENTER_FRAME,hideLogo);
				removeChild(logo);
				logo = null;
			}
		}
		
		private function initData() : void
		{
			MttScore.query(queryScoreHandle);
		}
		
		private function onLogout(e:Event):void
		{
			MttService.login();
		}
		
		private function initUI():void
		{
			vs.backgroundColor = 0x00ff00;
			vs.backgroundAlpha = 1;
			vs.percentWidth = 100;
			vs.percentHeight = 100;
			this.addChildAt(vs,0);
			
			
			SFApplication.application.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			
			var mainPage : MainPage = new MainPage();
			mainPage.percentWidth = 100;
			mainPage.percentHeight = 100;
			mainPage.backgroundAlpha = 0;
			vs.addItem(mainPage);
			
			gamePage = new GamePage();
			gamePage.percentWidth = 100;
			gamePage.percentHeight = 100;
			gamePage.backgroundAlpha = 0;
			vs.addItem(gamePage);
			
			intrPage = new IntrPage();
			intrPage.percentWidth = 100;
			intrPage.percentHeight = 100;
			intrPage.backgroundAlpha = 0;
			vs.addItem(intrPage);
			
			scoreListPage = new ScoreListPage();
			scoreListPage.percentWidth = 100;
			scoreListPage.percentHeight = 100;
			scoreListPage.backgroundAlpha = 0
			vs.addItem(scoreListPage);
		}
		
		private function changePageHandle(event : ChangePageEvent):void
		{
			if(event.data == ChangePageEvent.TO_GAME_PAGE) {
				gamePage.startGame();
			} else if(event.data == ChangePageEvent.TO_SCORELIST_PAGE) {
				scoreListPage.dataProvider = _model.topScoreArr;
			} else if(event.data == ChangePageEvent.EXIT) {
				MttService.exit();
				return;
			}
			vs.selectedIndex = event.data;
		}
		
		private function queryScoreHandle(result : Object) : void
		{
			if(result.code == 0) {
				var items:Array = result.board as Array;
				for (var i:int = 0; i < items.length; i++)
				{
//				sInfo += "\n好友[" + (i + 1) + "]:" + items[i].nickName + " " + items[i].score + " " + items[i].playTime;
					var _score: int = items[i].score;
					_model.topScoreArr[i] = _score;
				}
			}
		}
	}
}