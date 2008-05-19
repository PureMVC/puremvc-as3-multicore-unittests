/*
 PureMVC - Copyright(c) 2006-08 Futurecale, Inc., Some rights reserved.
 Your reuse is governed by Creative Commons Attribution 2.5 License
*/
package org.puremvc.as3.multicore.core
{
	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
 	
 	import org.puremvc.as3.multicore.core.*;
 	import org.puremvc.as3.multicore.interfaces.*;
 	import org.puremvc.as3.multicore.patterns.proxy.*;
  	
 	/**
	 * Test the PureMVC Model class.
	 */
	public class ModelTest extends TestCase {
  		
   		/**
  		 * Constructor.
  		 * 
  		 * @param methodName the name of the test method an instance to run
  		 */
 	    public function ModelTest( methodName:String ) {
   			super( methodName );
           }
  	
 		/**
		 * Create the TestSuite.
		 */
 		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			
   			ts.addTest( new ModelTest( "testGetInstance" ) );
   			ts.addTest( new ModelTest( "testRegisterAndRetrieveProxy" ) );
   			ts.addTest( new ModelTest( "testRegisterAndRemoveProxy" ) );
   			ts.addTest( new ModelTest( "testHasProxy" ) );
   			ts.addTest( new ModelTest( "testOnRegisterAndOnRemove" ) );
   			return ts;
   		}
  		
  		/**
  		 * Tests the Model Multiton Factory Method 
  		 */
  		public function testGetInstance():void {
   			// Test Factory Method
   			var model:IModel = Model.getInstance('ModelTestKey1');
   			
   			// test assertions
   			assertNotNull( "Expecting instance not null", model );
   			assertTrue( "Expecting instance implements IModel", model is IModel);
   		}

  		/**
  		 * Tests the proxy registration and retrieval methods.
  		 * 
  		 * <P>
  		 * Tests <code>registerProxy</code> and <code>retrieveProxy</code> in the same test.
  		 * These methods cannot currently be tested separately
  		 * in any meaningful way other than to show that the
  		 * methods do not throw exception when called. </P>
  		 */
  		public function testRegisterAndRetrieveProxy():void {
  			
   			// register a proxy and retrieve it.
   			var model:IModel = Model.getInstance('ModelTestKey2');
			model.registerProxy( new Proxy( 'colors', ['red', 'green', 'blue'] ) );
			var proxy:Proxy = model.retrieveProxy('colors') as Proxy;
			var data:Array = proxy.getData() as Array;
			
			// test assertions
   			assertNotNull( "Expecting data not null", data );
   			assertTrue( "Expecting data type is Array", data is Array );
   			assertTrue( "Expecting data.length == 3", data.length == 3 );
   			assertTrue( "Expecting data[0] == 'red'", data[0]  == 'red' );
   			assertTrue( "Expecting data[1] == 'green'", data[1]  == 'green' );
   			assertTrue( "Expecting data[2] == 'blue'", data[2]  == 'blue' );
   		}
  		
  		/**
  		 * Tests the proxy removal method.
  		 */
  		public function testRegisterAndRemoveProxy():void {
  			
   			// register a proxy, remove it, then try to retrieve it
   			var model:IModel = Model.getInstance('ModelTestKey3');
   			var proxy:IProxy = new Proxy( 'sizes', ['7', '13', '21']);
			model.registerProxy( proxy );

			// remove the proxy
			var removedProxy:IProxy = model.removeProxy('sizes');
			
			// assert that we removed the appropriate proxy
   			assertTrue( "Expecting removedProxy.getProxyName() == 'sizes'", 
   						removedProxy.getProxyName() == 'sizes' );
			
			// ensure that the proxy is no longer retrievable from the model
			proxy = model.retrieveProxy( 'sizes' );
			
			// test assertions
   			assertNull( "Expecting proxy is null", proxy );
   		}
  		
  		/**
  		 * Tests the hasProxy Method
  		 */
  		public function testHasProxy():void {
  			
   			// register a proxy
   			var model:IModel = Model.getInstance('ModelTestKey4');
   			var proxy:IProxy = new Proxy( 'aces', ['clubs', 'spades', 'hearts', 'diamonds']);
			model.registerProxy( proxy );
			
   			// assert that the model.hasProxy method returns true
   			// for that proxy name
   			assertTrue( "Expecting model.hasProxy('aces') == true", 
   						model.hasProxy('aces') == true);
			
			// remove the proxy
			model.removeProxy('aces');
			
   			// assert that the model.hasProxy method returns false
   			// for that proxy name
   			assertTrue( "Expecting model.hasProxy('aces') == false", 
   						model.hasProxy('aces') == false);
   		}
  		
		/**
		 * Tests that the Model calls the onRegister and onRemove methods
		 */
		public function testOnRegisterAndOnRemove():void {
			
  			// Get a Multiton View instance
  			var model:IModel = Model.getInstance('ModelTestKey4');

			// Create and register the test mediator
			var proxy:IProxy = new ModelTestProxy( );
			model.registerProxy( proxy);

			// assert that onRegsiter was called, and the proxy responded by setting its data accordingly
   			assertTrue( "Expecting proxy.getData() == ModelTestProxy.ON_REGISTER_CALLED", 
						proxy.getData() == ModelTestProxy.ON_REGISTER_CALLED );
			
			// Remove the component
			model.removeProxy( ModelTestProxy.NAME );
			
			// assert that onRemove was called, and the proxy responded by setting its data accordingly
   			assertTrue( "Expecting proxy.getData() == ModelTestProxy.ON_REMOVE_CALLED", 
						proxy.getData() == ModelTestProxy.ON_REMOVE_CALLED );
			
		}


  	}
}