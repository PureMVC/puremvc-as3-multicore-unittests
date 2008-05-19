/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.multicore.core
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
   	/**
  	 * A Mediator class used by ViewTest.
  	 * 
  	 * @see org.puremvc.as3.multicore.core.view.ViewTest ViewTest
  	 */
	public class ViewTestMediator4 extends Mediator implements IMediator 
	{
		/**
		 * The Mediator name
		 */
		public static const NAME:String = 'ViewTestMediator4';
				
		/**
		 * Constructor
		 */
		public function ViewTestMediator4( view:Object ) {
			super( NAME, view );
		}

		public function get viewTest():ViewTest
		{
			return viewComponent as ViewTest;
		}
				
		override public function onRegister():void
		{
			viewTest.onRegisterCalled = true;
		}
				
		override public function onRemove():void
		{
			viewTest.onRemoveCalled = true;
		}
				
				
	}
}