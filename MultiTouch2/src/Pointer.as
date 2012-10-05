package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Pointer extends Sprite 
	{
		private var _textField:TextField = new TextField();
		private var _circle:Shape = new Shape();
		
		public function Pointer() 
		{
            init();
        }
        private function init():void
        {
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }

        private function onInit(event:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onInit);
            // entry point
			
			_circle.graphics.beginFill(0x0000FF);
			_circle.graphics.drawCircle(0, 0, 25);
			_circle.graphics.endFill();
			addChild(_circle);
			
			mouseEnabled = false;
			
			_textField.defaultTextFormat = new TextFormat("_sans", 36, 0xFFFFFF);
			_textField.text = "00";
			_textField.autoSize = "center";
			_textField.x = -_textField.width * 0.5;
			_textField.y = -_textField.height * 0.5;
			_textField.selectable = false;
			_textField.mouseEnabled = false;
			addChild(_textField);
		}
		
		public function set id(value:int):void {
			_textField.text = String(value);
		}
		
		public function drawLine():void {
			graphics.clear();
			graphics.lineStyle(0, 0xFF0000);
			graphics.moveTo(-this.x, 0);
			graphics.lineTo(stage.stageWidth - this.x, 0);
			graphics.moveTo(0, -this.y);
			graphics.lineTo(0, stage.stageHeight - this.y);
		}
	}

}