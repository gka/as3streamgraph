package net.vis4.streamgraph.filter 
{
	import net.vis4.streamgraph.Layer;
	
	/**
	 * Basic implementation of a filter
	 * 
	 * @author Gregor Aisch
	 */
	public class LayerFilter 
	{
		
		protected function isVisible(layer:Layer):Boolean
		{
			return true;
		}

		public function filter(layers:Vector.<Layer>):Vector.<Layer>
		{
			var out:Vector.<Layer> = new Vector.<Layer>();
			for each (var layer:Layer in layers) {
				if (isVisible(layer)) out.push(layer);
			}
			return out;
		}
		
	}

}