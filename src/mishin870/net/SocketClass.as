package mishin870.net
{
	import flash.events.DataEvent;
	import flash.net.Socket;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	import flash.utils.ByteArray;
	import flash.system.*;
   
	public class SocketClass
	{
		private var callBacks:Vector.<Function> = new Vector.<Function>();
		private var myConn:XMLSocket = new XMLSocket();
       
      public function SocketClass()
      {
		//Security.allowDomain("*"); 
		//Security.loadPolicyFile("policy.xml");
		
      }
      
      public function addListener(param1:Function) : void
      {
         callBacks.push(param1);
      }
      
      public function clearListeners() : void
      {
         callBacks = new Vector.<Function>();
      }
      
      public function removeListener(param1:Function) : void
      {
         var _loc2_:Number = 0;
         while(_loc2_ < callBacks.length)
         {
            if(callBacks[_loc2_] == param1)
            {
               callBacks.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function connect() : void
      {
		//myConn.connect("127.0.0.1", 5482);
		myConn.connect("127.0.0.1", 5482);
		//myConn.addEventListener(Event.CONNECT, on);
		myConn.addEventListener(DataEvent.DATA, sd);
        myConn.addEventListener(Event.CLOSE,sc);
        myConn.addEventListener(IOErrorEvent.IO_ERROR,sc);
        myConn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, sc);
		//myConn.connect("127.0.0.1", 5482);
      }
      
      private function sc(param1:Event) : void
      {
         Main.instance.connectionClosed();
      }
      
      private function sd(param1:DataEvent) : void
      {
		 //throw new Error(param1.data);
		 var _loc3_:int = callBacks.length;
		 while (_loc3_ == 0)
		 {
			
		 }
		 while(_loc3_ > 0)
         {
			//throw new Error(param1.data);
			callBacks[_loc3_-1].call(null,param1.data);
            _loc3_--;
         }
         //for each(var _loc3_:Function in callBacks)
         //{
           // _loc3_.call(null,param1.data);
         //}
      }
      
      public function convert(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_] = param1.charCodeAt(_loc3_);
            _loc3_++;
         }
         return _loc2_.readMultiByte(_loc2_.bytesAvailable,"UTF-8");
      }
      
      public function send(param1:String) : void
      {
         param1 = param1 + ";";
         //socket.writeUTFBytes(param1);
         //socket.flush();
		 myConn.send(param1);
      }
   }
}
