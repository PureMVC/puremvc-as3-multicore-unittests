/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.multicore.core
{
	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
 	
 	import org.puremvc.as3.multicore.interfaces.*;
 	import org.puremvc.as3.multicore.patterns.observer.*;
 	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
 	
  	/**
	 * Test the PureMVC View class.
	 */
	public class ViewTest extends TestCase {
  		
  		public var lastNotification:String;	
  		public var onRegisterCalled:Boolean = false;
  		public var onRemoveCalled:Boolean = false;
   		public var counter:Number = 0;
 		
 		public static const NOTE1:String = "Notification1";
		public static const NOTE2:String = "Notification2";
		public static const NOTE3:String = "Notification3";
 		public static const NOTE4:String = "Notification4";
		public static const NOTE5:String = "Notification5";
		public static const NOTE6:String = "Notification6";
	
  		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
  	    public function ViewTest( methodName:String ) {
   			super( methodName );
        }
  	
 		/**
		 * Create the TestSuite.
		 */
 		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ViewTest( "testGetInstance" ) );
   			ts.addTest( new ViewTest( "testRegisterAndNotifyObserver" ) );
   			ts.addTest( new ViewTest( "testRegisterAndRetrieveMediator" ) );
   			ts.addTest( new ViewTest( "testHasMediator" ) );
   			ts.addTest( new ViewTest( "testRegisterAndRemoveMediator" ) );
   			ts.addTest( new ViewTest( "testOnRegisterAndOnRemove" ) );
   			ts.addTest( new ViewTest( "testSuccessiveRegisterAndRemoveMediator" ) );
   			ts.addTest( new ViewTest( "testRemoveMediatorAndSubsequentNotify" ) );
   			ts.addTest( new ViewTest( "testRemoveOneOfTwoMediatorsAndSubsequentNotify" ) );
   			ts.addTest( new ViewTest( "testMediatorReregistration" ) );
   			ts.addTest( new ViewTest( "testModifyObserverListDuringNotification" ) );
   			
   			
   			return ts;
   		}
  		
  		/**
  		 * Tests the View Multiton Factory Method 
  		 */
  		public function testGetInstance():void {
  			
   			// Test Factory Method
   			var view:IView = View.getInstance('ViewTestKey1');
   			
   			// test assertions
   			assertTrue( "Expecting instance not null", view != null );
   			assertTrue( "Expecting instance implements IView", view is IView );
   			
   		}

  		/**
  		 * Tests registration and notification of Observers.
  		 * 
  		 * <P>
  		 * An Observer is created to callback the viewTestMethod of
  		 * this ViewTest instance. This Observer is registered with
  		 * the View to be notified of 'ViewTestEvent' events. Such
  		 * an event is created, and a value set on its payload. Then
  		 * the View is told to notify interested observers of this
  		 * Event. 
  		 * 
  		 * <P>
  		 * The View calls the Observer's notifyObserver method
  		 * which calls the viewTestMethod on this instance
  		 * of the ViewTest class. The viewTestMethod method will set 
  		 * an instance variable to the value passed in on the Event
  		 * payload. We evaluate the instance variable to be sure
  		 * it is the same as that passed out as the payload of the 
  		 * original 'ViewTestEvent'.
  		 * 
 		 */
  		public function testRegisterAndNotifyObserver():void {
  			
  			// Get the Multiton View instance
  			var view:IView = View.getInstance('ViewTestKey2');
  			
   			// Create observer, passing in notification method and context
   			var observer:Observer = new Observer( viewTestMethod, this );
   			
   			// Register Observer's interest in a particulat Notification with the View 
   			view.registerObserver(ViewTestNote.NAME, observer);
  			
   			// Create a ViewTestNote, setting 
   			// a body value, and tell the View to notify 
   			// Observers. Since the Observer is this class 
   			// and the notification method is viewTestMethod,
   			// successful notification will result in our local 
   			// viewTestVar being set to the value we pass in 
   			// on the note body.
   			var note:INotification = ViewTestNote.create(10);
			view.notifyObservers(note);

			// test assertions  			
   			assertTrue( "Expecting viewTestVar = 10", viewTestVar == 10 );
   		}
   		
  		/**
  		 * A test variable that proves the viewTestMethod was
  		 * invoked by the View.
  		 */
  		private var viewTestVar:Number;

  		/**
  		 * A utility method to test the notification of Observers by the view
  		 */
  		private function viewTestMethod( note:INotification ) : void
  		{
  			// set the local viewTestVar to the number on the event payload
  			viewTestVar = note.getBody() as Number;
  		}

		/**
		 * Tests registering and retrieving a mediator with
		 * the View.
		 */
		public function testRegisterAndRetrieveMediator():void {
			
  			// Get the Multiton View instance
  			var view:IView = View.getInstance('ViewTestKey3');

			// Create and register the test mediator
			var viewTestMediator:ViewTestMediator = new ViewTestMediator( this );
			view.registerMediator( viewTestMediator );
			
			// Retrieve the component
			var mediator:IMediator = view.retrieveMediator( ViewTestMediator.NAME ) as IMediator;
			
			// test assertions  			
   			assertTrue( "Expecting comp is ViewTestMediator", mediator is ViewTestMediator );
   			
		}
 		
  		/**
  		 * Tests the hasMediator Method
  		 */
  		public function testHasMediator():void {
  			
   			// register a Mediator
   			var view:IView = View.getInstance('ViewTestKey4');
			
			// Create and register the test mediator
			var mediator:Mediator = new Mediator( 'hasMediatorTest', this );
			view.registerMediator( mediator );
			
   			// assert that the view.hasMediator method returns true
   			// for that mediator name
   			assertTrue( "Expecting view.hasMediator('hasMediatorTest') == true", 
   						view.hasMediator('hasMediatorTest') == true);

			view.removeMediator( 'hasMediatorTest' );
			
   			// assert that the view.hasMediator method returns false
   			// for that mediator name
   			assertTrue( "Expecting view.hasMediator('hasMediatorTest') == false", 
   						view.hasMediator('hasMediatorTest') == false);

   		}

		/**
		 * Tests registering and removing a mediator 
		 */
		public function testRegisterAndRemoveMediator():void {
			
  			// Get the Multiton View instance
  			var view:IView = View.getInstance('ViewTestKey5');

			// Create and register the test mediator
			var mediator:IMediator = new Mediator( 'testing', this );
			view.registerMediator( mediator );
			
			// Remove the component
			var removedMediator:IMediator = view.removeMediator( 'testing' ) as IMediator;
			
			// assert that we have removed the appropriate mediator
   			assertTrue( "Expecting removedMediator.getMediatorName() == 'testing'", 
						removedMediator.getMediatorName() == 'testing');
				
			// assert that the mediator is no longer retrievable
   			assertTrue( "Expecting view.retrieveMediator( 'testing' ) == null )", 
   						view.retrieveMediator( 'testing' ) == null );
   						
		}
		
		/**
		 * Tests that the View callse the onRegister and onRemove methods
		 */
		public function testOnRegisterAndOnRemove():void {
			
  			// Get the Multiton View instance
  			var view:IView = View.getInstance('ViewTestKey6');

			// Create and register the test mediator
			var mediator:IMediator = new ViewTestMediator4( this );
			view.registerMediator( mediator );

			// assert that onRegsiter was called, and the mediator responded by setting our boolean
   			assertTrue( "Expecting onRegisterCalled == true", 
						onRegisterCalled);
				
			
			// Remove the component
			view.removeMediator( ViewTestMediator4.NAME ) as IMediator;
			
			// assert that the mediator is no longer retrievable
   			assertTrue( "Expecting onRemoveCalled == true", 
   						onRemoveCalled );
   						
		}
		
		
		
		
		/**
		 * Tests successive regster and remove of same mediator.
		 */
		public function testSuccessiveRegisterAndRemoveMediator():void {
			
  			// Get the Multiton View instance
  			var view:IView = View.getInstance('ViewTestKey7');

			// Create and register the test mediator, 
			// but not so we have a reference to it
			view.registerMediator( new ViewTestMediator( this ) );
			
			// test that we can retrieve it
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator", 
   			view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator );

			// Remove the Mediator
			view.removeMediator( ViewTestMediator.NAME );

			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator.NAME ) == null );

			// test that removing the mediator again once its gone doesn't cause crash 		
   			assertTrue( "Expecting view.removeMediator( ViewTestMediator.NAME ) doesn't crash", 
   			view.removeMediator( ViewTestMediator.NAME ) == void);

			// Create and register another instance of the test mediator, 
			view.registerMediator( new ViewTestMediator( this ) );
			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator", 
   			view.retrieveMediator( ViewTestMediator.NAME ) is ViewTestMediator );

			// Remove the Mediator
			view.removeMediator( ViewTestMediator.NAME );
			
			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator.NAME ) == null );

		}
		
		/**
		 * Tests registering a Mediator for 2 different notifications, removing the
		 * Mediator from the View, and seeing that neither notification causes the
		 * Mediator to be notified. Added for the fix deployed in version 1.7
		 */
		public function testRemoveMediatorAndSubsequentNotify():void {
			
  			// Get the Multiton View instance
  			var view:IView = View.getInstance('ViewTestKey8');
			
			// Create and register the test mediator to be removed.
			view.registerMediator( new ViewTestMediator2( this ) );
			
			// test that notifications work
   			view.notifyObservers( new Notification(NOTE1) );
   			assertTrue( "Expecting lastNotification == NOTE1", 
		   			lastNotification == NOTE1);

   			view.notifyObservers( new Notification(NOTE2) );
   			assertTrue( "Expecting lastNotification == NOTE2", 
		   			lastNotification == NOTE2);

			// Remove the Mediator
			view.removeMediator( ViewTestMediator2.NAME );

			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator2.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator2.NAME ) == null );

			// test that notifications no longer work
			// (ViewTestMediator2 is the one that sets lastNotification
			// on this component, and ViewTestMediator)
			lastNotification = null;
			
   			view.notifyObservers( new Notification(NOTE1) );
   			assertTrue( "Expecting lastNotification != NOTE1", 
		   			lastNotification != NOTE1);

   			view.notifyObservers( new Notification(NOTE2) );
   			assertTrue( "Expecting lastNotification != NOTE2", 
		   			lastNotification != NOTE2);

		}
		
		/**
		 * Tests registering one of two registered Mediators and seeing
		 * that the remaining one still responds.
		 * Added for the fix deployed in version 1.7.1
		 */
		public function testRemoveOneOfTwoMediatorsAndSubsequentNotify():void {
			
  			// Get the Multiton View instance
  			var view:IView = View.getInstance('ViewTestKey9');
			
			// Create and register that responds to notifications 1 and 2
			view.registerMediator( new ViewTestMediator2( this ) );
			
			// Create and register that responds to notification 3
			view.registerMediator( new ViewTestMediator3( this ) );
			
			// test that all notifications work
   			view.notifyObservers( new Notification(NOTE1) );
   			assertTrue( "Expecting lastNotification == NOTE1", 
		   			lastNotification == NOTE1);

   			view.notifyObservers( new Notification(NOTE2) );
   			assertTrue( "Expecting lastNotification == NOTE2", 
		   			lastNotification == NOTE2);

   			view.notifyObservers( new Notification(NOTE3) );
   			assertTrue( "Expecting lastNotification == NOTE3", 
		   			lastNotification == NOTE3);
		   			
			// Remove the Mediator that responds to 1 and 2
			view.removeMediator( ViewTestMediator2.NAME );

			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator2.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator2.NAME ) == null );

			// test that notifications no longer work
			// for notifications 1 and 2, but still work for 3
			lastNotification = null;
			
   			view.notifyObservers( new Notification(NOTE1) );
   			assertTrue( "Expecting lastNotification != NOTE1", 
		   			lastNotification != NOTE1);

   			view.notifyObservers( new Notification(NOTE2) );
   			assertTrue( "Expecting lastNotification != NOTE2", 
		   			lastNotification != NOTE2);

   			view.notifyObservers( new Notification(NOTE3) );
   			assertTrue( "Expecting lastNotification == NOTE3", 
		   			lastNotification == NOTE3);

		}
		
		/**
		 * Tests registering the same mediator twice. 
		 * A subsequent notification should only illicit
		 * one response. Also, since reregistration
		 * was causing 2 observers to be created, ensure
		 * that after removal of the mediator there will
		 * be no further response.
		 * 
		 * Added for the fix deployed in version 2.0.4
		 */
		public function testMediatorReregistration():void {
			
  			// Get the Singleton View instance
  			var view:IView = View.getInstance('ViewTestKey10');
			
			// Create and register that responds to notification 5
			view.registerMediator( new ViewTestMediator5( this ) );
			
			// try to register another instance of that mediator (uses the same NAME constant).
			view.registerMediator( new ViewTestMediator5( this ) );
			
			// test that the counter is only incremented once (mediator 5's response) 
			counter=0;
   			view.notifyObservers( new Notification(NOTE5) );
   			assertEquals( "Expecting counter == 1",  1, counter);

			// Remove the Mediator 
			view.removeMediator( ViewTestMediator5.NAME );

			// test that retrieving it now returns null			
   			assertTrue( "Expecting view.retrieveMediator( ViewTestMediator5.NAME ) == null", 
   			view.retrieveMediator( ViewTestMediator5.NAME ) == null );

			// test that the counter is no longer incremented  
			counter=0;
   			view.notifyObservers( new Notification(NOTE5) );
   			assertEquals( "Expecting counter == 0", 0,  counter);
		}
		
		
		/**
		 * Tests the ability for the observer list to 
		 * be modified during the process of notification,
		 * and all observers be properly notified. This
		 * happens most often when multiple Mediators
		 * respond to the same notification by removing
		 * themselves.  
		 * 
		 * Added for the fix deployed in version 2.0.4
		 */
		public function testModifyObserverListDuringNotification():void {
			
  			// Get the Singleton View instance
  			var view:IView = View.getInstance('ViewTestKey11');
			
			// Create and register several mediator instances that respond to notification 6 
			// by removing themselves, which will cause the observer list for that notification 
			// to change. versions prior to MultiCore Version 2.0.5 will see every other mediator
			// fails to be notified.  
			view.registerMediator( new ViewTestMediator6(  ViewTestMediator6+"/1", this ) );
			view.registerMediator( new ViewTestMediator6(  ViewTestMediator6+"/2", this ) );
			view.registerMediator( new ViewTestMediator6(  ViewTestMediator6+"/3", this ) );
			view.registerMediator( new ViewTestMediator6(  ViewTestMediator6+"/4", this ) );
			view.registerMediator( new ViewTestMediator6(  ViewTestMediator6+"/5", this ) );
			view.registerMediator( new ViewTestMediator6(  ViewTestMediator6+"/6", this ) );
			view.registerMediator( new ViewTestMediator6(  ViewTestMediator6+"/7", this ) );
			view.registerMediator( new ViewTestMediator6(  ViewTestMediator6+"/8", this ) );

			// clear the counter
			counter=0;
			// send the notification. each of the above mediators will respond by removing
			// themselves and incrementing the counter by 1. This should leave us with a
			// count of 8, since 8 mediators will respond.
			view.notifyObservers( new Notification( NOTE6 ) );
			// verify the count is correct
   			assertEquals( "Expecting counter == 8", 8, counter);
	
			// clear the counter
			counter=0;
			view.notifyObservers( new Notification( NOTE6 ) );
			// verify the count is 0
   			assertEquals( "Expecting counter == 0", 0, counter);

		}
		
 	}
}