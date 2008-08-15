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
  	 * @see org.puremvc.as3.core.view.ViewTest ViewTest
  	 */
	public class ViewTestMediator6 extends Mediator implements IMediator 
	{
		/**
		 * The Mediator base name
		 */
		public static const NAME:String = 'ViewTestMediator6';
				
		/**
		 * Constructor
		 */
		public function ViewTestMediator6( name:String, view:Object ) {
			super( name, view );
		}

		override public function listNotificationInterests():Array
		{
			return [ ViewTest.NOTE6 ];
		}

		override public function handleNotification( note:INotification ):void
		{
			facade.removeMediator(getMediatorName());
		}
		
		override public function onRemove():void
		{
			viewTest.counter++;
		}

		public function get viewTest():ViewTest
		{
			return viewComponent as ViewTest;
		}
	}
}