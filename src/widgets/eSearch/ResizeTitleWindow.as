////////////////////////////////////////////////////////////////////////////////
//
// Version 2.2 - Feb 4, 2011
//
// Delevoped by Robert Scheitlin
//
////////////////////////////////////////////////////////////////////////////////

package widgets.eSearch
{
	import flash.events.MouseEvent;

	import mx.controls.Image;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;

	import spark.components.TitleWindow;
	import spark.primitives.BitmapImage;

	public class ResizeTitleWindow extends TitleWindow
	{
		[SkinPart(required="false")]
		public var iconDisplay:BitmapImage;

		[SkinPart(required="false")]
		public var resizeHandle:Image;

		private var _titleIcon:Class;

		public function set titleIcon(value:Class):void {

			_titleIcon = value;

			if (iconDisplay != null)
				iconDisplay.source = _titleIcon;

		}

		[Embed(source="widgets/eSearch/assets/images/resizeCursorTLBR.gif")]
		private static var CURSOR_CLASS:Class;

		private static var CURSOR_X_OFFSET:Number = -10;

		private static var CURSOR_Y_OFFSET:Number = -10;

		[Bindable]
		public var widgetWidth:Number;

		[Bindable]
		public var widgetHeight:Number;

		public function ResizeTitleWindow()
		{
			super();

			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}

		private function creationCompleteHandler(event:Event):void
		{
			widgetWidth = width;
			widgetHeight = height;
		}

		override protected function partAdded(partName:String, instance:Object):void {

			super.partAdded(partName, instance);

			if (_titleIcon !== null && instance == iconDisplay){
				iconDisplay.source = _titleIcon;
			}
			if (resizeHandle !== null && instance == resizeHandle){
				resizeHandle.addEventListener(MouseEvent.MOUSE_OVER, rollOverHandler, false, 0, true);
				resizeHandle.addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler, false, 0, true);
				resizeHandle.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			}
		}

		private var m_dragStartMouseX:Number;

		private var m_dragStartMouseY:Number;

		private var m_startHeight:Number;

		private var m_startWidth:Number;

		private function enterFrameHandler(event:Event):void
		{
			const dragAmountX:Number = parent.mouseX - m_dragStartMouseX;
			const dragAmountY:Number = parent.mouseY - m_dragStartMouseY;

			if (parent.mouseX < parent.width && parent.mouseY < parent.height)
			{
				widgetWidth = width = Math.max(m_startWidth + dragAmountX, minWidth);
				widgetHeight = height = Math.max(m_startHeight + dragAmountY, minHeight);
			}
		}

		/**
		 * Mouse down on any resize handle.
		 */
		private function mouseDownHandler(event:MouseEvent):void
		{
			setCursor();

			m_dragStartMouseX = parent.mouseX;
			m_dragStartMouseY = parent.mouseY;

			m_startWidth = this.width;
			m_startHeight = this.height;

			systemManager.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			systemManager.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
			systemManager.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler, false, 0, true);
		}

		private function mouseLeaveHandler(event:Event):void
		{
			mouseUpHandler();
			systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
		}

		private function mouseUpHandler(event:MouseEvent = null):void
		{
			systemManager.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			systemManager.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);

			CursorManager.removeCursor(CursorManager.currentCursorID);
		}

		private function rollOutHandler(event:MouseEvent):void
		{
			if (!event.buttonDown)
			{
				CursorManager.removeCursor(CursorManager.currentCursorID);
			}
		}

		private function rollOverHandler(event:MouseEvent):void
		{
			if (!event.buttonDown)
			{
				setCursor();
			}
		}

		private function setCursor():void
		{
			CursorManager.removeCursor(CursorManager.currentCursorID);
			CursorManager.setCursor(CURSOR_CLASS, 2, CURSOR_X_OFFSET, CURSOR_Y_OFFSET);
		}
	}
}
