/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.multicore.patterns.command
{
	import org.puremvc.as3.multicore.patterns.command.*;
	import org.puremvc.as3.multicore.interfaces.*;

	/**
	 * A MacroCommand subclass used by MacroCommandTest.
	 *
  	 * @see org.puremvc.as3.multicore.patterns.command.MacroCommandTest MacroCommandTest
  	 * @see org.puremvc.as3.multicore.patterns.command.MacroCommandTestSub1Command MacroCommandTestSub1Command
  	 * @see org.puremvc.as3.multicore.patterns.command.MacroCommandTestSub2Command MacroCommandTestSub2Command
  	 * @see org.puremvc.as3.multicore.patterns.command.MacroCommandTestVO MacroCommandTestVO
	 */
	public class MacroCommandTestCommand extends MacroCommand
	{
		/**
		 * Constructor.
		 */
		public function MacroCommandTestCommand()
		{
			super();
		}
		
		/**
		 * Initialize the MacroCommandTestCommand by adding
		 * its 2 SubCommands.
		 */
		override protected function initializeMacroCommand() :void
		{
			addSubCommand( org.puremvc.as3.multicore.patterns.command.MacroCommandTestSub1Command );
			addSubCommand( org.puremvc.as3.multicore.patterns.command.MacroCommandTestSub2Command );
		}
		
	}
}