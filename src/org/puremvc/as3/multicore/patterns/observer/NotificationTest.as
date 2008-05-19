/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.multicore.patterns.observer
{
	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
 	
 	import org.puremvc.as3.multicore.interfaces.*;
 	import org.puremvc.as3.multicore.patterns.observer.Notification;
 	
 	/**
	 * Test the PureMVC Notification class.
	 * 
	 * @see org.puremvc.as3.multicore.patterns.observer.Notification Notification
	 */
	public class NotificationTest extends TestCase {
  		
   		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
 	    public function NotificationTest ( methodName:String ) {
   			super( methodName );
           }
  	
 		/**
		 * Create the TestSuite.
		 */
 		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new NotificationTest( "testNameAccessors" ) );
   			ts.addTest( new NotificationTest( "testBodyAccessors" ) );
   			ts.addTest( new NotificationTest( "testConstructor" ) );
   			ts.addTest( new NotificationTest( "testToString" ) );

   			return ts;
   		}
  		

  		/**
  		 * Tests setting and getting the name using Notification class accessor methods.
  		 */
  		public function testNameAccessors():void {

			// Create a new Notification and use accessors to set the note name 
   			var note:INotification = new Notification('TestNote');
   			
   			// test assertions
   			assertTrue( "Expecting note.getName() == 'TestNote'", note.getName() == 'TestNote' );
   		}

  		/**
  		 * Tests setting and getting the body using Notification class accessor methods.
  		 */
  		public function testBodyAccessors():void {

			// Create a new Notification and use accessors to set the body
   			var note:INotification = new Notification(null);
   			note.setBody(5);
   			
   			// test assertions
   			assertTrue( "Expecting note.getBody()as Number == 5", note.getBody() as Number == 5 );
   		}

  		/**
  		 * Tests setting the name and body using the Notification class Constructor.
  		 */
  		public function testConstructor():void {

			// Create a new Notification using the Constructor to set the note name and body
   			var note:INotification = new Notification('TestNote',5,'TestNoteType');
   			
   			// test assertions
   			assertTrue( "Expecting note.getName() == 'TestNote'", note.getName() == 'TestNote' );
   			assertTrue( "Expecting note.getBody()as Number == 5", note.getBody() as Number == 5 );
   			assertTrue( "Expecting note.getType() == 'TestNoteType'", note.getType() == 'TestNoteType' );
   		}
   		
  		/**
  		 * Tests the toString method of the notification
  		 */
  		public function testToString():void {

			// Create a new Notification and use accessors to set the note name 
   			var note:INotification = new Notification('TestNote',[1,3,5],'TestType');
   			var ts:String = "Notification Name: TestNote\nBody:1,3,5\nType:TestType";
   			
   			// test assertions
   			assertTrue( "Expecting note.testToString() == '"+ts+"'", note.toString() == ts );
   		}

  	}
}