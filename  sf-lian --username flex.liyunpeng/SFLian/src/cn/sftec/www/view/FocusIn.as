package cn.sftec.www.view
{
	import cn.sftec.www.object.Block;
	
	import flash.display.MovieClip;
	
	[Embed(source="access/mainPage.swf",symbol="focusIn")]
	public class FocusIn extends MovieClip
	{
		public function FocusIn()
		{
			super();
		}
		
		public function setFocus(block : Block) : void
		{
			if(block) {
				this.x = block.x;
				this.y = block.y
				this.visible = true;
			} else {
				this.visible = false;
			}
		}
	}
}