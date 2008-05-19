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
	public class ViewTestMediator3 extends Mediator implements IMediator 
	{
		/**
		 * The Mediator name
		 */
		public static const NAME:String = 'ViewTestMediator3';
				
		/**
		 * Constructor
		 */
		public function ViewTestMediator3( view:Object ) {
			super( NAME, view );
		}

		override public function listNotificationInterests():Array
		{
			// be sure that the mediator has some Observers created
			// in order to test removeMediator
			return [ ViewTest.NOTE3 ];
		}

		override public function handleNotification(notification:INotification):void
		{
			viewTest.lastNotification = notification.getName();
		}
				
		public function get viewTest():ViewTest
		{
			return viewComponent as ViewTest;
		}
				
	}
}