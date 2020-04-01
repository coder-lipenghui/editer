/**Created by the Morn,do not modify.*/
package view.auto.common {
	import morn.core.components.*;
	public class CommListGameObjectUI extends View {
		public var list_name:List = null;
		protected static var uiXML:XML =
			<View width="100" height="400">
			  <Image skin="png.comp.bg" x="59" y="68" left="0" right="0" top="0" bottom="0" alpha="0.5" sizeGrid="2,2,2,2,1"/>
			  <List left="0" right="0" top="0" bottom="0" spaceX="1" var="list_name">
			    <Box name="render">
			      <Label text="label" x="0" y="0" width="99" height="18" color="0xFFFFFF"/>
			    </Box>
			  </List>
			</View>;
		public function CommListGameObjectUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}