package org.puremvc.as3.multicore.core
{
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class ModelTestProxy extends Proxy
	{
		public static const NAME:String = 'ModelTestProxy';
		public static const ON_REGISTER_CALLED:String = 'onRegister Called';
		public static const ON_REMOVE_CALLED:String = 'onRemove Called';

		public function ModelTestProxy()
		{
			super(NAME, '');
		}

		override public function onRegister():void
		{
			setData(ON_REGISTER_CALLED);
		}		

		override public function onRemove():void
		{
			setData(ON_REMOVE_CALLED);
		}		
	}
}