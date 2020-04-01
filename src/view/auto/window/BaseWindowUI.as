/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class BaseWindowUI extends View {
		protected static var uiXML:XML =
			<View width="200">
			  <Panel x="0" y="0" left="0" right="0" top="21" bottom="0" vScrollBarSkin="png.comp.vscroll" hScrollBarSkin="png.comp.hscroll"/>
			  <Image skin="png.comp.img_splite" x="0" y="0" left="0" top="0" bottom="0"/>
			  <Image skin="png.comp.img_splite_h" x="0" right="0" left="0" bottom="0"/>
			  <Image skin="png.comp.img_splite" right="0" top="0" bottom="0"/>
			  <Image skin="png.comp.img_splite_h" right="0" left="0" top="0"/>
			  <Tab labels="页签" skin="png.comp.tab" x="0" y="0" labelColors="0xFFFFFF,0xFFFFFF,0xFFFFFF" space="0"/>
			</View>;
		public function BaseWindowUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}