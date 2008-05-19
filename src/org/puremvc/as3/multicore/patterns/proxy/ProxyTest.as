/*
 PureMVC - Copyright(c) 2006-08 Futurescale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.multicore.patterns.proxy
{
	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
 	
 	import org.puremvc.as3.multicore.interfaces.*;
 	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
 	
 	/**
	 * Test the PureMVC Proxy class.
	 * 
	 * @see org.puremvc.as3.multicore.interfaces.IProxy IProxy
	 * @see org.puremvc.as3.multicore.patterns.proxy.Proxy Proxy
	 */
	public class ProxyTest extends TestCase {
  		
   		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
 	    public function ProxyTest ( methodName:String ) {
   			super( methodName );
           }
  	
 		/**
		 * Create the TestSuite.
		 */
 		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ProxyTest( "testNameAccessor" ) );
   			ts.addTest( new ProxyTest( "testDataAccessors" ) );
   			ts.addTest( new ProxyTest( "testConstructor" ) );

   			return ts;
   		}
  		

  		/**
  		 * Tests getting the name using Proxy class accessor method. Setting can only be done in constructor.
  		 */
  		public function testNameAccessor():void {

			// Create a new Proxy and use accessors to set the proxy name 
   			var proxy:Proxy = new Proxy('TestProxy');
   			
   			// test assertions
   			assertTrue( "Expecting proxy.getProxyName() == 'TestProxy'", proxy.getProxyName() == 'TestProxy' );
   		}

  		/**
  		 * Tests setting and getting the data using Proxy class accessor methods.
  		 */
  		public function testDataAccessors():void {

			// Create a new Proxy and use accessors to set the data
   			var proxy:Proxy = new Proxy('colors');
   			proxy.setData(['red', 'green', 'blue']);
   			var data:Array = proxy.getData() as Array;
   			
   			// test assertions
   			assertTrue( "Expecting data.length == 3", data.length == 3 );
   			assertTrue( "Expecting data[0] == 'red'", data[0]  == 'red' );
   			assertTrue( "Expecting data[1] == 'green'", data[1]  == 'green' );
   			assertTrue( "Expecting data[2] == 'blue'", data[2]  == 'blue' );
   		}

  		/**
  		 * Tests setting the name and body using the Notification class Constructor.
  		 */
  		public function testConstructor():void {

			// Create a new Proxy using the Constructor to set the name and data
   			var proxy:Proxy = new Proxy('colors',['red', 'green', 'blue']);
   			var data:Array = proxy.getData() as Array;
   			
   			// test assertions
   			assertNotNull( "Expecting proxy not null", proxy );
   			assertTrue( "Expecting proxy.getProxyName() == 'colors'", proxy.getProxyName() == 'colors' );
   			assertTrue( "Expecting data.length == 3", data.length == 3 );
   			assertTrue( "Expecting data[0] == 'red'", data[0]  == 'red' );
   			assertTrue( "Expecting data[1] == 'green'", data[1]  == 'green' );
   			assertTrue( "Expecting data[2] == 'blue'", data[2]  == 'blue' );
   		}

  	}
}