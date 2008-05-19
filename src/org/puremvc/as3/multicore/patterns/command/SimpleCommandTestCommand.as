/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.multicore.patterns.command
{
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.command.*;

	/**
	 * A SimpleCommand subclass used by SimpleCommandTest.
	 *
  	 * @see org.puremvc.as3.multicore.patterns.command.SimpleCommandTest SimpleCommandTest
  	 * @see org.puremvc.as3.multicore.patterns.command.SimpleCommandTestVO SimpleCommandTestVO
	 */
	public class SimpleCommandTestCommand extends SimpleCommand
	{

		/**
		 * Constructor.
		 */
		public function SimpleCommandTestCommand()
		{
			super();
		}
		
		/**
		 * Fabricate a result by multiplying the input by 2
		 * 
		 * @param event the <code>INotification</code> carrying the <code>SimpleCommandTestVO</code>
		 */
		override public function execute( note:INotification ) :void
		{
			
			var vo:SimpleCommandTestVO = note.getBody() as SimpleCommandTestVO;
			
			// Fabricate a result
			vo.result = 2 * vo.input;

		}
		
	}
}