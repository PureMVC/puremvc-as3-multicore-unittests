/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.multicore.core
{
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.command.*;

	/**
	 * A SimpleCommand subclass used by ControllerTest.
	 *
  	 * @see org.puremvc.as3.multicore.core.controller.ControllerTest ControllerTest
  	 * @see org.puremvc.as3.multicore.core.controller.ControllerTestVO ControllerTestVO
	 */
	public class ControllerTestCommand extends SimpleCommand
	{

		/**
		 * Constructor.
		 */
		public function ControllerTestCommand()
		{
			super();
		}
		
		/**
		 * Fabricate a result by multiplying the input by 2
		 * 
		 * @param note the note carrying the ControllerTestVO
		 */
		override public function execute( note:INotification ) :void
		{
			
			var vo:ControllerTestVO = note.getBody() as ControllerTestVO;
			
			// Fabricate a result
			vo.result = 2 * vo.input;

		}
		
	}
}