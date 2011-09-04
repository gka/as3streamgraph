package net.vis4.streamgraph.layout 
{
	import net.vis4.streamgraph.Layer;
	/**
	 * ...
	 * @author Gregor Aisch
	 */
	public class MixedLayout extends LayerLayout 
	{
		protected var _layoutA:LayerLayout;
		protected var _layoutB:LayerLayout;
		protected var _t:Number;
		
		public function MixedLayout(layoutA:LayerLayout, layoutB:LayerLayout, t:Number = 0) 
		{
			_t = t;
			_layoutB = layoutB;
			_layoutA = layoutA;
			
		}
		
		override public function layout(layers:Vector.<Layer>):void 
		{
			_layoutA.layout(layers);
			var baselineA:Vector.<Number> = layers[0].yBottom.concat();
			_layoutB.layout(layers);
			var baselineB:Vector.<Number> = layers[0].yBottom.concat();
			for (var i:uint = 0; i < baselineA.length; i++) {
				baselineA[i] = baselineA[i] * (1 - _t) + baselineB[i] * _t;
			}
			stackOnBaseline(layers, baselineA);
		}
		
	}

}