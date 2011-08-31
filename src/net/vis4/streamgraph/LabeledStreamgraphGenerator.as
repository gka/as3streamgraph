package net.vis4.streamgraph 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import net.vis4.text.fonts.Font;
	import net.vis4.text.fonts.system.Arial;
	import net.vis4.text.Label;
	
	/**
	 * This Streamgraph Generator adds Labels to the Layers
	 * 
	 * @author Gregor Aisch
	 */
	public class LabeledStreamgraphGenerator extends StreamgraphGenerator 
	{
		public var labelFont:Font;
		public var labelSprite:Sprite;
				
		public function LabeledStreamgraphGenerator(config:Object) 
		{
			if (config.hasOwnProperty('labelFont')) labelFont = config.labelFont;
			else labelFont = new Arial( { } );
			
			
			
			super(config);
			
			
		}
		
		override protected function postSetup():void 
		{
			labelSprite = new Sprite();
			_container.addChild(labelSprite);
		}
		
		override public function draw():void 
		{
			super.draw();
			
			if (_config.noLabels) return;
			
			var n:uint = layers.length,
				 m:uint = layers[0].size.length;
			// add labels
			// generate graph
			for (var i:int = 0; i < n; i++) {
				var layer:Layer = layers[i];
				// add label
				var l:Label = new Label(layer.name, labelFont)
					.attr({ mouseEnabled: false, selectable:false })
					.place(10, _viewport.top + layer.yTop[0] + 0.5 * (layer.yBottom[0] - layer.yTop[0]), 
					layerSprites[i]);
				var r:Number = l.width / l.height;
				
				var maxH:Number = 5, maxHx:Number, maxHy:Number;
				// find a good place for the label
				for (var j:int = 0; j < m; j++) {
					// center label
					var lx:Number = _viewport.left + (j/m) * _viewport.width, 
						ly:Number = _viewport.top + layer.yTop[j] + 0.5 * (layer.yBottom[j] - layer.yTop[j]), 
						lh:Number = 5, 
						lw:Number = lh * r;
					
					while (lx - lw * .6 > _viewport.left &&
						lx + lw * .6 < _viewport.right &&
						layerSprites[i].hitTestPoint(lx - lw * .5, ly - lh * .55, true) &&
						layerSprites[i].hitTestPoint(lx - lw * .5, ly + lh * .55, true) &&
						layerSprites[i].hitTestPoint(lx, ly - lh * .55, true) &&
						layerSprites[i].hitTestPoint(lx, ly + lh * .55, true) &&
						layerSprites[i].hitTestPoint(lx + lw * .5, ly - lh * .55, true) &&
						layerSprites[i].hitTestPoint(lx + lw * .5, ly + lh * .55, true)) {
						
						
							
						if (lh > maxH) {
							maxH = lh;
							maxHx = lx;
							maxHy = ly;
							
						}
						lh+= 2;
						lw = lh * r;
					}
				}
				
				lh = maxH;
				lx = maxHx;
				ly = maxHy;
				lw = lh * r;
				
				
				
				l.scaleX = l.scaleY = (lw)/l.textWidth;
				l.visible = l.scaleX > 0.5;
				l.x = lx - l.width * .5;
				l.y = ly - l.height * .5;
				
				
				
			}
		}
		
		
		
	}

}