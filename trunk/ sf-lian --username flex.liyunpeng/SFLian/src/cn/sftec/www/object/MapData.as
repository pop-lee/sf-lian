package cn.sftec.www.object
{
	import cn.sftech.www.util.MathUtil;

	public class MapData
	{
		public var blockCount : int = 0;
		
		private var totalRow : int = 10;
		private var totalCol : int = 10;
		
		private var blockTotalRow : int = 8;
		private var blockTotalCol : int = 8;
		
		public var mapArr : Vector.<Vector.<Block>> = new Vector.<Vector.<Block>>;
		
		public var mapBlockArr : Vector.<Block> = new Vector.<Block>(blockTotalRow*blockTotalCol);
		
		public function MapData()
		{
			init();
		}
		
		private function init() : void
		{
			for(var i : int = 0;i < totalRow;i++) {
				mapArr.push(new Vector.<Block>(totalCol));
			}
		}
		
		public function createMap(lv : int):void
		{
			var blockType : Vector.<Class> = Vector.<Class>([Block1,Block2,Block3,Block4]);
			if(lv>1)
				blockType.push(Block5);
			if(lv>2)
				blockType.push(Block6);
			if(lv>3)
				blockType.push(Block7);
			if(lv>4)
				blockType.push(Block8);
			if(lv>5)
				blockType.push(Block9);
			
			var blockCount : int = 0;
			for(var i : int = 1;i <= blockTotalRow;i++) {
				for(var j : int = 1;j <= blockTotalCol;j++) {
					var block : Block = new (blockType[int((blockCount-1)/2)%blockType.length] as Class);
					block.mapX = i;
					block.mapY = j;
					mapArr[i][j] = block;
					mapBlockArr[blockCount] = block;
					blockCount ++;
				}
			}
			shuffle();
		}
		
		
		/**
		 * 洗牌整个地图
		 */
		public function shuffle() : void
		{
			var tmpX : int;
			var tmpY : int;
			for(var i : int = 0;i < 2000; i++) {
				var blockAIndex : int = MathUtil.random(0,mapBlockArr.length-1);
				var blockBIndex : int = MathUtil.random(0,mapBlockArr.length-1);
				
				var blockA : Block = mapBlockArr[blockAIndex];
				var blockB : Block = mapBlockArr[blockBIndex];
				
				tmpX = blockB.mapX;
				tmpY = blockB.mapY;
				blockB.setData(blockA.mapX,blockA.mapY);
				blockA.setData(tmpX,tmpY);
				mapArr[blockA.mapX][blockA.mapY] = blockA;
				mapArr[blockB.mapX][blockB.mapY] = blockB;
			}
		}
	}
}