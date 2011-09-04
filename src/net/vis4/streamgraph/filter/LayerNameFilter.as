package net.vis4.streamgraph.filter 
{
	import net.vis4.streamgraph.Layer;
	
	/**
	 * 
	 * @author Gregor Aisch
	 */
	public class LayerNameFilter extends LayerFilter 
	{
		protected var _allowedNames:Array;
		
		public function LayerNameFilter(allowedNames:Array) 
		{
			_allowedNames = allowedNames;
		}
		
		override protected function isVisible(layer:Layer):Boolean 
		{
			return _allowedNames.indexOf(layer.name) >= 0;
		}
		
	}

}