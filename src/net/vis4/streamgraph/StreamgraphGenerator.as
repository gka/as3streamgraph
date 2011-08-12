package net.vis4.streamgraph 
{
	import flash.display.Graphics;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.vis4.geom.CatmullRomSpline;
	import net.vis4.streamgraph.Layer;
	import net.vis4.text.fonts.embedded.QuicksandBook;
	import net.vis4.text.Label;
	import net.vis4.utils.DelayedTask;
	
	/**
	 * ...
	 * @author Gregor Aisch
	 */
	public class StreamgraphGenerator 
	{
		protected var _container:Sprite;
		protected var _viewport:Rectangle;
		
		public var isGraphCurved:Boolean = true; // catmull-rom interpolation
		public var seed:int = 23; 						// random seed
		
		public var DPI:Number = 300;
		public var widthInches:Number = 3.5;
		public var heightInches:Number = 0.7;
		public var numLayers:int = 7;
		public var layerSize:int = 50;
		
		public var data:DataSource;
		public var layout:LayerLayout;
		public var ordering:LayerSort;
		public var coloring:ColorPicker;
		
		public var layers:Vector.<Layer>;
		
		public function StreamgraphGenerator(container:Sprite, viewport:Rectangle) 
		{
			_viewport = viewport;
			_container = container;
			
			setup();
		}
		
		public function setup():void 
		{
			// GENERATE DATA
			data = new LateOnsetDataSource();
			//data = new BelievableDataSource(seed);

			// ORDER DATA
			ordering = new LateOnsetSort();
			//ordering = new VolatilitySort();
			//ordering = new InverseVolatilitySort();
			//ordering = new BasicLateOnsetSort();
			//ordering = new NoLayerSort();

			// LAYOUT DATA
			layout = new MinimizedWiggleLayout();
			//layout = new MinimizedWiggleLayout();
			//layout = new ThemeRiverLayout();
			//layout = new StackLayout();

			// COLOR DATA
			coloring = new LastFMColorPicker("assets/layers-nyt.jpg", run);
			//coloring = new LastFMColorPicker(this, "layers.jpg");
			//coloring = new RandomColorPicker(this);
		}
		
		public function run():void
		{
			// calculate time to generate graph
			var time:Number = new Date().time;
			
			// generate graph
			layers = data.make(numLayers, layerSize);
			
			layers = ordering.sort(layers);
			layout.layout(layers);
			coloring.colorize(layers);
			
			// fit graph to viewport
			scaleLayers(layers, 1, _viewport.height - 1);
			
			// give report
			var layoutTime:Number = new Date().time - time;
			var _numLayers:int = layers.length;
			var _layerSize:int = layers[0].size.length;
			trace("Data has " + _numLayers + " layers, each with " + _layerSize + " datapoints.");
			trace("Layout Method: " + layout.getName());
			trace("Ordering Method: " + ordering.getName());
			trace("Coloring Method: " + coloring.getName());
			trace("Elapsed Time: " + layoutTime + "ms");
			
			draw();
		}
		
		protected function scaleLayers(layers:Vector.<Layer>, screenTop:int, screenBottom:int):void 
		{
			// Figure out max and min values of layers.
			var min:Number = Number.MAX_VALUE,
				max:Number = Number.MIN_VALUE;

			for (var i:int = 0; i < layers[0].size.length; i++) {
				for (var j:int = 0; j < layers.length; j++) {
					min = Math.min(min, layers[j].yTop[i]);
					max = Math.max(max, layers[j].yBottom[i]);
				}
			}
			
			var scale:Number = (screenBottom - screenTop) / (max - min);
			for (i = 0; i < layers[0].size.length; i++) {
				for (j = 0; j < layers.length; j++) {
					layers[j].yTop[i] = screenTop + scale * (layers[j].yTop[i] - min);
					layers[j].yBottom[i] = screenTop + scale * (layers[j].yBottom[i] - min);
				}
			}
		}

		
		// adding a pixel to the top compensate for antialiasing letting
		// background through. This is overlapped by following layers, so no
		// distortion is made to data.
		// detail: a pixel is not added to the top-most layer
		// detail: a shape is only drawn between it's non 0 values
		public function draw():void
		{
			var n:int = layers.length,
				m:int = layers[0].size.length,
				start:int,
				end:int,
				lastIndex:int = m - 1,
				lastLayer:int = n - 1,
				px1:int,
				g:Graphics = _container.graphics;
			
			// calculate time to draw graph
			var time:Number = new Date().time;
			
			// generate graph
			for (var i:int = 0; i < n; i++) {
				start = Math.max(0, layers[i].onset -1);
				end = Math.min(m - 1, layers[i].end);
				px1 = i == lastLayer ? 0 : 1;
				
				// set fill color of layer
				g.beginFill(layers[i].rgb);
				
				// draw shape
				
				// draw top edge, left to right
				graphVertex(g, start, layers[i].yTop, false, i == lastLayer, true);
				for (var j:int = start; j <= end; j++) {
					graphVertex(g, j, layers[i].yTop, isGraphCurved, i == lastLayer);
				}
				if (isGraphCurved) drawCurve();
				// graphVertex(g, end, layers[i].yTop, i == lastLayer);
				
				// draw bottom edge, right to left
				graphVertex(g, end, layers[i].yBottom, false, false);
				for (j = end; j >= start; j--) {
					graphVertex(g, j, layers[i].yBottom, isGraphCurved, false);
				}
				if (isGraphCurved) drawCurve();
				// graphVertex(g, end, layers[i].yBottom, isGraphCurved, false);
				graphVertex(g, start, layers[i].yTop, false, false);
				
				g.endFill();
			}
			
			// give report
			trace("Draw Time: " + (new Date().time - time) + "ms");
		}
		
		protected function graphVertex(g:Graphics, point:int, source:Vector.<Number>, curve:Boolean, px1:Boolean, first:Boolean = false):void
		{
			var x:Number = _viewport.left + point / (layerSize-1) * _viewport.width,
				y:Number = _viewport.top + source[point] - (px1 ? 1 : 0);
			if (first) {
				g.moveTo(x, y);
			} else if (curve) {
				catmullSplinePoints.push(new Point(x, y));
			} else {
				g.lineTo(x, y);
			}
			
		}
		
				
		protected var catmullSplinePoints:Array = [];
		
		protected function drawCurve():void
		{
			CatmullRomSpline.draw(_container.graphics, catmullSplinePoints, false, false);
			catmullSplinePoints = [];
			
		}
		
		
	}

}