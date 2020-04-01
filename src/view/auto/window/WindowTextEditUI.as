/**Created by the Morn,do not modify.*/
package view.auto.window {
	import morn.core.components.*;
	public class WindowTextEditUI extends View {
		public var txt_code:TextArea = null;
		protected static var uiXML:XML =
			<View width="840" height="583">
			  <TextArea skin="png.comp.textarea" x="133" y="120" var="txt_code" top="1" bottom="1" left="1" right="1" color="0xffffff" isHtml="false" leading="1" vScrollBarSkin="png.comp.vscroll"/>
			</View>;
		public function WindowTextEditUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}