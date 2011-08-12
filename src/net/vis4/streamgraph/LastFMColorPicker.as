package net.vis4.streamgraph 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import net.vis4.streamgraph.Layer;
	/**
	 * ...
	 * @author gka
	 */
	public class LastFMColorPicker extends EventDispatcher implements ColorPicker 
	{
		
		public var source:Bitmap;
		
		protected var _callback:Function; // will be called after image has loaded.
		
		public function LastFMColorPicker(src:String, callback:Function) 
		{
			_callback = callback;
			
			var ldr:Loader = new Loader();
			
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onSourceLoaded);
			
			ldr.load(new URLRequest(src));

		}
		
		protected function onSourceLoaded(e:Event):void 
		{
			source = Bitmap(LoaderInfo(e.target).content);
			_callback();
		}
		
		public function getName():String 
		{
			return "Listening History Color Scheme";
		}
		
		
		public function colorize(layers:Vector.<Layer>):void 
		{
			// find the largest layer to use as a normalizer
			var maxSum:Number = 0;
			for (var i:int = 0; i < layers.length; i++) {
				maxSum = Math.max(maxSum, layers[i].sum);
			}
			
			// find the color for each layer
			for (i = 0; i < layers.length; i++) {
				var normalizedOnset:Number = layers[i].onset / layers[i].size.length,
					normalizedSum:Number = layers[i].sum / maxSum,
					shapedSum:Number = 1.0 - Math.sqrt(normalizedSum);
				
				layers[i].rgb = get_(normalizedOnset, shapedSum);
			}
		}
		
		protected function get_(g1:Number, g2:Number):uint
		{
			// get pixel coordinate based on provided parameters
			var x:int = Math.floor(g1 * source.bitmapData.width),
				y:int = Math.floor(g2 * source.bitmapData.height);
			
			// ensure that the pixel is within bounds.
			x = Math.min(source.bitmapData.width-1, Math.max(0, x));
			y = Math.min(source.bitmapData.height - 1, Math.max(0, y));
			
			// return the color at the requested pixel
			return source.bitmapData.getPixel(x,y);
		}
		
	}

}