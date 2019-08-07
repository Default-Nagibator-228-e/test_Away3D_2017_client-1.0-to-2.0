package mishin870.gui.rang {
    import flash.display.*;

    public class RangSmall extends Sprite {

        [Embed(source="RangSmall/r1c.png")] private var r1c:Class;
        [Embed(source="RangSmall/r2c.png")] private var r2c:Class;
        [Embed(source="RangSmall/r3c.png")] private var r3c:Class;
        [Embed(source="RangSmall/r4c.png")] private var r4c:Class;
        [Embed(source="RangSmall/r5c.png")] private var r5c:Class;
        [Embed(source="RangSmall/r6c.png")] private var r6c:Class;
        [Embed(source="RangSmall/r7c.png")] private var r7c:Class;
        [Embed(source="RangSmall/r8c.png")] private var r8c:Class;
        [Embed(source="RangSmall/r9c.png")] private var r9c:Class;
        [Embed(source="RangSmall/r10c.png")] private var r10c:Class;
        [Embed(source="RangSmall/r11c.png")] private var r11c:Class;
        [Embed(source="RangSmall/r12c.png")] private var r12c:Class;
        [Embed(source="RangSmall/r13c.png")] private var r13c:Class;
        [Embed(source="RangSmall/r14c.png")] private var r14c:Class;
        [Embed(source="RangSmall/r15c.png")] private var r15c:Class;
        [Embed(source="RangSmall/r16c.png")] private var r16c:Class;
        [Embed(source="RangSmall/r17c.png")] private var r17c:Class;
        [Embed(source="RangSmall/r18c.png")] private var r18c:Class;
        [Embed(source="RangSmall/r19c.png")] private var r19c:Class;
        [Embed(source="RangSmall/r20c.png")] private var r20c:Class;
        [Embed(source="RangSmall/r21c.png")] private var r21c:Class;
        [Embed(source="RangSmall/r22c.png")] private var r22c:Class;
        [Embed(source="RangSmall/r23c.png")] private var r23c:Class;
        [Embed(source="RangSmall/r24c.png")] private var r24c:Class;
        [Embed(source="RangSmall/r25c.png")] private var r25c:Class;
        [Embed(source="RangSmall/r26c.png")] private var r26c:Class;
        [Embed(source="RangSmall/r27c.png")] private var r27c:Class;
        [Embed(source="RangSmall/r26c.png")] private var r28c:Class;
        [Embed(source="RangSmall/r26c.png")] private var r29c:Class;
        [Embed(source = "RangSmall/r27c.png")] private var r30c:Class;
		private var dsfgr:Array = new Array(37);

        public function RangSmall(param1:int)
      {
         super();
         if(param1 < 1 || param1 > 30)
         {
            return;
         }
		 dsfgr[0] = new r1c(); dsfgr[1] = new r2c(); dsfgr[2] = new r3c(); dsfgr[3] = new r4c(); dsfgr[4] = new r5c(); dsfgr[5] = new r6c(); dsfgr[6] = new r7c(); dsfgr[7] = new r8c(); dsfgr[8] = new r9c(); dsfgr[9] = new r10c(); dsfgr[10] = new r11c(); dsfgr[11] = new r12c(); dsfgr[12] = new r13c(); dsfgr[13] = new r14c(); dsfgr[14] = new r15c(); dsfgr[15] = new r16c(); dsfgr[16] = new r17c(); dsfgr[17] = new r18c(); dsfgr[18] = new r19c(); dsfgr[19] = new r20c(); dsfgr[20] = new r21c(); dsfgr[21] = new r22c(); dsfgr[22] = new r23c(); dsfgr[23] = new r24c(); dsfgr[24] = new r25c(); dsfgr[25] = new r26c(); dsfgr[26] = new r27c(); dsfgr[27] = new r28c(); dsfgr[28] = new r1c(); dsfgr[29] = new r1c();
         //var _loc2_:Class = Class.getChildByName("");
         var _loc3_:Bitmap = dsfgr[param1 - 1];
         addChild(_loc3_);
      }
        public function setRank(param1:int):void{
            var _local3:Bitmap = dsfgr[param1 - 1];;
            removeChildAt(0);
            addChild(_local3);
        }

    }
}
