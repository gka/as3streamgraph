package net.vis4.streamgraph.layout 
{
	/**
	 * LayerLayout
	 * Abstract Class for new stacked graph layout algorithms
	 *
	 * Note: you do not need to worry about scaling to screen dimensions.
	 * The display applet will do that automatically for you.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class LayerLayout 
	{
		
		public function getName():String { return "" }
		
		public function layout(layers:Vector.<Layer>):void { };
		
		/**
		 * We define our stacked graphs by layers atop a baseline.
		 * This method does the work of assigning the positions of each layer in an
		 * ordered array of layers based on an initial baseline.
		 */
		protected function stackOnBaseline(layers:Vector.<Layer>, baseline:Vector.<Number>):void {
			// Put layers on top of the baseline.
			for (var i:int = 0; i < layers.length; i++) {
				layers[i].yBottom = baseline.concat();
				for (var j:int = 0; j < baseline.length; j++) {
					if (layers[i].visible) baseline[j] -= layers[i].size[j];
				}
				layers[i].yTop = baseline.concat();
			}
		}
		
	}

}