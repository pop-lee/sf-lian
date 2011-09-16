package cn.sftec.www.view
{
	import cn.sftec.www.object.Block;
	import cn.sftec.www.object.MapData;
	import cn.sftech.www.view.SFSprite;
	import cn.sftec.www.view.ConnectLines;
	
	import flash.events.MouseEvent;
	
	public class GamePane extends SFSprite
	{
		private var m_checkerMap:Vector.<Vector.<Block>>;
		
		//当前块
		private var currentBlock : Block;
		
		protected var olcBlock:Block;
		//上一个选中的块
		protected var prevBlock:Block;
		
		protected var m_connectPath:Array;
		//连击次数
		protected var m_continuousNum:uint;
		
//		protected var m_connectLines:ConnectLines;
		
		private var mapData : MapData;
		
		private var focusIn : FocusIn;
		
		protected var m_connectLines:ConnectLines;
		
		public function GamePane()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			focusIn = new FocusIn()
			focusIn.visible = false;
			addChild(focusIn);
			m_connectLines = new ConnectLines();
			m_connectLines.setChessmanSize(Block.CHESSMAN_LENGTH, Block.CHESSMAN_LENGTH);
			m_connectLines.x = -Block.CHESSMAN_LENGTH;
			m_connectLines.y = -Block.CHESSMAN_LENGTH;
			addChild(m_connectLines);
			mapData = new MapData();
			mapData.createMap(6);
//			m_checkerMap = mapData.mapArr;
//			for each(var block : Block in mapData.mapBlockArr) {
//				block.x = (block.mapX-1)*Block.CHESSMAN_LENGTH;
//				block.y = (block.mapY-1)*Block.CHESSMAN_LENGTH;
//				addChild(block);
//				block.addEventListener(MouseEvent.CLICK,onChessman_handler);
//			}
			refresh();
		}
		
		public function refresh() : void
		{
			mapData.shuffle();
			m_checkerMap = mapData.mapArr;
			for each(var block : Block in mapData.mapBlockArr) {
				block.x = (block.mapX-1)*Block.CHESSMAN_LENGTH;
				block.y = (block.mapY-1)*Block.CHESSMAN_LENGTH;
				addChild(block);
				block.addEventListener(MouseEvent.CLICK,onChessman_handler);
			}
		}
		
		private function onChessman_handler(e:MouseEvent):void {
			currentBlock = e.currentTarget as Block;
			if (prevBlock != currentBlock) {
				//显示选中状态
				currentBlock.isCheckIn = true;
				//把上一个棋子设置为未选中
				if (prevBlock != null) {
					prevBlock.isCheckIn = false;
					focusIn.setFocus(null);
				}
				//判断是否点击了有效的第二颗棋子
				if (olcBlock == null) {
					olcBlock = currentBlock;
					//trace(m_currChessman.category);
				}else {
					//trace("=========已经双击！===========");
					if (olcBlock.type == currentBlock.type) {
						m_connectPath = getRoute(olcBlock.mapX, olcBlock.mapY, currentBlock.mapX, currentBlock.mapY);
						if (m_connectPath.length > 0) {
							validDoubleClick();
							//if (!m_chessmanList.some(isConnectChessman)) {
							//	sendNotification(ReputMapCommand.NAME);
							//}
						}else {
							olcBlock = currentBlock;
							m_continuousNum = 0;
						}
					}else {
						olcBlock = currentBlock;
						m_continuousNum = 0;
					}
				}
				//
				prevBlock = currentBlock;
				focusIn.setFocus(prevBlock);
			}else {
				currentBlock.isCheckIn = !currentBlock.isCheckIn;
				//是否记录之前点击的棋子
				if (currentBlock.isCheckIn) {
					olcBlock = currentBlock;
				}else {
					olcBlock = null;
				}
			}
		}
		
		private function validDoubleClick():void {
			//清除地图上消失的棋子
			this.removeChild(olcBlock);
			this.removeChild(currentBlock);
			mapData.removeBlock(olcBlock);
			mapData.removeBlock(currentBlock);
//			m_leaveChessmans -= 2;
			//画线
			m_connectLines.addConnectLines(m_connectPath);
			olcBlock = null;
			currentBlock = null;
			//判断剩下的是否还能继续游戏，如果不能则强制刷新
			//if (!m_chessmanList.some(isConnectChessman)) {
			//TODO 这里做在完善一下
			//sendNotification(UsePropertyCommand.NAME, {propName:modelLocator.PROP_REPUT});
			//}
		}
		
		/**
		 * 连连看规则
		 * 1 出一对相同的牌
		 * 1 这对牌能用三条或三条以下的水平或竖直线段连接
		 * 3 线段不能和别的牌相交
		 * 从(x1,y1)到(x2,y2)按连连看的游戏规则找一条合法的最短的路线
		 */
		private function getRoute(x1:uint, y1:uint, x2:uint, y2:uint):Array {
			var x:int, y:int, d:int = 1000, temp:int;
			//用来记录得到的路线的四个折点
			var point_array:Array = new Array();
			//先把m1,m2所在的点的地图值置0,否则下面的检测会把它们当障碍物
			m_checkerMap[y1][x1] = null;
			m_checkerMap[y2][x2] = null;
			//向左搜索
			for (x = x1 - 1; x >= 0; x--) {
				//trace("左1");
				//如果第一条线段可以连接
				if (checkConnect(x1, y1, x, y1)) {
					//trace("左");
					//如果剩下的两条也可以连接
					if (checkConnect(x, y1, x, y2) && checkConnect(x, y2, x2, y2)) {
						//计算路程
						d = Math.abs(x - x1) + Math.abs(y2 - y1) + Math.abs(x2 - x);
						point_array = [x1, y1, x, y1, x, y2, x2, y2];//记录折点
						//不用在这个方向继续搜了
						break;
					}
				} else {
					break;
				}
				//trace("向左", x1, y1, x2, y2, x);
			}
			
			//向右搜索
			for (x = x1 + 1; x < mapData.TOTAL_COL; x++) {
				//trace("右1");
				if (checkConnect(x1, y1, x, y1)) {
					//trace("右");
					if (checkConnect(x, y1, x, y2) && checkConnect(x, y2, x2, y2)) {
						temp = Math.abs(x - x1) + Math.abs(y2 - y1) + Math.abs(x2 - x);
						//比较路程
						if (temp < d) {
							d = temp;
							point_array = [x1, y1, x, y1, x, y2, x2, y2];
						}
						break;
					}
				}else {
					break;
				}
			}
			
			//向上搜索
			for (y = y1 - 1; y >= 0; y--) {
				//trace("上1");
				if (checkConnect(x1, y1, x1, y)) {
					//trace("上");
					if (checkConnect(x1, y, x2, y) && checkConnect(x2, y, x2, y2)) {
						temp = Math.abs(y - y1) + Math.abs(x2 - x1) + Math.abs(y2 - y);
						if (temp < d) {
							d = temp;
							point_array = [x1, y1, x1, y, x2, y, x2, y2];
						}
						break;
					}
				} else {
					break;
				}
			}
			
			//向下搜索
			for (y = y1 + 1; y < mapData.TOTAL_ROW; y++) {
				if (checkConnect(x1, y1, x1, y)) {
					//trace("下");
					if (checkConnect(x1, y, x2, y) && checkConnect(x2, y, x2, y2)) {
						temp = Math.abs(y - y1) + Math.abs(x2 - x1) + Math.abs(y2 - y);
						if (temp < d) {
							d = temp;
							point_array = [x1, y1, x1, y, x2, y, x2, y2];
						}
						break;
					}
				} else {
					break;
				}
			}
			//把置0的地图值恢复
			m_checkerMap[y1][x1] = olcBlock;
			m_checkerMap[y2][x2] = currentBlock;
			//返回得到的折点,如果上面找不到可连接的则会返回一个空数组
			return point_array;
		}
		
		/**
		 * 检测两个在同一水平线或同一竖直线上的两个点(x1,y1),(x2,y2)之间是否可以连接
		 * @param	x1
		 * @param	y1
		 * @param	x2
		 * @param	y2
		 * @return	true/false
		 */
		private function checkConnect(x1:uint, y1:uint, x2:uint, y2:uint):Boolean {
			var temp:int;
			//如果在同一竖直线
			if (x1 == x2) {
				if (y1 > y2) {
					temp = y1;
					y1 = y2;
					y2 = temp;
				}
				//从上向下逐个检测
				for (var y:int = y1; y <= y2; y++) {
					//trace("上--下", y, "--", m_checkerMap[y][x1]);
					//如果有障碍
					if (m_checkerMap[y][x1] != null) {
						return false;
					}
				}
				//否则在同一水平线
			} else {
				if (x1 > x2) {
					temp = x1;
					x1 = x2;
					x2 = temp;
				}
				//从左向右逐个检测
				for (var x:int = x1; x <= x2; x++) {
					//如果有障碍
					if (m_checkerMap[y1][x] != null) {
						return false;
					}
				}
			}
			return true;
		}
	}
}