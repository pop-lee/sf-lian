package cn.sftech.www.view
{
	import flash.display.MovieClip;
	
	[Embed(source="access/mainPage.swf",symbol="StartGameTimer")]
	public class StartGameTimer extends MovieClip
	{
		public function StartGameTimer()
		{
			super();
			stop();
		}
	}
}