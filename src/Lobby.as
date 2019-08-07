package
{
   import flash.display.Sprite;
   import flash.display.Bitmap;
   import gui.Alert;
   import mishin870.gui.Chat.Chat;
   import mishin870.gui.Battles.Battles;
   import mishin870.gui.BattleInfo.BattleInfo;
   import mishin870.gui.BattleCreate.BattleCreateWindow;
   import mishin870.gui.Fame;
   import mishin870.gui.Garage.Garage;
   import controls.rangicons.RangIconNormal;
   import mishin870.gui.RankProgress;
   import mishin870.gui.UpPanelButtonClose;
   import mishin870.gui.UpPanelButton;
   import mishin870.gui.menuWindow.menu;
   import mishin870.gui.Crystalls;
   import mishin870.gui.settings.Settings;
   import flash.events.MouseEvent;
   import mishin870.gui.Battles.BattleListItem;
   import mishin870.gui.RankUtils;
   import flash.events.Event;
   
   public class Lobby extends Sprite
   {
      
      [Embed(source = "help.png")] private static const helpClass:Class;
	  [Embed(source = "soff.png")] private static const soffClass:Class;
	  [Embed(source = "son.png")] private static const sonClass:Class;
	  [Embed(source = "sett.png")] private static const settClass:Class;
	  [Embed(source = "refer.png")] private static const referClass:Class;
	  [Embed(source = "battles.png")] private static const battlesClass:Class;
	  [Embed(source = "garage.png")] private static const garageClass:Class;
       
      private var helpImg:Bitmap = new helpClass();
      
      private var soffImg:Bitmap = new soffClass();
      
      private var sonImg:Bitmap = new sonClass();
      
      private var settImg:Bitmap = new settClass();
      
      private var referImg:Bitmap = new referClass();
      
      private var battlesImg:Bitmap = new battlesClass();
      
      private var garageImg:Bitmap = new garageClass();
      
      public var soundOn:Boolean = false;
      
      public var chat:Chat = new Chat();
	  
	  private var menu1:menu = new menu();
      
      public var battles:Battles = new Battles();
      
      public var battleInfo:BattleInfo = new BattleInfo();
      
      public var bcw:BattleCreateWindow = new BattleCreateWindow();
      
      public var garage:Garage = new Garage();
      
      //public var rankIcon:RangIconNormal = new RangIconNormal(1);
      
      public var rankProgress:RankProgress = new RankProgress();
      
      private var bClose:UpPanelButtonClose = new UpPanelButtonClose();
      
      private var bHelp:UpPanelButton = new UpPanelButton();
      
      private var bSound:UpPanelButton = new UpPanelButton();
      
      private var bSett:UpPanelButton = new UpPanelButton();
      
      private var bRefer:UpPanelButton = new UpPanelButton();
      
      private var bBattles:UpPanelButton = new UpPanelButton();
      
      private var bGarage:UpPanelButton = new UpPanelButton();
      
      private var crystalls:Crystalls = new Crystalls();
      
      private var sett:Settings = new Settings();
      
      private var settOverlay:Sprite = new Sprite();
      
      public var userRankNum:int = 0;
      
      public var selBattleId:int = -1;
      
      public function Lobby()
      {
         super();
		 addChild(this.chat);
         addChild(this.battles);
         addChild(this.battleInfo);
         addChild(this.bcw);
         addChild(this.garage);
		 addChild(this.menu1);
         this.battleInfo.visible = false;
		 this.battles.visible = false;
         this.bcw.visible = false;
         //addChild(this.rankIcon);
         this.rankProgress.updateProgress(0,100,0);
         //addChild(this.rankProgress);
         //stage.addEventListener(Event.RESIZE, res);
         this.battleInfo.y = 57;
         this.bcw.y = 57;
		 
         this.rankProgress.x = 59;
         this.crystalls.wid = 110;
         //addChild(this.crystalls);
         //HELP
			prepareButton(bHelp, helpImg);
			//addChild(bHelp);
			
			//SOUND
			prepareButton(bSound, soffImg);
			//addChild(bSound);
			setSound(false);
			bSound.addEventListener(MouseEvent.MOUSE_UP, bSoundMu);
			
			//SETTINGS
			prepareButton(bSett, settImg);
			//addChild(bSett);
			
			//REFERAL
			prepareButton(bRefer, referImg);
			//addChild(bRefer);
			
			//GARAGE
			prepareButton2(bGarage, garageImg, "Гараж");
			addChild(bGarage);
			bGarage.addEventListener(MouseEvent.MOUSE_UP, battlesMu);
			
			//BATTLES
			prepareButton2(bBattles, battlesImg, "Битвы");
			addChild(bBattles);
			bBattles.addEventListener(MouseEvent.MOUSE_UP, garageMu);
			
			//CLOSE
			//addChild(bClose);
		
			
         this.sett.visible = false;
         this.settOverlay.visible = false;
         this.sett.addEventListener(Event.CLOSE,function(param1:Event):void
         {
            settOverlay.visible = false;
            sett.visible = false;
            if(Main.inBattle)
            {
               Main.instance.game.setControlsEnabled(true);
            }
         });
         addChild(this.settOverlay);
         addChild(this.sett);
         this.setPage(0);
      }
	  
	  public function startu() : void
	  {
	  }
      
      private function bSettMu(param1:MouseEvent) : void
      {
         if(Main.isLoading)
         {
            return;
         }
         this.settOverlay.visible = true;
         this.sett.visible = true;
         if(Main.inBattle)
         {
            Main.instance.game.setControlsEnabled(false);
         }
      }
      
      public function prepareToBattle() : void
      {
         this.setPage(0);
         Main.inBattle = true;
         this.chat.visible = false;
         this.battles.visible = false;
      }
      
      public function setMode(param1:int) : void
      {
         if(param1 == 0)
         {
            this.battleInfo.visible = false;
            this.battles.visible = false;
            this.garage.visible = true;
         }
		 if(param1 == 1)
         {
            this.battles.visible = true;
            if(this.battleInfo.firstLoad)
            {
               this.battleInfo.visible = true;
            }
            this.garage.visible = false;
         }
         if(Main.inBattle)
         {
            Main.instance.stopGame();
         }
      }
      
      public function hideAll() : void
      {
         this.battles.visible = false;
         this.chat.visible = false;
         this.battleInfo.visible = false;
         this.bcw.visible = false;
         this.garage.visible = false;
      }
      
      public function selectBattle(param1:BattleListItem) : void
      {
      }
      
      private function updBattle() : void
      {
      }
      
      private function battlesMu(param1:MouseEvent) : void
      {
         if(Main.isLoading)
         {
            return;
         }
         this.setPage(0);
         this.setMode(0);
      }
      
      private function garageMu(param1:MouseEvent) : void
      {
         if(Main.isLoading)
         {
            return;
         }
         this.setPage(1);
         this.setMode(1);
      }
      
      public function setPage(param1:int) : void
      {
         this.bcw.visible = false;
         this.battleInfo.visible = false;
         if(param1 == 0)
         {
            this.bGarage.setEnabled(false);
            this.bBattles.setEnabled(true);
         }
         if(param1 == 1)
         {
            this.bGarage.setEnabled(true);
            this.bBattles.setEnabled(false);
         }
         if(param1 == 2)
         {
            this.bGarage.setEnabled(true);
            this.bBattles.setEnabled(true);
         }
      }
      
      private function bSoundMu(param1:MouseEvent) : void
      {
         this.setSound(!this.soundOn);
      }
      
      public function setSound(param1:Boolean) : void
      {
         this.soundOn = param1;
         this.bSound.setIcon(!!this.soundOn?this.sonImg:this.soffImg);
      }
      
      private function prepareButton(param1:UpPanelButton, param2:Bitmap) : void
      {
         param1.setEnabled(true);
         param1.setIcon(param2);
         param1.setLabel("");
         param1.setWidth(18);
      }
      
      private function prepareButton2(param1:UpPanelButton, param2:Bitmap, param3:String) : void
      {
         param1.setEnabled(true);
         param1.setIcon(param2);
         param1.setWidth(150);
		 param1.setHeight(this.menu1.height);
		 param1.setLabel(param3);
      }
      
      public function setMoney(param1:int) : void
      {
         this.crystalls.setLabel(new String(param1));
         this.crystalls.update();
      }
      
      public function setScore(param1:int) : void
      {
         var _loc2_:int = RankUtils.getRankId(param1);
         this.userRankNum = _loc2_;
         //this.rankIcon.rang = _loc2_ + 1;
         this.rankProgress.setLabel(param1 + " / " + RankUtils.getRankMax(_loc2_) + " " + RankUtils.getRankName(_loc2_) + " " + Main.userName);
         this.rankProgress.updateProgress(RankUtils.rankScores[_loc2_],RankUtils.getRankMax(_loc2_),param1);
      }
      
      private function resizeOverlay(param1:int, param2:int) : void
      {
         this.settOverlay.graphics.clear();
         this.settOverlay.graphics.beginFill(0,0.3);
         this.settOverlay.graphics.drawRect(0,0,param1,param2);
         this.settOverlay.graphics.endFill();
      }
      
      public function res(param1:Number, param2:Number) : void
      {
		 //var _local1:Alert = new Alert();
         //_local1.add = "!";
         this.bClose.x = param1 - 23;
         this.bHelp.x = this.bClose.x - 39;
         this.bSound.x = this.bHelp.x - 29;
         this.bSett.x = this.bSound.x - 29;
         this.bRefer.x = this.bSett.x - 29;
		 this.chat.y = param2 * 0.00555555555555555555555555555556;
		 this.chat.res(int(param1 * 0.296875), int(param2 * 0.98888888888888888888888888888889));
		 this.battles.x = int(param1 / 3);
		 this.battles.y = param2*0.13;
         this.battles.res(int(param1 / 3) * 2,param2*0.85 + 54);
         this.battleInfo.res(int(param1 / 3),param2 - 10);
         this.bcw.res(int(param1 / 3)*2,param2*0.85);
         this.battleInfo.x = int(param1 / 3 * 2);
         this.bcw.x = int(param1 / 3);
         this.bcw.y = param2 * 0.13;
		 prepareButton2(bGarage, garageImg, stage.stageHeight + "");
         this.garage.x = int(param1 * 0.303125);
		 this.garage.y = this.menu1.y + (param2 * 0.12777777777777777777777777777778)-10;//param2*0.1256;
         //this.garage.res(int(param1 * 0.690625), (param2*0.85555555555555555555555555555556));//(,770)0,690625
		 this.garage.res(int(param1 * 0.690625), int(param2));//(,770)0,690625
		 this.menu1.res(this.garage.width, param2*0.12777777777777777777777777777778);
		 this.menu1.x = this.garage.x;
		 this.menu1.y = 0//param2 * 0.0042;
         this.bGarage.x = this.menu1.x + 15;
         this.bGarage.y = 14;
		 this.bBattles.y = 14;
		 this.bBattles.x = this.bGarage.x + this.bGarage.width + 10;
         this.crystalls.x = this.bBattles.x - this.crystalls.width - 10;
         this.crystalls.update();
         this.rankProgress.wid = this.crystalls.x - this.rankProgress.x - 10;
         this.rankProgress.update();
         this.sett.x = int(param1 / 2 - this.sett.width / 2);
         this.sett.y = int(param2 / 2 - this.sett.height / 2);		 
		 this.bGarage.setHeight(param2*0.10777777777777777777777777777778);
		 this.bBattles.setHeight(this.menu1.height-25);
         this.resizeOverlay(param1, param2);
      }
   }
}
